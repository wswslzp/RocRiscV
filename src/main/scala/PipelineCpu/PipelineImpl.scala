package PipelineCpu

import spinal.core._
import spinal.lib._

import scala.collection.mutable

class StageReg[T <: Data](_dataType: => T) extends HardType[T](_dataType) with Nameable {
  def dataType: T = apply()
  setWeakName(this.getClass.getSimpleName.replace("$", ""))
}

class Stage extends Nameable {
  private val regMaps = mutable.HashMap[StageReg[Data], Data]()
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
  def add[T <: Data](reg: StageReg[T])(output: => T): Stage = {
    if(regMaps.contains(reg.asInstanceOf[StageReg[Data]])) {
      purifyReg(reg)
      regMaps(reg.asInstanceOf[StageReg[Data]]).setAsReg() := output
    }
    else {
      // note: don't use cloneOf(output) to take place of reg().
      //  Replicated redundant logic will be generated!!
      val outputReg = Reg(reg()).setPartialName(this, reg.getName())
      outputReg := output
      regMaps += reg.asInstanceOf[StageReg[Data]] -> outputReg
    }
    this
  }
  def get[T <: Data](reg: StageReg[T]): T = {
    regMaps.getOrElseUpdate(reg.asInstanceOf[StageReg[Data]], defaultValue = {
      if(isFirstStage){
        SpinalWarning(s"The reg `${reg.getName()}` has not been created before and the assignment may be incomplete.")
        val newReg = Reg(reg()).setPartialName(this, reg.getName())
        newReg.allowPruning().allowSimplifyIt()
        newReg
      } else {
        val prevReg = prevStage.get(reg)
        val currReg = Reg(reg()).setPartialName(this, reg.getName())
        currReg := prevReg // todo Directly assignment leads to error when `get` is invoked before `add`
        currReg
      }
    }).asInstanceOf[T]
  }
  def purifyReg[T <: Data](reg: StageReg[T]): Stage = {
    if(regMaps.contains(reg.asInstanceOf[StageReg[Data]])) {
      if(!isFirstStage && prevStage.regMaps.contains(reg.asInstanceOf[StageReg[Data]])) {
        prevStage.purifyReg(reg)
      }
      regMaps(reg.asInstanceOf[StageReg[Data]]).purify()
    }
    this
  }
  @deprecated("Now using `get` method can automatically pass next.")
  def passNext[T <: Data](reg: StageReg[T]): Stage = {
    nextStage.add(reg){
      get[T](reg)
    }
  }
}

trait PipelineImpl extends Nameable {
  val stage: Vector[Stage]
  def concatStage(): Unit = stage.dropRight(1).zip(stage.drop(1)).foreach{case(cur, nex)=>
    cur.setNextStage(nex)
    nex.setPrevStage(cur)
  }

  Component.current.addPrePopTask(() => concatStage())
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
      stage.head.get(regB) ? stage.head.get(regA)(31 downto 16) | stage.head.get(regA)(15 downto 0)
    }
    stage.last.add(regD){
      stage.head.get(regA).subdivideIn(2 slices).reduce(_ | _)
    }

    io.data_c := stage.last.get(regC)
    io.data_d := stage.last.get(regD)
  }

  def main(args: Array[String]): Unit = {
    SpinalConfig(targetDirectory = "rtl").generateVerilog(StageTestComp())
  }
}
