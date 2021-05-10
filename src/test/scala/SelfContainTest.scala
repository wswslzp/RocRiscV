import spinal.core._
import spinal.lib._
import spinal.core.sim._

object SelfContainTest extends App{
//  class ClassA() {
//    private var age: Int = 0
//
//    def setAge(classB: ClassB): Unit = {
//      age = classB.age
//      println(s"age is ${age}")
//    }
//  }
//
//  class ClassB(val age: Int) {
//    val a = new ClassA()
//    a.setAge(this)
//  }

  case class TC() extends Component {
    val io = new Bundle {
      val idexpc = in UInt(64 bit)
      val idexj = in Bits(20 bit)
      val npc = out UInt(64 bit)
    }

    io.npc := ( ( io.idexj |<< 1 ).asSInt.resize(64) + io.idexpc.asSInt ).asUInt
  }

//  new ClassB(42)
  SimConfig.withWave.allOptimisation.workspacePath("tb").compile(TC())
    .doSimUntilVoid{dut=>
      dut.io.idexj #= 0
      dut.io.idexpc #= 0
      sleep(10)

      dut.io.idexpc #= 28
      dut.io.idexj #= 0xffff2
      sleep(10)

      println(s"pc = ${dut.io.idexpc.toBigInt.toString(10)}, j = ${dut.io.idexj.toBigInt.toString(10)}, npc = ${dut.io.npc.toBigInt.toString(10)}")
      simSuccess()
    }
}
