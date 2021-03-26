package Cache

import spinal.core._
import spinal.lib._
import spinal.lib.bus.amba4.axi.Axi4

class Cache(cfg: CacheConfig) extends Component {
  val io = new Bundle {
    val cacheIntf = slave(CacheWrIntf(cfg))
    val cacheBus = master(Axi4(cfg.axi4Config))
  }

  /**
   * Get the block address
   * @param inputAddr input address from CPU
   * @return
   */
  protected def getBlockAddr(inputAddr: UInt): UInt = {
    inputAddr(log2Up(cfg.dataWidth)+log2Up(cfg.cacheBlockNum)+log2Up(cfg.cacheBlockSize)-1 downto (log2Up(cfg.dataWidth)+log2Up(cfg.cacheBlockSize)))
  }

  /**
   * Get the word offset inside the block data field.
   * @param inputAddr input address from CPU
   * @return Bit position of offset
   */
  protected def getBlockOffset(inputAddr: UInt): UInt = {
    inputAddr(log2Up(cfg.dataWidth)+log2Up(cfg.cacheBlockSize)-1 downto log2Up(cfg.dataWidth)) << log2Up(cfg.dataWidth)
  }

  /**
   * Get the word offset inside the block data field.
   * @param inputAddr input address from CPU
   * @return Offset number in word
   */
  protected def getBlockOffsetWord(inputAddr: UInt): UInt = {
    inputAddr(log2Up(cfg.dataWidth)+log2Up(cfg.cacheBlockSize)-1 downto log2Up(cfg.dataWidth))
  }

  /**
   * Get the flag field of block data
   * @param inputAddr input address from CPU
   * @return flag field
   */
  protected def getBlockFlag(inputAddr: UInt): Bits = {
    inputAddr(cfg.addrWidth-1 downto ( cfg.addrWidth-log2Up(cfg.getFlagWidth) )).asBits
  }

  /**
   * Get the data word in the block
   * @param blockData The cacheBlock.data field
   * @param offset return of the getBlockOffset()
   * @return data word field
   */
  protected def getBlockWord(blockData: Bits, offset: UInt): Bits = {
    blockData >> offset
  }

  /**
   * Construct the CacheBlock.data from data word
   * @param blockWord
   * @param offset
   * @return
   */
  @deprecated
  protected def getBlockData(blockWord: Bits, offset: UInt): Bits = {
    ( blockWord << offset ).resize(cfg.cacheBlockSize * cfg.dataWidth)
  }

  /**
   * write the aux data of the read address channel
   */
  protected def writeArAuxData(): Unit = {
    io.cacheBus.ar.burst := Axi4.burst.WRAP
    io.cacheBus.ar.size  := U(log2Up(cfg.dataWidth/8))
    io.cacheBus.ar.len   := U(cfg.cacheBlockSize)
    io.cacheBus.ar.cache := Axi4.arcache.BUFFERABLE
  }

  /**
   * write the aux data of the write address channel
   */
  protected def writeAwAuxData(): Unit = {
    io.cacheBus.aw.burst := Axi4.burst.WRAP
    io.cacheBus.aw.size  := U(log2Up(cfg.dataWidth/8))
    io.cacheBus.aw.len   := U(cfg.cacheBlockSize)
    io.cacheBus.aw.cache := Axi4.awcache.BUFFERABLE
  }

}


