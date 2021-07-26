package PipelineCpu

import spinal.core._
import spinal.lib._

import scala.collection.mutable

trait PipelineImpl {
  val stage: Vector[Stage]
  def concatStage(): Unit = stage.dropRight(1).zip(stage.drop(1)).foreach{case(cur, nex)=>
    cur.setNextStage(nex)
    nex.setPrevStage(cur)
  }

  Component.current afterElaboration {
    stage.foreach(_.build())
  }
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
      val data_f = out Bool()
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

    val e_r = RegInit(False)
    io.data_f := False
    when(stage(1).get(regA) =/= 0){
      io.data_f := stage(0).get(regB) ? stage(2).get(regA).msb | stage(2).get(regA).lsb
    }

    stage.last.add(regC){
      stage(3).get(regB) ? stage(3).get(regA)(31 downto 16) | stage(3).get(regA)(15 downto 0)
    }
    stage.last.add(regD){
      stage(3).get(regA).subdivideIn(2 slices).reduce(_ | _)
    }

    stage(0).stallBy(io.stall_0)
    stage(1).stallBy(regA, regB)(io.stall_1)
    stage(3).flushBy(regA)(io.flush_3)
    stage(3).stallBy(regA)(io.stall_1)
    stage.last.flushBy(io.flush_3 & io.stall_1)
    stage(3).stallBy(io.stall_0)

    io.data_c := stage.last.get(regC)
    io.data_d := stage.last.get(regD)
  }

  def main(args: Array[String]): Unit = {
    SpinalConfig(targetDirectory = "rtl").generateVerilog(StageTestComp())
  }
}
