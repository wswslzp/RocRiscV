package PipelineCpu

import spinal.core._
import spinal.lib._

import scala.collection.mutable

sealed trait StageRegCommonType
class StageReg[T <: Data](_dataType: => T) extends HardType[T](_dataType) with Nameable with StageRegCommonType {
  def dataType: T = apply()
  setWeakName(this.getClass.getSimpleName.replace("$", ""))
}

// todo: flush, stall signals should be defined as set
case class StageRegProperty[T <: Data](
                                        var hardReg: T,
                                        var assignment: () => T = null
                                      ){
  var startPrevStage: Stage = _
  val flushSignals = mutable.HashSet[Bool]()
  val stallSignals = mutable.HashSet[Bool]()
  def isAssigned: Boolean = assignment != null
  def isFlushable: Boolean = flushSignals.nonEmpty
  def isStallable: Boolean = stallSignals.nonEmpty
  def hasUnusedStage: Boolean = startPrevStage != null
}

class Stage extends Nameable {
  private val regProperty = mutable.HashMap[StageReg[Data], StageRegProperty[Data]]()
  private val stageStallSignals = mutable.HashSet[Bool]()
  private val stageFlushSignals = mutable.HashSet[Bool]()
  private var nextStage: Stage = _
  private var prevStage: Stage = _

  def setNextStage(stage: Stage): Unit = {
    nextStage = stage
  }
  def setPrevStage(stage: Stage): Unit = {
    prevStage = stage
  }

  def isFirstStage = prevStage == null
  def isLastStage = nextStage == null

  def add[T <: Data](reg: StageReg[T])(output: T): Stage = {
    if(regProperty.contains(reg.asInstanceOf[StageReg[Data]])) {
      regProperty(reg.asInstanceOf[StageReg[Data]]).assignment = () => output
      regProperty(reg.asInstanceOf[StageReg[Data]]).startPrevStage = prevStage
    }
    else {
      // note: don't use cloneOf(output) to take place of reg().
      //  Replicated redundant logic will be generated!!
      val outputReg = Reg(reg()).setPartialName(this, reg.getName())
      regProperty += reg.asInstanceOf[StageReg[Data]] -> StageRegProperty(outputReg, ()=>output).asInstanceOf[StageRegProperty[Data]]
    }
    this
  }

  def get[T <: Data](reg: StageReg[T]): T = {
    regProperty.getOrElseUpdate(reg.asInstanceOf[StageReg[Data]], defaultValue = {
      if(isFirstStage){
        SpinalWarning(s"The reg `${reg.getName()}` has not been created before and the assignment may be incomplete.")
        val newReg = Reg(reg()).setPartialName(this, reg.getName())
        newReg.allowPruning().allowSimplifyIt()
        StageRegProperty(newReg)
      } else {
        val prevReg = prevStage.get(reg)
        val currReg = Reg(reg()).setPartialName(this, reg.getName())
        StageRegProperty(currReg, ()=>prevReg)
      }
    }).hardReg.asInstanceOf[T]
  }

  def stallBy(reg: StageRegCommonType*)(sigs: Bool*): Stage = {
    reg.foreach{sReg=>
      require(regProperty.contains(sReg.asInstanceOf[StageReg[Data]]))
      sigs.foreach(sig=> regProperty(sReg.asInstanceOf[StageReg[Data]]).stallSignals += sig)
    }
    this
  }
  def stallBy(sigs: Bool*): Stage = {
    sigs.foreach(sig=> stageStallSignals += sig)
    this
  }

  def flushBy(reg: StageRegCommonType*)(sigs: Bool*): Stage = {
    reg.foreach{sReg=>
      require(regProperty.contains(sReg.asInstanceOf[StageReg[Data]]))
      sigs.foreach(sig=> regProperty(sReg.asInstanceOf[StageReg[Data]]).flushSignals += sig)
    }
    this
  }
  def flushBy(sigs: Bool*): Stage = {
    sigs.foreach(sig=> stageFlushSignals += sig)
    this
  }

  def purifyReg[T <: Data](reg: StageReg[T]): Stage = {
    if(regProperty.contains(reg.asInstanceOf[StageReg[Data]])) {
      if(!isFirstStage && prevStage.regProperty.contains(reg.asInstanceOf[StageReg[Data]])) {
        prevStage.purifyReg(reg)
      }
      regProperty(reg.asInstanceOf[StageReg[Data]]).hardReg.purify()
    }
    this
  }

  def build(): Unit = {
    // todo: here we solve the problem of missing assignments,
    //  but introducing a hidden danger of making replicated logic.
    // note: run the every assignment `op` before actually assignment `op()` to the register.
    //  consider that `get` api is invoked inside the `add` api invoking.
    regProperty.valuesIterator.filter(_.isAssigned).map(_.assignment).foreach(op => op())
    stageStallSignals.foreach{sig=>
      regProperty.valuesIterator.foreach(_.stallSignals += sig)
    }
    stageFlushSignals.foreach{sig=>
      regProperty.valuesIterator.foreach(_.flushSignals += sig)
    }
    regProperty.valuesIterator.filter(_.isAssigned).foreach { p =>
      val hReg = p.hardReg
      // NOTE: To prevent from scope violation occurs in the `when` context,
      //  this statement has to be added!
      hReg.parentScope = Component.current.dslBody
      hReg.init(hReg.getZero) // todo: consider a better reset method.
      val op = p.assignment
      (p.isStallable, p.isFlushable) match {
        case (false, false) =>
          hReg := op()
        case (false, true) =>
          when(p.flushSignals.toSeq.reduceBalancedTree(_ | _)) {
            hReg := hReg.getZero
          } otherwise (
            hReg := op()
            )
        case (true, false) =>
          when(!p.stallSignals.toSeq.reduceBalancedTree(_ & _)) {
            hReg := op()
          }
        case (true, true) =>
          when(p.flushSignals.toSeq.reduceBalancedTree(_ | _)) {
            hReg := hReg.getZero
          } elsewhen (!p.stallSignals.toSeq.reduceBalancedTree(_ & _)) {
            hReg := op()
          }
      }
      regProperty.keysIterator.filter(r=> regProperty(r).hasUnusedStage).foreach{ sReg=>
        regProperty(sReg).startPrevStage.purifyReg(sReg)
      }
    }
  }
}

