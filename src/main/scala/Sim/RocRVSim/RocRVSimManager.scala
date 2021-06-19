package Sim.RocRVSim

import spinal.core._
import spinal.core.sim._
import scala.beans.BeanProperty
import scala.collection.mutable

class RocRVSimManager[T <: RocRVDut] {
  val simTaskList = mutable.ArrayBuffer[() => Unit]()
  @BeanProperty
  var timeLimit = 10000
  @BeanProperty
  var top: RocRvTestTop[T] = null.asInstanceOf[RocRvTestTop[T]]

  def initial(block: => Unit): Unit = simTaskList.prepend(() => block)
  def always(block: => Unit): Unit = simTaskList.append(() => {
    while(true) {
      block
      top.clockDomain.waitSampling()
    }
  })

  def runSim(rocRVTest: RocRVTest[T]): Unit = {
    initial {
      println("init")
      top.clockDomain.waitSampling(timeLimit)
      simSuccess()
    }
    always {
      val pc = top.getPC
      println(s"pc: ${pc.toString(16)}, inst: ${rocRVTest.iAddrInstrMap(pc)}")
      top.pushAsciiInstr(rocRVTest.iAddrInstrMap(pc))
    }
    println(s"begin")
    top.clockDomain.forkStimulus(2)
    println(s"wait a second")
    top.clockDomain.waitSampling()
    forkJoin(simTaskList:_*)
  }
}
