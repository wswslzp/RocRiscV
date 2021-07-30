package CpuTest

import spinal.core._
import spinal.core.sim._
import spinal.lib._
import PipelineCpu._
import Config.RocRvConfig
import Sim.RocRVSim.RocRVTest._
import Sim.RocRVSim._

import java.io.File

object RegressionTestSuite {
  val test_dir = "/mnt/d/lzp/riscv/am-kernels/tests/cpu-tests/build"

  val test_cases: List[String] = new File(test_dir).listFiles().map(_.getAbsolutePath).filter(_.matches(".*.elf")).toList

}

object FiveStagesCpuTest extends App{
  import RegressionTestSuite.test_cases
  import scala.collection.mutable
  def formatHex(dat: BigInt, width: Int = 64): String = {
    val hex_str = dat.toString(16)
    assert(width/4 >= hex_str.length, s"Provided width $width is less than input data bit width ${hex_str.length * 4}")
    val pos_prefix = "0" * (width/4 - hex_str.length)
    pos_prefix + hex_str
  }

  val tot_case_num = test_cases.length
  var pass_case_num = 0
  val result_queue = mutable.Queue[String]()

  var simConfig: SpinalSimConfig = SimConfig.allOptimisation.workspacePath("tb")
  //  val test =  RiscVSim
//    .compile("../am-kernels/tests/cpu-tests/build/bit-riscv64-mycpu.elf")
//    .simulate(new FiveStageCpuDut(RocRvConfig()))
  val test =  RiscVSim.simulate(new FiveStageCpuDut(RocRvConfig())).configAs(simConfig)

  test onExit {
    import java.io.{File, PrintWriter}
    val writer = new PrintWriter(new File("tb/final_data_rom_content.txt"))
    for(ind <- 0 until (1 << 20)) {
      val dat = test.dut.dataCache.getBigInt(ind)
      writer.println(s"${BigInt(ind << 3).toString(16)}: ${formatHex(dat)}")
    }
    writer.close()
  }
  test always {
    if (test.dut.memAccess.memwb_inst.toLong == 0x6b) {
      println(Console.GREEN + "Program comes to end.")
      if (test.dut.decode.regf(10).toBigInt == 0) {
        result_queue.enqueue(test._srcFilePath + ": " + Console.GREEN + "PASS")
        pass_case_num += 1
        test.success()
      }
      else {
        test.dut.clockDomain.waitSampling(100)
        result_queue.enqueue(test._srcFilePath + ": " + Console.RED + "FAIL")
        if (test.dut.dataCache.getBigInt(0x8fff0L >> 3) == BigInt("cccc888844440000", 16)) {
          test.fail(s"The return value is ${test.dut.decode.regf(10).toBigInt}")
        } else {
          test.fail("Time limit reach. ABORT!")
        }
      }
    }
  }
  test.runtimeRecord()
  test.timeLimitOn(100000)
  //  test !
  for (tc <- test_cases){
    test.run(tc)
  }
  println("TEST RESULT:")
  for(res <- result_queue){
    println(res)
  }
  println(s"Total ${pass_case_num}/${tot_case_num} test PASS!")


}
