package SingleCycle

import spinal.core._
import spinal.lib._
import Config._
import bus.amba4.axi._
import fsm._

case class InstructionMem(cfg: IMemConfig) extends Component {
  import IMemConfig._
  val io = new Bundle {
    val pc = in UInt(log2Up(cfg.depth) bit)
    val instr = out Bits(32 bit)
    val ibus = master(Axi4ReadOnly(axicfg))
  }

  val imem = Mem(Bits(32 bit), BigInt(cfg.depth))

  val memRead = new Area {
    io.instr := imem.readSync(
      address = io.pc
    )
  }

  val memWrite = new Area {
    val ready_r = RegInit(True)

    val readInstrFsm = new StateMachine {
      val ar_fire = new State with EntryPoint
      val r_fire = new State

      ar_fire
        .whenIsActive {
          io.ibus.readCmd.valid.set()
          io.ibus.readCmd.addr := io.pc // todo: first design cache.
        }
    }
  }

  def setIMemInitContent(hexfile: String, offset: BigInt): Unit = {
    import misc.HexTools.initRam
    initRam(imem, hexfile, offset)
  }
}
