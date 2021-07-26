package Sim.RocRVSim

import spinal.core._
import spinal.core.sim._
import scala.beans.BeanProperty
import scala.collection.mutable

class RocRVSimManager[T <: RocRVDut] {
  val preSimTaskList = mutable.ArrayBuffer[() => Unit]()
  val simTaskList = mutable.ArrayBuffer[() => Unit]()
  val postSimTaskList = mutable.ArrayBuffer[() => Unit]()
  @BeanProperty
  var timeLimit = 10000000
  @BeanProperty
  var top: RocRvTestTop[T] = null.asInstanceOf[RocRvTestTop[T]]

  def onReset(block: => Unit): Unit = preSimTaskList.append(() => block)
  def initial(block: => Unit): Unit = simTaskList.prepend(() => block)
  def always(block: => Unit): Unit = simTaskList.append(() => {
    while(true) {
      top.clockDomain.waitSampling()
      block
    }
  })
  def onExit(block: => Unit): Unit = postSimTaskList.append(() => block)

  def success(): Unit = {
    postSimTaskList.foreach(_())
    simSuccess()
  }
  def fail(msg: String = ""): Unit = {
    postSimTaskList.foreach(_())
    simFailure(msg)
  }
  def runSim(rocRVTest: RocRVTest[T]): Unit = {
    onReset {
      val start_pc = BigInt(top.dut.getRVCfg.initPcAddr)
      println(s"pc: ${start_pc.toString(16)}, inst: ${rocRVTest.iAddrInstrMap(start_pc)}")
      top.pushAsciiInstr(rocRVTest.iAddrInstrMap(start_pc))
    }
    initial {
      top.clockDomain.waitSampling(timeLimit)
      simFailure("The test reach the time limit, possibly due to the deadlock in the design. Fix it or enlarge the limit.")
    }
    always {
      val pc = top.getPC
      val inst = rocRVTest.iAddrInstrMap.getOrElse(pc, "nop")
      println(s"pc: ${pc.toString(16)}, inst: $inst")
      top.pushAsciiInstr(inst)
    }
    preSimTaskList.foreach({blk=> blk()})
    top.clockDomain.forkStimulus(2)
    top.clockDomain.waitSampling()
    forkJoin(simTaskList:_*)
  }
}
