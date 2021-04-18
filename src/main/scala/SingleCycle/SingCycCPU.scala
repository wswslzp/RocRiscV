package SingleCycle

import spinal.core._
import spinal.lib._
import Config._
//import Cache.DirectMapCache

// TODO: RV32C compression instruction support
/**
 * Single module single cycle RISC-V CPU. All submodules reside in `Area`
 * @param cfg Roc RiscV config
 */
case class SingCycCPU(cfg: RocRvConfig) extends Component {
  val io = new Bundle {
    val test = new Bundle {
      val regAddr = in UInt(5 bit)
      val regValue = out Bits(cfg.dataWidth bit)
    }
    val error = out Bool() // todo: including decoding errors
  }

  //  val instructionCache = DirectMapCache(cfg.defaultInstCacheConfig)
  val instructionCache = Mem(Bits(32 bit), BigInt(1) << 20)
  val dataCache = Mem(Bits(cfg.dataWidth bit), BigInt(1) << 20)

  val regFile = new Area {
    val regf = Vec(Reg(Bits(cfg.dataWidth bit)), 32)
    regf.foreach(r=> r.init(0))
    val num1, num2, num3 = UInt(5 bit)
    val (rdata1, rdata2) = (regf.read(num1), regf.read(num2))
    val wdata3 = Bits(cfg.dataWidth bit)
    val we = Bool()
    when(we){
      regf.write(num3, wdata3)
    }
    io.test.regValue := regf(io.test.regAddr)
  }

  val alu = new Area {
    val ctrl = Bits(4 bit)
    val dataA, dataB = SInt(cfg.dataWidth bit)
//    val out = Reg(SInt(cfg.dataWidth bit))
    val out = SInt(cfg.dataWidth bit)
    switch(ctrl){
      is(B"4'b0000"){out := dataA & dataB}
      is(B"4'b0001"){out := dataA | dataB}
      is(B"4'b0010"){out := dataA +| dataB}
      is(B"4'b0110"){out := dataA -| dataB}
      is(B"4'b0111"){out := (dataA < dataB) ? S(1, cfg.dataWidth bit) | S(0, cfg.dataWidth bit)}
      is(B"4'b1100"){out := ~(dataA | dataB)}
      default       {out := 0}
    }
    val zero = out === 0

    val srcSel = Bool()
    dataA := regFile.rdata1.asSInt
  }

  val fetch = new Area {
    val pc = Reg(UInt(cfg.addrWidth bit)) init(cfg.initPcAddr)
    val instrFromCache = instructionCache.readAsync((pc >> 2).resized)
    val naturalNextPc = pc + 4
    val branchOffset = SInt(13 bit)
    val branchNextPc: UInt = ( pc.asSInt + branchOffset ).asUInt
    val nextPcIsBranch = Bool()
    pc := nextPcIsBranch ? branchNextPc | naturalNextPc
    io.error := (instrFromCache === 0) || (instrFromCache === (BigInt(1) << instrFromCache.getWidth)-1)
  }

  val decode = new Area {
    val opcode = fetch.instrFromCache(6 downto 0)
    val rd = fetch.instrFromCache(11 downto 7).asUInt
    val funct3 = fetch.instrFromCache(14 downto 12)
    val rs1 = fetch.instrFromCache(19 downto 15).asUInt
    val rs2 = fetch.instrFromCache(24 downto 20).asUInt
    val funct7 = fetch.instrFromCache(31 downto 25)

    val immGen = new Area {
      val I = funct7 ## rs2
      val S = funct7 ## rd
      val B = funct7.msb ## rd.lsb ## funct7(5 downto 0) ## rd(4 downto 1) ## False
      val U = funct7 ## rs2 ## rs1 ## funct3
      val J = funct7.msb ## rs1 ## funct3 ## rs2.lsb ## funct7(5 downto 0) ## rs2(4 downto 1)
    }
    fetch.branchOffset := immGen.B.asSInt
    regFile.num1 := rs1
    regFile.num2 := rs2
    regFile.num3 := rd

    val aluCtrl = new Area {
      val op = Bits(2 bit)
      alu.ctrl := 0
      switch(op){
        is(B"2'b00"){alu.ctrl := B"4'b0010"}
        is(B"2'b01"){alu.ctrl := B"4'b0110"}
        is(B"2'b10"){
          when(funct7(5) === True){
            when(funct3 === 0){
              alu.ctrl := B"4'b0110"
            }
          } otherwise({
            switch(funct3){
              is(B"3'b000"){alu.ctrl := B"4'b0010"}
              is(B"3'b111"){alu.ctrl := B"4'b0000"}
              is(B"3'b110"){alu.ctrl := B"4'b0001"}
              default      {alu.ctrl := 0}
            }
          })
        }
        default {
          alu.ctrl := 0
        }
      }
    }
  }

  val memAccess = new Area {
    val address = UInt(cfg.addrWidth bit)
    val wr = Bool()
    val en = Bool()
    val dataWrite = Bits(cfg.dataWidth bit)
    val dataRead = Bits(cfg.dataWidth bit)
    when(en){
      dataRead := dataCache.readAsync(address.resized) // due to the single implementation, read has to be async
      dataCache.write(address.resized, dataWrite, wr)
    } otherwise {dataRead := 0}
    alu.dataB := ~alu.srcSel ? regFile.rdata2.asSInt | (
      ( wr ? decode.immGen.S | decode.immGen.I ).asSInt.resize(cfg.dataWidth)
    )
    address := alu.out.asUInt |>> log2Up(cfg.dataWidth/8)
    dataWrite := regFile.rdata2

    val memToReg = Bool()
    regFile.wdata3 := memToReg ? dataRead | alu.out.asBits
  }

  val mainCtrl = new Area {
    alu.srcSel := decode.opcode === M"0-00011" // load or store
    memAccess.memToReg := decode.opcode === B"0100011" // store
    regFile.we := (decode.opcode === B"0000011") || (decode.opcode === B"0110011") // R or load
    memAccess.en := alu.srcSel
    memAccess.wr := memAccess.memToReg
    fetch.nextPcIsBranch := (decode.opcode === B"1100011") && alu.zero // branch
    when(decode.opcode === B"0000011"){
      decode.aluCtrl.op := B"2'b10"
    } elsewhen(decode.opcode === B"1100011"){
      decode.aluCtrl.op := B"2'b01"
    } otherwise({
      decode.aluCtrl.op := 0
    })
  }

  def initCodeRom(hexFilePath: String, offset: Int): Unit = {
    import spinal.lib.misc.HexTools
    HexTools.initRam(instructionCache, hexFilePath, offset)
  }

  def initDataRam(content: Seq[Int]): Unit = {
    dataCache.initBigInt(content.map(BigInt(_)))
  }

}

object SingCycCPU {
  def main(args: Array[String]): Unit = {
    import spinal.core.sim._
//    SpinalConfig(targetDirectory = "rtl").generateVerilog(SingCycCPU(RocRvConfig()))

    SimConfig.withWave.allOptimisation.workspacePath("tb").compile {
      val cpu = SingCycCPU(RocRvConfig())
      cpu.initCodeRom("src/main/resource/rom_code/t1.hex", 0)
      cpu
    }.doSimUntilVoid(0){dut=>
      dut.clockDomain.forkStimulus(2)
      fork {
        SimTimeout(100)
      }
    }
  }
}