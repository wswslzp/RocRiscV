package Config

import spinal.core._
import spinal.lib._
import Cache._

case class RocRvConfig(
                      dataWidth: Int = 64,
                      addrWidth: Int = 64
                      ) {
  def initPcAddr: Int = 0
  def defaultInstCacheConfig: CacheConfig = CacheConfig(
    cacheReadWritePolicy = new CacheReadWritePolicy(ReadAllocate, WriteThrough, WriteAllocate),
    axi4Config = CacheConfig.defaultAxiCfg, cacheBlockSize = 32, addrWidth = addrWidth
  )
  def defaultDataCacheConfig: CacheConfig = CacheConfig(
    cacheReadWritePolicy = new CacheReadWritePolicy(ReadAllocate, WriteThrough, WriteAllocate),
    axi4Config = CacheConfig.defaultAxiCfg, cacheBlockSize = 32, addrWidth = addrWidth, dataWidth = dataWidth
  )
}
