package PipelineCpu

import spinal.core._
import spinal.lib._
import Config._

/**
 * An Five stages pipeline RISC-V CPU.
 * Support RV64I, except for `fence`, `ecall`, `ebreak` and csr logic
 * @param cfg
 */
case class FiveStagesCpu(cfg: RocRvConfig) extends FiveStage {
  import DecodingMethod._
  import RiscVISA._
  import ALU_CTRL_CMD._
  // IFID
  object Instruction extends StageReg(Bits(32 bit))
  object PC extends StageReg(UInt(cfg.addrWidth bit))
  // IDEX
  object RS1 extends StageReg(Bits(cfg.dataWidth bit))
  object RS2 extends StageReg(Bits(cfg.dataWidth bit))
  object RDNum extends StageReg(UInt(5 bit))
  object IMM_I extends StageReg(Bits(12 bit))
  object IMM_S extends StageReg(Bits(12 bit))
  object IMM_B extends StageReg(Bits(12 bit))
  object IMM_U extends StageReg(Bits(20 bit))
  object IMM_J extends StageReg(Bits(20 bit))
  object ARITH_TYPE extends StageReg(Bits(4 bit))
  object ALU_SRC_SEL extends StageReg(Bool())
  object ALU_IMM_SRC extends StageReg(Bool())
  object ALU_OP extends StageReg(Bits(2 bit))
  object MEM_TO_REG extends StageReg(Bool())
  object WRITE_REG extends StageReg(Bool())
  object BRANCH extends StageReg(Bool())
  // EXMEM
  object ALU_RESULT extends StageReg(SInt(cfg.dataWidth bit))
  object BRANCH_ASSERT extends StageReg(Bool())
//  object ALU_ZERO extends StageReg(Bool())
//  object ALU_LT extends StageReg(Bool())
//  object ALU_LTU extends StageReg(Bool())
  object BRANCH_ADDR extends StageReg(UInt(cfg.addrWidth bit))
  // MEMWB
  object MEM_RDATA extends StageReg(Bits(cfg.dataWidth bit))

  val io = new Bundle {
    val test = new Bundle {
      val regAddr = in UInt(5 bit)
      val regValue = out Bits(cfg.dataWidth bit)
    }
    val error = out Bool() // todo: including decoding errors
  }

  val instructionCache = Mem(Bits(32 bit), BigInt(1) << 20)
  val dataCache = Mem(Bits(cfg.dataWidth bit), BigInt(1) << 20)

  val fetch = new Area {
    val pc = Reg(UInt(cfg.addrWidth bit)) init(cfg.initPcAddr)
    val instrFromCache = instructionCache.readAsync((pc >> 2).resized)
    val naturalNextPc = pc + 4
    val nextPcIsBranch = EXMEM.get(BRANCH) && EXMEM.get(BRANCH_ASSERT) // Only for `BEQ`
    pc := nextPcIsBranch ? EXMEM.get(BRANCH_ADDR) | naturalNextPc
    io.error := (instrFromCache === 0) || (instrFromCache === (BigInt(1) << instrFromCache.getWidth)-1)

    IFID.add(PC)(pc)
    IFID.add(Instruction)(instrFromCache)
  }

  val decode = new Area {
    val regf = Vec(Reg(Bits(cfg.dataWidth bit)), 32)
    regf.foreach(r=> r.init(0))
    regf(0) := 0 // x0 is hardwired to zero

    IDEX.add(RS1)(regf.read(rs1(IFID.get(Instruction))))
    IDEX.add(RS2)(regf.read(rs2(IFID.get(Instruction))))
    IDEX.add(RDNum)(rd(IFID.get(Instruction)))

    IDEX.add(IMM_B)(immGenB(IFID.get(Instruction)))
    SpinalInfo(s"immb width ${immGenB(IFID.get(Instruction)).getWidth}")
    IDEX.add(IMM_I)(immGenI(IFID.get(Instruction)))
    IDEX.add(IMM_S)(immGenS(IFID.get(Instruction)))
    IDEX.add(IMM_U)(immGenU(IFID.get(Instruction)))
    IDEX.add(IMM_J)(immGenJ(IFID.get(Instruction)))

    IDEX.add(ARITH_TYPE){
      IFID.get(Instruction)(30) ## funct3(IFID.get(Instruction))
    }
    IDEX.add(ALU_IMM_SRC){isImmType(IFID.get(Instruction))}

    IDEX.add(ALU_SRC_SEL)(isMemType(IFID.get(Instruction)))
    IDEX.add(MEM_TO_REG)(isStoreType(IFID.get(Instruction)))
    IDEX.add(WRITE_REG)(isLoadType(IFID.get(Instruction)))
    IDEX.add(BRANCH)(isBraType(IFID.get(Instruction)))
    IDEX.add(ALU_OP){
      opcode(IFID.get(Instruction)).mux(
        regAndImmType -> B"2'b10",
        branchType -> B"2'b01",
        default -> B"2'b00"
      )
    }
    io.test.regValue := regf(io.test.regAddr)
  }

  val execute = new Area {
    val alu = ArithLogicUnit(cfg)
    alu.io.dataA := IDEX.get(RS1).asSInt
    alu.io.dataB := IDEX.get(ALU_SRC_SEL) ? (IDEX.get(MEM_TO_REG) ? IDEX.get(IMM_S).asSInt | IDEX.get(IMM_I).asSInt) | IDEX.get(RS2).asSInt
    when(IDEX.get(ALU_SRC_SEL)){
      when(IDEX.get(MEM_TO_REG)){
        alu.io.dataB := IDEX.get(IMM_S).asSInt.resized
      } otherwise(
        alu.io.dataB := IDEX.get(IMM_I).asSInt.resized
      )
    } otherwise(
      when(IDEX.get(ALU_IMM_SRC)){
        alu.io.dataB := IDEX.get(IMM_I).asSInt.resized
      } otherwise(
        alu.io.dataB := IDEX.get(RS2).asSInt
      )
    )
    val aluCtrlUnit = new Area {
      switch(IDEX.get(ALU_OP)) {
        is(B"00"){alu.io.ctrl := ALU_ADD} // default
        is(B"01"){alu.io.ctrl := ALU_SUB} // branch, substrate two number to test if it's zero
        is(B"10"){ // reg
          switch(IDEX.get(ARITH_TYPE)(2 downto 0)){
            is(B"000"){
              when(IDEX.get(ARITH_TYPE).msb){
                alu.io.ctrl := ALU_SUB
              }.otherwise(
                alu.io.ctrl := ALU_ADD
              )
            }
            is(B"001"){alu.io.ctrl := ALU_SLL}
            is(B"010"){alu.io.ctrl := ALU_SLT}
            is(B"011"){alu.io.ctrl := ALU_SLTU}
            is(B"100"){alu.io.ctrl := ALU_BIT_XOR}
            is(B"101"){
              when(IDEX.get(ARITH_TYPE).msb){
                alu.io.ctrl := ALU_SRA
              } otherwise(
                alu.io.ctrl := ALU_SRL
              )
            }
            is(B"110"){alu.io.ctrl := ALU_BIT_OR}
            is(B"111"){alu.io.ctrl := ALU_BIT_AND}
          }
        }
        default {alu.io.ctrl := 0}
      }
    }
    EXMEM.add(ALU_RESULT){alu.io.dataOut}

    val branchType = IDEX.get(ARITH_TYPE)(2 downto 0)
    val bAssert = Bool()
    switch(branchType){
      is(B"000"){bAssert := alu.io.zero}
      is(B"001"){bAssert := !alu.io.zero}
      is(B"100"){bAssert := alu.io.lessThan}
      is(B"101"){bAssert := !alu.io.lessThan}
      is(B"110"){bAssert := alu.io.uLessThan}
      is(B"111"){bAssert := !alu.io.uLessThan}
      default   {bAssert := False}
    }
    EXMEM.add(BRANCH_ASSERT){bAssert}
    EXMEM.add(BRANCH_ADDR) {
      ( IDEX.get(PC).asSInt + ( IDEX.get(IMM_B) << 1).asSInt ).asUInt
    }
  }

  val memAccess = new Area { mem_area =>
    val address = EXMEM.get(ALU_RESULT).asUInt |>> log2Up(cfg.dataWidth/8)
    val byteOffset = EXMEM.get(ALU_RESULT)(cfg.bOffsetRange).asUInt
    val halfWordOffset = EXMEM.get(ALU_RESULT)(cfg.hOffsetRange).asUInt
    val wordOffset = if(cfg.dataWidth > 32){
      EXMEM.get(ALU_RESULT)(cfg.wOffsetRange).asUInt
    } else {U(0)}
    val en = EXMEM.get(ALU_SRC_SEL)
    val wr = ~EXMEM.get(MEM_TO_REG)
    val dataWrite = EXMEM.get(RS2)
    val rdata = Bits(cfg.dataWidth bit)
    when(en){
      rdata := dataCache.readAsync(address.resized)
    } otherwise {rdata := 0}

    val rdata1 = Bits(cfg.dataWidth bit)
    val rdata8_v = rdata.subdivideIn(8 bit)
    val rdata16_v = rdata.subdivideIn(16 bit)
    val rdata32_v = rdata.subdivideIn(32 bit)
    switch(EXMEM.get(ARITH_TYPE)(2 downto 0)){
      is(B"000"){rdata1 := rdata8_v(byteOffset).asSInt.resize(cfg.dataWidth bit).asBits} // LU
      is(B"001"){rdata1 := rdata16_v(halfWordOffset).asSInt.resize(cfg.dataWidth bit).asBits} // LH
      is(B"010"){rdata1 := rdata32_v(wordOffset).asSInt.resize(cfg.dataWidth bit).asBits} // LW
      is(B"100"){rdata1 := rdata8_v(byteOffset).resize(cfg.dataWidth).asBits} // lbu
      is(B"101"){rdata1 := rdata16_v(halfWordOffset).resize(cfg.dataWidth).asBits} // lhu
      is(B"110"){rdata1 := rdata32_v(wordOffset).resize(cfg.dataWidth).asBits} // todo check if lwu is this
      default   {rdata1 := rdata}
    }
    MEMWB.add(MEM_RDATA){rdata1}

    when(en){
      val wdata = Bits(cfg.dataWidth bit)
      switch(EXMEM.get(ARITH_TYPE)(2 downto 0)){
        is(B"000"){wdata := dataWrite(7 downto 0).asSInt.resize(cfg.dataWidth bit).asBits} // sb
        is(B"001"){wdata := dataWrite(15 downto 0).asSInt.resize(cfg.dataWidth bit).asBits} // sh
        is(B"010"){wdata := dataWrite(31 downto 0).asSInt.resize(cfg.dataWidth bit).asBits} // sw
        default   {wdata := dataWrite} // sd
      }
      dataCache.write(address.resized, wdata, wr)
    }
  }

  val writeBack = new Area {
    // todo: Don't write to x0
    decode.regf.write(
      MEMWB.get(RDNum), MEMWB.get(MEM_TO_REG) ? MEMWB.get(MEM_RDATA) | MEMWB.get(ALU_RESULT).asBits
    )
  }

  def initCodeRom(hexFilePath: String, offset: Int): Unit = {
    import spinal.lib.misc.HexTools
    HexTools.initRam(instructionCache, hexFilePath, offset)
  }

  def initDataRam(content: Seq[Int]): Unit = {
    dataCache.initBigInt(content.map(BigInt(_)))
  }
}

object FiveStagesCpu {
  def main(args: Array[String]): Unit = {
    SpinalConfig(targetDirectory = "rtl")
      .generateVerilog(FiveStagesCpu(RocRvConfig()))
  }
}