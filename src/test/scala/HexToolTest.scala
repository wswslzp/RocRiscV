import spinal.core._
import spinal.core.sim._
import spinal.lib._

object HexToolTest extends App{
  import misc.HexTools._

  val hexArray = readHexFile("src/main/resource/rom_code/t1.hex", 0)
  hexArray.zipWithIndex.foreach({ case (hexInt, i) =>
    if(hexInt != 0){
      println(s"@${i.toHexString}: ${hexInt.toString(16)}")
    }
  })

//  case class HexToolComp() extends Component {
//    val io = new Bundle {
//      val addr = in UInt(32 bit)
//      val data = out Bits(32 bit)
//    }
//
//    val ram = Mem(cloneOf(io.data), BigInt(1) << 4)
//    io.data := ram.readSync(io.addr.resized)
//
//    initRam(ram, "src/main/resource/rom_code/t1.hex", 0)
//
//  }
//
//  SimConfig.allOptimisation.workspacePath("tb").compile(HexToolComp())
//    .doSimUntilVoid(0){dut=>
//      dut.clockDomain.forkStimulus(2)
//      dut.io.addr #= 0
//      dut.clockDomain.waitSampling()
//
//      fork{
//        while(true){
//          if(dut.io.data.toLong != 0){
//            println(s"@${dut.io.addr.toLong.toHexString}: ${dut.io.data.toLong.toHexString}")
//          }
//          dut.clockDomain.waitSampling()
//        }
//      }
//
//      fork{
//        for(i <- 0 until 1 << 20){
//          dut.io.addr #= i
//          dut.clockDomain.waitSampling()
//        }
//        simSuccess()
//      }
//
//    }
}
