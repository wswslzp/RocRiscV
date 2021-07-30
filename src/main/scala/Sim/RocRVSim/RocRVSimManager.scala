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
  var timeLimit = 100000
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
    println(Console.RED + "FAIL: " + msg)
    simSuccess()
  }
  def runSim(): Unit = {
    preSimTaskList.foreach({blk=> blk()})
    top.clockDomain.forkStimulus(2)
    top.clockDomain.waitSampling()
    forkJoin(simTaskList:_*)
  }
}
