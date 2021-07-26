package CpuTest

import spinal.core._
import spinal.core.sim._
import spinal.lib._
import PipelineCpu._
import Config.RocRvConfig
import Sim.RocRVSim.RocRVTest._
import Sim.RocRVSim._

object FiveStagesCpuTest extends App{
  def formatHex(dat: BigInt, width: Int = 64): String = {
    val hex_str = dat.toString(16)
    assert(width/4 >= hex_str.length, s"Provided width $width is less than input data bit width ${hex_str.length * 4}")
    val pos_prefix = "0" * (width/4 - hex_str.length)
    val neg_prefix = "f" * (width/4 - hex_str.length)
    if (hex_str.head > '8') {
      neg_prefix + hex_str
    } else {
      pos_prefix + hex_str
    }
  }

  val test =  RiscVSim
    .compile("../am-kernels/tests/cpu-tests/build/base_mem_acc-riscv64-mycpu.elf")
    .simulate(new FiveStageCpuDut(RocRvConfig()))
//  test always {
//    if (test.dut.io.error.toBoolean) {
////      test.dut.clockDomain.waitSampling(3) // TODO: reconsider judging 0x6b as stopping flag due to pipeline flush
//      simFailure("decoding error")
//    }
//  }
//  test initial {
//    test.dut.clockDomain.waitSampling(5)
//    while(true) {
//      test.dut.clockDomain.waitSampling()
//      if (test.dut.io.error.toBoolean){
//        simFailure("Decoding error")
//      }
//    }
//  }
  test onExit {
    import java.io.{File, PrintWriter}
    val writer = new PrintWriter(new File("tb/final_data_rom_content.txt"))
    for(ind <- 0 until (1 << 20)) {
      val dat = test.dut.dataCache.getBigInt(ind)
      writer.println(s"${BigInt(ind << 3).toString(16)}: ${formatHex(dat)}")
    }
    writer.close()
  }
  test initial {
    import java.io.{File, PrintWriter}
    val writer = new PrintWriter(new File("tb/inst_rom_content.txt"))
    for(ind <- 0 until (1 << 20)) {
      val dat = test.dut.instructionCache.getBigInt(ind)
      writer.println(s"${BigInt(ind << 2).toString(16)}: ${formatHex(dat)}")
    }
    writer.close()
  }
  test initial {
    import java.io.{File, PrintWriter}
    val writer = new PrintWriter(new File("tb/data_rom_content.txt"))
    for(ind <- 0 until (1 << 20)) {
      val dat = test.dut.dataCache.getBigInt(ind)
      writer.println(s"${BigInt(ind << 0).toString(16)}: ${formatHex(dat)}")
    }
    writer.close()
  }
  test always {
    if (test.dut.memAccess.memwb_inst.toLong == 0x6b) {
      println("Program come to over.")
      if (test.dut.decode.regf(10).toBigInt == 0) {
//        println("Program test PASS!")
        test.success()
      }
      else {
        test.fail(s"The return value is ${test.dut.decode.regf(10).toBigInt}")
      }
    }
  }
  test !
}
