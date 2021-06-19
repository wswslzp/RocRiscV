package Sim.RocRVSim

import spinal.core._
import spinal.lib._
import Config._
import PipelineCpu._
import spinal.core.sim._

trait RocRVDut {
  def getPC: BigInt
  def getRVCfg: RocRvConfig
  def initL1DCache(content: Seq[Int]): Unit
  def initL1ICache(hexFile: String, offset: Int): Unit
  def getL1CacheSize: Int

  def initDCacheWithZeros(): Unit = {
    initL1DCache(Seq.fill(1 << getL1CacheSize)(0))
  }
}

class FiveStageCpuDut(cfg: RocRvConfig) extends FiveStagesCpu(cfg) with RocRVDut {
  fetch.pc.simPublic()

  override def getPC: BigInt = {
    fetch.pc.toBigInt
  }

  override def getL1CacheSize = 20

  override def getRVCfg = cfg

  override def initL1DCache(content: Seq[Int]): Unit = initDataRam(content)

  override def initL1ICache(hexFile: String, offset: Int): Unit = initCodeRom(hexFile, offset)
}

/**
 * The top module wraps the DUT CPU
 * @param rvDut a lambda function to produce the DUT CPU
 */
class RocRvTestTop[T <: RocRVDut](rvDut: () => T) extends Component {
  val ascii_instr = in Bits(1024 bit)
  val dut = rvDut()

  def getPC: BigInt = dut.getPC

  def pushAsciiInstr(instr: String): Unit = {
    val instrChar = instr.toCharArray
    require(instrChar.length * 8 < 1024, "ASCII instruction is too long, longer than 1024 bit")
    val rValue = instrChar.map {c=>
      // each char to his bin string represent,
      // then convert to a char array consisted of '0' and '1'
      // then pad 0 at the MSB to 8 bit per char
      // finally convert by to bin string
      new String(c.toBinaryString.toCharArray.reverse.padTo(8, '0').reverse)
    }.reduce(_ + _)
    ascii_instr #= BigInt(rValue, 2)
  }
}

object RocRVDutMain {
  def main(args: Array[String]): Unit = {
//    val top = ()=> new Component {
//      override type RefOwnerType = this.type
//      val a = in UInt(8 bit)
//      val b = out Bits(8 bit)
//      b := ~(a.asBits)
//    }
//    SpinalVerilog(top())
    val top = new RocRvTestTop(
      () => new FiveStageCpuDut(RocRvConfig())
    )
  }
}