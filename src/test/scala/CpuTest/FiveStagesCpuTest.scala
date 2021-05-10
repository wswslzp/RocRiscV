package CpuTest

import spinal.core._
import spinal.core.sim._
import spinal.lib._
import PipelineCpu._
import Config.RocRvConfig

object FiveStagesCpuTest extends App{
  val simConfig = SimConfig.withWave.allOptimisation.workspacePath("tb").compile{
    val cpu = FiveStagesCpu(RocRvConfig())
    cpu.initCodeRom("src/main/resource/test_asm_code/memacc/main.hex", 0)
//    cpu.initDataRam(Seq.fill())
    cpu
  }
  simConfig.doSimUntilVoid(0){dut=>
    dut.clockDomain.forkStimulus(2)
    dut.io.test.regAddr #= 0
    dut.clockDomain.waitSampling()

    forkJoin(
      () => {
        dut.clockDomain.waitSampling(1000)
        simSuccess()
      }
      ,

      () => {
        while(true){
          // todo: try to implement the print function in the test bench.
//          if(dut.memAccess.address.toLong == 0x0110){
//            // Printing buffer address set to 0x0110
//            ???
//          }
          dut.clockDomain.waitSampling()
        }
      }
      ,

      () => {
        while(true){
          if(dut.io.error.toBoolean){
            simFailure("decoding error!")
          }
          dut.clockDomain.waitSampling()
        }
      }
    )
  }
}
