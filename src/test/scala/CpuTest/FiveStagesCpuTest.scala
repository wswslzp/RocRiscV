package CpuTest

import spinal.core._
import spinal.core.sim._
import spinal.lib._
import PipelineCpu._
import Config.RocRvConfig
import Sim.RocRVSim.RocRVTest._
import Sim.RocRVSim._

object FiveStagesCpuTest extends App{
  val test =  RiscVSim
    .compile("src/main/resource/test_asm_code/memacc/main.c")
    .simulate(new FiveStageCpuDut(RocRvConfig()))
  test always {
    if (test.dut.io.error.toBoolean) {
      simFailure("decoding error")
    }
  }
  test.!
}
