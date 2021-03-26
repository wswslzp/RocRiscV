package Cache

import spinal.core._
import spinal.lib._
import bus.amba4.axi._
import fsm._

case class DirectMapCache(cfg: CacheConfig) extends Cache(cfg) {
  // Here we choose ReadAllocate, WriteThrough and WriteAllocate

  val blockAddr = getBlockAddr(io.cacheIntf.addr)
  val inputFlag = getBlockFlag(io.cacheIntf.addr)
  val blockOffset = getBlockOffset(io.cacheIntf.addr)
  val wordOffset = getBlockOffsetWord(io.cacheIntf.addr)

  val mem = Mem(CacheBlock(cfg), BigInt(cfg.cacheBlockNum))
  val block = mem.readSync(
    address = blockAddr, enable = io.cacheIntf.en && (!io.cacheIntf.wr)
  )
  val blockData = RegNext(block.data) // Multi-word data
  val blockWord = getBlockWord(blockData, blockOffset)

  val hit = block.valid && (inputFlag === block.flag)
  val hitRise = hit.rise(False)
  io.cacheIntf.done.clear()

  val missBlockAddr = RegNextWhen(blockAddr, !hit)
  val missBlockFlag = RegNextWhen(inputFlag, !hit)
  val missBlock = CacheBlock(cfg)
  missBlock.valid := True
  missBlock.flag := missBlockFlag
  missBlock.data := 0

  val readTransDone = RegInit(False)
//  mem.write( // todo implement memory writing logic
//    address = hit ? blockAddr | missBlockAddr,
//    data = hit ? () | missBlock,
//    enable = readAllocateValid
//  )

  // Read logic
  // For write allocate, whatever read/write miss, cache will issue read
  // transaction to the ram to fetch the corresponding data.
  val cacheRead = new Area {
    val busData = Reg(Bits(cfg.dataWidth bit))
    val done = RegInit(False)
//    when(!io.cacheIntf.wr) {
//      io.cacheIntf.done := done
//    }
    io.cacheIntf.rdata := hit ? blockWord | busData

    val rready_r = RegInit(False)
    io.cacheBus.r.ready := rready_r

    val shotCounter = Counter(cfg.cacheBlockSize)
    val offsetCount = ( shotCounter.value + wordOffset )(log2Up(cfg.cacheBlockSize)-1 downto 0)
    val missBlockWords = Vec.fill(cfg.cacheBlockSize)(Reg(Bits(cfg.dataWidth bit)))
    missBlock.data := missBlockWords.asBits
    val readBus = new StateMachine {
      val idle     = new State with EntryPoint
      val ar_trans = new State
      val r_trans  = new State

      idle
        .whenIsActive({
          when(hit){
            done := hitRise
          } otherwise {
            done.clear()
          }
          readTransDone.clear()
          io.cacheBus.ar.valid.clear()
          io.cacheBus.r.valid.clear()
          writeArAuxData()
          when(!hit){goto(ar_trans)}
        })

      ar_trans
        .whenIsActive({
          io.cacheBus.ar.valid.set()
          io.cacheBus.ar.addr := io.cacheIntf.addr
          writeArAuxData()
          when(io.cacheBus.ar.fire){
            rready_r.set()
            goto(r_trans)
          }
        })

      r_trans
        .whenIsActive({
          io.cacheBus.ar.valid.clear()
          writeArAuxData()
          when(io.cacheBus.r.fire){
            shotCounter.increment()
            when(shotCounter.value === 0){
              busData := io.cacheBus.r.data
              missBlockWords(offsetCount) := io.cacheBus.r.data
              done.set()
            }
            when(shotCounter.willOverflow){
              goto(idle)
              readTransDone.set()
              rready_r.clear()
            }
          }
        })
    }
  }

  // Write through: when hit, write data inside a whole cache block into cache and ram.
  // Write allocate: when miss, first read data from ram and write through the data into cache and ram.
  val cacheWrite = new Area {
    val done = RegInit(False)
    val writeWords = blockData.subdivideIn(cfg.dataWidth bit)
    val writeTransStart = io.cacheIntf.wr && (hit ? hitRise | readTransDone)
    val shotCounter = Counter(cfg.cacheBlockSize)
    val offsetCounter = (shotCounter.value + wordOffset)(log2Up(cfg.cacheBlockSize)-1 downto 0)

    val writeBus = new StateMachine {
      val idle = new State with EntryPoint
      val aw_trans = new State
      val w_trans = new State

      idle
        .whenIsActive({
          when(writeTransStart){
            goto(aw_trans)
          }
          writeAwAuxData()
          done.clear()
          io.cacheBus.aw.valid.clear()
          io.cacheBus.w.valid.clear()
        })

      aw_trans
        .whenIsActive({
          writeAwAuxData()
          io.cacheBus.w.valid.clear()
          io.cacheBus.aw.valid.set()
          io.cacheBus.aw.addr := io.cacheIntf.addr
          when(io.cacheBus.aw.fire){
            goto(w_trans)
          }
        })

      w_trans
        .whenIsActive({
          writeAwAuxData()
          io.cacheBus.aw.valid.clear()
          io.cacheBus.w.valid.set()
          when(io.cacheBus.w.fire){
            shotCounter.increment()
            when(shotCounter.value === 0){
              io.cacheBus.w.data := io.cacheIntf.wdata
              when(shotCounter.willIncrement){
                done.set()
              } otherwise(done.clear())
            } otherwise({
              io.cacheBus.w.data := writeWords(offsetCounter)
            })
            when(shotCounter.willOverflow){
              goto(idle)
            }
          }
        })
    }
  }

  io.cacheIntf.done := io.cacheIntf.wr ? cacheWrite.done | cacheRead.done
}
