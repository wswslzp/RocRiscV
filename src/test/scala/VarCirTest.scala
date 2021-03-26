import spinal.core._
import spinal.core.sim._
import spinal.lib._

import java.io.File

object VarCirTest extends App{
  case class VarCir(n: Int) extends Component {
    val io = new Bundle {
      val xin = in Bits(3 bit)
      val xout = out Bits(3 bit)
    }

    var tmp: Bits = cloneOf(io.xin)
    tmp := io.xin
    for(_ <- 0 until n){
        tmp \= RegNext(tmp) init 0
    }
    io.xout := tmp
  }

  new File("rtl").mkdir()
  SpinalConfig(targetDirectory = "rtl").generateVerilog(VarCir(4))
}
