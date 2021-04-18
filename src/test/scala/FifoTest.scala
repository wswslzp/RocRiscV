import spinal.core._
import spinal.core.sim._
import spinal.lib._

object FifoTest extends App{
  import scala.util.Random._
  setSeed(0)
  val inp_v = Vector.tabulate(64){i=>
    i * i
  }
  println(s"input vector is $inp_v")

  var flag = false
  SimConfig
    .withWave
    .allOptimisation
    .workspacePath("tb")
    .compile(StreamFifo(Bits(64 bit), 32))
    .doSim("fifo_tb"){dut=>
      dut.clockDomain.forkStimulus(2)
      dut.io.push.valid #= false
      dut.io.pop.ready #= false
      dut.io.flush #= false

      dut.clockDomain.waitSampling()

      fork{
        SimTimeout(200000)
      }
      forkJoin(
        () => {
          inp_v foreach({d=>
            dut.io.push.valid #= true
            dut.io.push.payload #= d
            dut.clockDomain.waitActiveEdgeWhere(dut.io.push.ready.toBoolean && dut.io.push.valid.toBoolean)
          })
          dut.io.push.valid #= false
          flag = true
        }
        ,

        () => {
//          waitUntil(flag)
          for(i <- inp_v.indices){
            dut.io.pop.ready #= false
            dut.clockDomain.waitSampling(nextInt(10))
            dut.io.pop.ready #= true
            dut.clockDomain.waitActiveEdgeWhere(dut.io.pop.valid.toBoolean && dut.io.pop.ready.toBoolean)
          }
          dut.io.pop.ready #= false
          simSuccess()
        }
      )
    }

}
