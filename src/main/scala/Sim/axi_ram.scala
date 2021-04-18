package Sim

import spinal.core._
import spinal.lib._
import bus.amba4.axi._

case class axi_ram(
                  dataWidth: Int = 32,
                  addrWidth: Int = 16,
                  strbWidth: Int = 4,
                  idWidth  : Int = 8,
                  pipelineOutput: Boolean = false
                  ) extends BlackBox {
  val generic = new Generic {
    val DATA_WIDTH = dataWidth
    val ADDR_WIDTH = addrWidth
    val STRB_WIDTH = strbWidth
    val ID_WIDTH   = idWidth
    val PIPELINE_OUTPUT = pipelineOutput
  }

  val clk = in Bool()
  val rst = in Bool()
  val s_axi = new Bundle {
    val awid = in UInt(idWidth bit)
    val awaddr = in UInt(addrWidth bit)
    val awlen = in UInt(8 bit)
    val awsize = in UInt(3 bit)
    val awburst = in Bits(2 bit)
    val awlock = in Bool()
    val awcache = in Bits(4 bit)
    val awprot = in Bits(3 bit)
    val awvalid = in Bool()
    val awready = out Bool()

    val wdata = in Bits(dataWidth bit)
    val wstrb = in Bits(strbWidth bit)
    val wlast = in Bool()
    val wvalid = in Bool()
    val wready = out Bool()

    val bid = out UInt(idWidth bit)
    val bresp = out Bits(2 bit)
    val bvalid = out Bool()
    val bready = in Bool()

    val arid = in UInt(idWidth bit)
    val araddr = in UInt(addrWidth bit)
    val arlen = in UInt(8 bit)
    val arsize = in UInt(3 bit)
    val arburst = in Bits(2 bit)
    val arlock = in Bool()
    val arcache = in Bits(4 bit)
    val arprot = in Bits(3 bit)
    val arvalid = in Bool()
    val arready = out Bool()

    val rid = out UInt(idWidth bit)
    val rdata = out Bits(dataWidth bit)
    val rresp = out Bits(2 bit)
    val rlast = out Bool()
    val rvalid = out Bool()
    val rready = in Bool()
  }

  mapCurrentClockDomain(clock = clk, reset = rst)
  addRTLPath("src/main/resource/axi_ram.v")

  def connectWith(bus: Axi4): Unit = {
    s_axi.awid := bus.aw.id
    s_axi.awaddr := bus.aw.addr.resized
    s_axi.awlen := bus.aw.len
    s_axi.awsize := bus.aw.size
    s_axi.awburst := bus.aw.burst
    s_axi.awcache := bus.aw.cache
    s_axi.awvalid := bus.aw.valid
    s_axi.awlock := bus.aw.lock.asBool
    s_axi.awprot := bus.aw.prot
    bus.aw.ready := s_axi.awready

    s_axi.wdata := bus.w.data.resized
    s_axi.wstrb := bus.w.strb
    s_axi.wlast := bus.w.last
    s_axi.wvalid := bus.w.valid
    bus.w.ready := s_axi.wready

    s_axi.bready := bus.b.ready
    bus.b.resp := s_axi.bresp
    bus.b.valid := s_axi.bvalid

    s_axi.arid := bus.ar.id
    s_axi.araddr := bus.ar.addr.resized
    s_axi.arlen := bus.ar.len
    s_axi.arsize := bus.ar.size
    s_axi.arburst := bus.ar.burst
    s_axi.arcache := bus.ar.cache
    s_axi.arvalid := bus.ar.valid
    s_axi.arlock := bus.ar.lock.asBool
    s_axi.arprot := bus.ar.prot
    bus.ar.ready := s_axi.arready

    bus.r.data := s_axi.rdata
    bus.r.resp := s_axi.rresp
    bus.r.last := s_axi.rlast
    bus.r.valid := s_axi.rvalid
    s_axi.rready := bus.r.ready
  }
}