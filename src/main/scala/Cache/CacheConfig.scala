package Cache

import spinal.core._
import spinal.lib._
import bus.amba4.axi._

trait ReadMissPolicy
object ReadThrough extends ReadMissPolicy
object ReadAllocate extends ReadMissPolicy

trait WriteMissPolicy
object WriteAllocate extends WriteMissPolicy
object WriteNotAllocate extends WriteMissPolicy

trait WriteHitPolicy
object WriteThrough extends WriteHitPolicy
object WriteBack extends WriteHitPolicy

class CacheReadWritePolicy(
                          val readMissPolicy: ReadMissPolicy,
                          val writeHitPolicy: WriteHitPolicy,
                          val writeMissPolicy: WriteMissPolicy
                          )

case class CacheConfig(
                      addrWidth: Int = 32,
                      dataWidth: Int = 32,
                      cacheBlockNum: Int = 1024,
                      cacheBlockSize: Int = 4,
                      cacheReadWritePolicy: CacheReadWritePolicy,
                      axi4Config: Axi4Config
                      ){
  require(cacheBlockNum > 32 && cacheBlockSize < 16)
  require(isPow2(BigInt(cacheBlockNum)) && isPow2(cacheBlockSize))
  def getCacheDepth: Long = 1L << addrWidth
  def getFlagWidth: Int = addrWidth - log2Up(cacheBlockNum) - log2Up(cacheBlockSize) - 2
}

case class CacheWrIntf(cfg: CacheConfig) extends Bundle with IMasterSlave {
  val addr = UInt(cfg.addrWidth bit)
  val rdata = Bits(cfg.dataWidth bit)
  val wdata = Bits(cfg.dataWidth bit)
  val en = Bool()
  val wr = Bool()
  val done = Bool()

  override def asMaster(): Unit = {
    out(addr, wdata, en, wr)
    in(rdata, done)
  }
}

case class CacheBlock(cfg: CacheConfig) extends Bundle {
  val valid = Bool()
  val dirty = (cfg.cacheReadWritePolicy.writeHitPolicy == WriteBack) generate Bool()
  val flag = Bits(
    cfg.getFlagWidth bit
  )
  val data = Bits(
    cfg.cacheBlockSize * cfg.dataWidth bit
  )
}

object CacheBlock {
  def apply(cfg: CacheConfig, valid: Bool, flag: Bits, data: Bits, dirty: Bool = null): CacheBlock = {
    val ret = CacheBlock(cfg)
    ret.valid := valid
    ret.flag := flag
    ret.data := data
    if(dirty != null) {
      ret.valid := dirty
    }
    ret
  }
}