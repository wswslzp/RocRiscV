package Cache

import spinal.core._
import spinal.lib._
import bus.amba4.axi._
import fsm._

// todo: separate the cache into several relatively independent modules
case class DirectMapCache(cfg: CacheConfig) extends Cache(cfg) {
  // Here we choose ReadAllocate, WriteThrough and WriteAllocate

  val blockAddr = getBlockAddr(io.cacheIntf.addr)
  val inputFlag = getBlockTag(io.cacheIntf.addr)
  val blockOffset = getBlockOffset(io.cacheIntf.addr)
  val inputEnRise = io.cacheIntf.en.rise(False)
  val wordOffset = RegNextWhen(
    getBlockOffsetWord(io.cacheIntf.addr), cond = inputEnRise
  )

  val mem = Mem(CacheBlock(cfg), BigInt(cfg.cacheBlockNum))
  mem.init(Seq.fill(cfg.cacheBlockNum)(CacheBlock(cfg, False, B(0), B(0))))
  val block = mem.readSync(
    address = blockAddr, enable = io.cacheIntf.en
  )
  val blockData = block.data
  val blockWord = getBlockWord(blockData, blockOffset)

  val hit = block.valid && (inputFlag === block.tag) && io.cacheIntf.en
  val hitRise = hit.rise(False)

  val missBlockAddr = RegNextWhen(blockAddr, !hit)
  val missBlockFlag = RegNextWhen(inputFlag, !hit)
  val missBlock = CacheBlock(cfg)
  missBlock.valid := True
  missBlock.tag := missBlockFlag
  val missBlockWords = Vec.fill(cfg.cacheBlockSize)(Reg(Bits(cfg.dataWidth bit)))
  missBlock.data := missBlockWords.asBits

  val readTransDone = RegInit(False)
//
//  // todo: buffer the write transaction into sync fifo
//  val writeTransFifo = StreamFifo(Bits(cfg.addrWidth + cfg.dataWidth bit), cfg.cacheBlockNum)
//  writeTransFifo.io.push.valid := io.cacheIntf.en & io.cacheIntf.wr
//  writeTransFifo.io.push.payload := Cat(io.cacheIntf.addr, io.cacheIntf.wdata)
//  val writeTransExist = writeTransFifo.io.occupancy =/= 0

  // Read logic
  // For write allocate, whatever read/write miss, cache will issue read
  // transaction to the ram to fetch the corresponding data.
  val cacheRead = new Area {
    val busData = Bits(cfg.dataWidth bit)
    busData := 0
    val done = False
    io.cacheIntf.rdata := hit ? blockWord | busData

    val rready_r = RegInit(False)
    io.cacheBus.r.ready := rready_r
    val arTransStart = RegNext(io.cacheIntf.en, False) && io.cacheIntf.en

    val shotCounter = Counter(cfg.cacheBlockSize)
    val offsetCount = ( shotCounter.value + wordOffset )(log2Up(cfg.cacheBlockSize)-1 downto 0)
    writeArAuxData()
    val readBus = new StateMachine {
      val idle     = new State with EntryPoint
      val ar_trans = new State
      val r_trans  = new State

      idle
        .whenIsActive({
          when(hit) {
            done := hitRise
          } otherwise {
            done.clear()
            when(arTransStart){
              rready_r.set()
              goto(ar_trans)
            }
          }
          readTransDone.clear()
          io.cacheBus.ar.valid.clear()
        })

      ar_trans
        .whenIsActive({
          io.cacheBus.ar.valid.set()
          io.cacheBus.ar.addr := io.cacheIntf.addr
          when(io.cacheBus.ar.fire){
            goto(r_trans)
          }
        })

      r_trans
        .whenIsActive({
          hit.clear()
          io.cacheBus.ar.valid.clear()
          when(io.cacheBus.r.fire){
            shotCounter.increment()
          }
          missBlockWords(offsetCount) := io.cacheBus.r.data
          busData := io.cacheBus.r.data
          done := io.cacheBus.r.valid & io.cacheIntf.en
          when(shotCounter.willOverflow){
            goto(idle)
            readTransDone.set()
            rready_r.clear()
          }
        })
    }
  }

  // Write through: when hit, write data inside a whole cache block into cache and ram.
  // Write allocate: when miss, first read data from ram and write through the data into cache and ram.
  val cacheWrite = new Area { // todo: have to support burst write.

    val done = False
    val writeWords = hit ? blockData.subdivideIn(cfg.dataWidth bit) | missBlockWords
    val writeTransStart = io.cacheIntf.wr && (hit ? hitRise | readTransDone)
    val shotCounter = Counter(cfg.cacheBlockSize)
    val offsetCounter = (shotCounter.value + wordOffset)(log2Up(cfg.cacheBlockSize)-1 downto 0)

    writeAwAuxData()
    val writeBus = new StateMachine {
      val idle = new State with EntryPoint
      val aw_trans = new State
      val w_trans = new State

      idle
        .whenIsActive({
          when(writeTransStart){
            missBlockWords(wordOffset) := io.cacheIntf.wdata
            goto(aw_trans)
          }
          done.clear()
          io.cacheBus.aw.valid.clear()
          io.cacheBus.w.valid.clear()
        })

      aw_trans
        .whenIsActive({
          io.cacheBus.w.valid.clear()
          io.cacheBus.aw.valid.set()
          io.cacheBus.aw.addr := io.cacheIntf.addr
          when(io.cacheBus.aw.fire){
            goto(w_trans)
          }
        })

      w_trans
        .whenIsActive({
          io.cacheBus.aw.valid.clear()
          io.cacheBus.w.valid.set()
          when(io.cacheBus.w.fire){
            shotCounter.increment()
          }
          when(shotCounter.value === 0){
            io.cacheBus.w.data := io.cacheIntf.wdata
            when(shotCounter.willIncrement){
              done.set()
            }
          } otherwise({
            done.clear()
            io.cacheBus.w.data := writeWords(offsetCounter)
          })
          when(shotCounter.willOverflow){
            io.cacheBus.w.last.set()
            goto(idle)
          }
        })
    }
  }

  val writeMemAddress = blockAddr
  val writeMemBlock = hit ? block | missBlock
  val writeMemEn = (io.cacheIntf.wr & hit) ? hitRise | RegNext(io.cacheBus.r.valid, False)
  mem.write(
    address = writeMemAddress,
    data = writeMemBlock,
    enable = writeMemEn
  )

  io.cacheIntf.valid := io.cacheIntf.wr ? cacheWrite.done | cacheRead.done
//  io.cacheIntf.valid := io.cacheIntf.wr ? writeTransFifo.io.push.ready | cacheRead.done
}
