package CacheTest

import spinal.core._
import spinal.core.sim._
import spinal.lib._
import Cache._

object Driver {

  /**
   * Initialize the dut interface and bus interface
   * @param dut the cache unit under test
   */
  def driveInit(dut: Cache): Unit = {
    dut.io.cacheIntf.addr #= 0
    dut.io.cacheIntf.wr #= false
    dut.io.cacheIntf.en #= false
    dut.io.cacheIntf.wdata #= 0

    dut.io.cacheBus.aw.valid #= false
    dut.io.cacheBus.w.valid #= false
    dut.io.cacheBus.ar.valid #= false
    dut.io.cacheBus.r.valid #= false
    dut.io.cacheBus.b.ready #= true
  }

  def driveInit(intf: CacheWrIntf): Unit = {
    intf.addr #= 0
    intf.en #= false
    intf.wr #= false
    intf.wdata #= 0
  }

  /**
   * Issue a read transaction
   * @param intf the interface of cache.
   * @param addr the read address.
   * @param cdm the clock domain
   */
  def issueRead(intf: CacheWrIntf, addr: Int, cdm: ClockDomain): Unit = {
    intf.en #= true
    intf.wr #= false
    intf.addr #= addr
    cdm.waitActiveEdgeWhere(intf.valid.toBoolean)
    intf.en #= false
  }

  def issueRead(intf: CacheWrIntf, initAddr: Int, count: Int, cdm: ClockDomain): Unit = {
    val byteCount = intf.cfg.getByteSize
    intf.en #= true
    intf.wr #= false
    Seq.tabulate(count)(i => i*byteCount + initAddr) foreach { addr=>
      intf.addr #= addr
      cdm.waitActiveEdgeWhere(intf.valid.toBoolean)
    }
    intf.en #= false
  }

  def issueWrite(intf: CacheWrIntf, addr: Int, data: Int, cdm: ClockDomain): Unit = {
    intf.en #= true
    intf.wr #= true
    intf.addr #= addr
    intf.wdata #= data
    cdm.waitActiveEdgeWhere(intf.valid.toBoolean)
    intf.en #= false
    intf.wr #= false
  }

}
