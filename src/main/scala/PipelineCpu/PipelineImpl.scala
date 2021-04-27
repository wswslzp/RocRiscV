package PipelineCpu

import spinal.core._
import spinal.lib._

import scala.collection.mutable

class StageReg[T <: Data](_dataType: => T) extends HardType[T](_dataType) with Nameable {
  def dataType: T = apply()
  setWeakName(this.getClass.getSimpleName.replace("$", ""))
}

case class StageRegProperty[T <: Data](
                           var hardReg: T,
                           var assignment: () => T = null,
                           var flushSignal: Bool = null,
                           var stallSignal: Bool = null,
                           var startPrevStage: Stage = null
                           ){
  def isAssigned: Boolean = assignment != null
  def isFlushable: Boolean = flushSignal != null
  def isStallable: Boolean = stallSignal != null
  def hasUnusedStage: Boolean = startPrevStage != null
}

class Stage extends Nameable {
  private val regProperty = mutable.HashMap[StageReg[Data], StageRegProperty[Data]]()
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
        SpinalInfo(s"Create new reg ${reg.getName()} at the beginning.")
        StageRegProperty(newReg)
      } else {
        val prevReg = prevStage.get(reg)
        val currReg = Reg(reg()).setPartialName(this, reg.getName())
        SpinalInfo(s"Get stage reg ${reg.getName()} at ${this.getName()}")
        StageRegProperty(currReg, ()=>prevReg)
      }
    }).hardReg.asInstanceOf[T]
  }

  def stallBy[T <: Data](reg: StageReg[T])(sig: => Bool): Stage = {
    regProperty(reg.asInstanceOf[StageReg[Data]]).stallSignal = sig
    this
  }
  def stallBy(sig: =>Bool): Stage = {
    regProperty.valuesIterator.foreach(_.stallSignal = sig)
    this
  }

  def flushBy[T <: Data](reg: StageReg[T])(sig: => Bool): Stage = {
    regProperty(reg.asInstanceOf[StageReg[Data]]).flushSignal = sig
    this
  }
  def flushBy(sig: => Bool): Stage = {
    regProperty.valuesIterator.foreach(_.flushSignal = sig)
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
    regProperty.valuesIterator.filter(_.isAssigned).map(_.assignment).foreach(op => op())
    regProperty.valuesIterator.filter(_.isAssigned).foreach { p =>
      val hReg = p.hardReg
      val op = p.assignment
      (p.isStallable, p.isFlushable) match {
        case (false, false) =>
          hReg := op()
        case (false, true) =>
          when(p.flushSignal) {
            hReg := hReg.getZero
          } otherwise (
            hReg := op()
          )
        case (true, false) =>
          when(!p.stallSignal) {
            hReg := op()
          }
        case (true, true) =>
          when(p.flushSignal) {
            hReg := hReg.getZero
          } elsewhen (!p.stallSignal) {
            hReg := op()
          }
      }
      regProperty.keysIterator.filter(r=> regProperty(r).hasUnusedStage).foreach{ sReg=>
        SpinalInfo(s"${sReg.getName()} start at ${this.getName()}")
        regProperty(sReg).startPrevStage.purifyReg(sReg)
      }
    }
  }
}

trait PipelineImpl {
  val stage: Vector[Stage]
  def concatStage(): Unit = stage.dropRight(1).zip(stage.drop(1)).foreach{case(cur, nex)=>
    cur.setNextStage(nex)
    nex.setPrevStage(cur)
  }

  Component.current.addPrePopTask(() => {
    stage.foreach(_.build())
  })
}

object PipelineTest {
  case class StageTestComp() extends Component with PipelineImpl {
    override val stage = Vector.fill(5)(new Stage())
    concatStage()
    val io = new Bundle {
      val data_a = in Bits(32 bit)
      val data_b = in Bool()
      val data_c = out Bits(16 bit)
      val data_d = out Bits(16 bit)
      val data_e = out Bool() allowPruning() allowSimplifyIt()
      val stall_0 = in Bool()
      val stall_1 = in Bool()
      val flush_3 = in Bool()
    }

    object regA extends StageReg(cloneOf(io.data_a))
    object regB extends StageReg(cloneOf(io.data_b))
    object regC extends StageReg(cloneOf(io.data_c))
    object regD extends StageReg(cloneOf(io.data_d))
    object regE extends StageReg(Bool())
    stage.head.add(regA)(io.data_a)
    stage.head.add(regB)(io.data_b)
    io.data_e := stage.last.get(regE)
    stage(2).add(regE){io.data_b}

    stage.last.add(regC){
      stage(3).get(regB) ? stage(3).get(regA)(31 downto 16) | stage(3).get(regA)(15 downto 0)
    }
    stage.last.add(regD){
      stage(3).get(regA).subdivideIn(2 slices).reduce(_ | _)
    }

    stage(0).stallBy(io.stall_0)
    stage(1).stallBy(regA)(io.stall_1)
    stage(1).stallBy(regB)(io.stall_1)
    stage(3).flushBy(regA)(io.flush_3)
    stage.last.flushBy(io.flush_3 & io.stall_1)

    io.data_c := stage.last.get(regC)
    io.data_d := stage.last.get(regD)
  }

  def main(args: Array[String]): Unit = {
    SpinalConfig(targetDirectory = "rtl").generateVerilog(StageTestComp())
  }
}
