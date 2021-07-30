package tmp

import spinal.core._
import spinal.core.sim._
import spinal.lib._

object MemReadTest extends App{

  def formatHex(dat: BigInt, width: Int = 32): String = {
    val hex_str = dat.toString(16)
    assert(width/4 >= hex_str.length, s"Provided width $width is less than input data bit width ${hex_str.length * 4}")
    val pos_prefix = "0" * (width/4 - hex_str.length)
    pos_prefix + hex_str
  }

  SimConfig
    .allOptimisation
    .workspacePath("tb")
    .compile{
      new Component {
        override type RefOwnerType = this.type
        val io = new Bundle {
          val raddr = in UInt(8 bit)
          val rdata = out Bits(32 bit)
        }
        val mem = Mem(Bits(32 bit), BigInt(1 << io.raddr.getWidth)) simPublic()
        val content = Seq.tabulate(1 << io.raddr.getWidth){i=>
          import scala.math.pow
          BigInt( ( pow(-1, i) * i ).toInt )
        }
        mem.initBigInt(content, allowNegative = true)
        io.rdata := mem.readSync(io.raddr)
      }
    }
    .doSim{dut=>
      dut.clockDomain.forkStimulus(2)
      dut.clockDomain.waitSampling()

      import java.io.{File, PrintWriter}
      val writer = new PrintWriter(new File("tb/mem_read_test.txt"))
      for(i <- 0 until (1 << dut.io.raddr.getWidth)) {
        writer.println(s"${i << 2}: ${formatHex(dut.mem.getBigInt(i.toLong))}")
      }
      writer.close()
      simSuccess()
    }
}
