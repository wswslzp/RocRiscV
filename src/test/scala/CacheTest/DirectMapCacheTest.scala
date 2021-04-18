package CacheTest

import spinal.core._
import spinal.core.sim._
import spinal.lib._
import Cache._
import spinal.lib.bus.amba4.axi.Axi4Config

object DirectMapCacheTest extends App{
  import CacheConfig._
  import java.io._
  import Sim._

//  new File("rtl/DirectMapCache").mkdir()
//  SpinalConfig(
//    targetDirectory = "rtl/DirectMapCache"
//  ).generateVerilog(DirectMapCache(defaultCacheCfg))

  case class CacheWithAxiRam() extends Component {
    val io = new Bundle {
      val intf = slave(CacheWrIntf(defaultCacheCfg))
    }

    val cache = DirectMapCache(defaultCacheCfg)
    cache.io.cacheIntf <> io.intf
    val mem = axi_ram()
    mem.connectWith(cache.io.cacheBus)
  }

  SimConfig
    .withWave
    .allOptimisation
    .workspacePath("tb")
    .compile(CacheWithAxiRam())
    .doSim("DirectMapCache_tb"){dut=>
      dut.clockDomain.forkStimulus(2)
      Driver.driveInit(dut.io.intf)
      dut.clockDomain.waitSampling()

      fork{
        SimTimeout(200000)
      }

      forkJoin(
        () => {
          // Read Miss first
          Driver.issueRead(dut.io.intf, 0x40, 32, dut.clockDomain)
          dut.clockDomain.waitSampling(10)
          // Read Hit
          Driver.issueRead(dut.io.intf, 0x48, dut.clockDomain)
          dut.clockDomain.waitSampling(10)
          // Write Miss
          Driver.issueWrite(dut.io.intf, 0x10000040, 0x000CAFFE, dut.clockDomain)
          dut.clockDomain.waitSampling(10)
          // Write Hit
          Driver.issueWrite(dut.io.intf, 0x10000080, 0x0000FACE, dut.clockDomain)
          dut.clockDomain.waitSampling(100)

          simSuccess()
        }
      )
    }

}
