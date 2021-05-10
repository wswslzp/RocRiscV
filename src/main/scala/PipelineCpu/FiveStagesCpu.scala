package PipelineCpu

import spinal.core._
import spinal.lib._
import Config._
import spinal.core.sim._

// todo:
//  1. introduce branch hazard unit; Now we consider adopting
//      a static branch prediction method: Assume branch not taken.
//  2. need unconditional jump support: lui, auipc, jal, jalr
/**
 * An Five stages pipeline RISC-V CPU.
 * Support RV64I, except for `fence`, `ecall`, `ebreak` and csr logic
 * @param cfg Configuration of the CPU
 */
case class FiveStagesCpu(cfg: RocRvConfig) extends FiveStage {
  import DecodingMethod._
  import RiscVISA._
  import cfg.stageRegSpace._

  val io = new Bundle {
    val test = new Bundle {
      val regAddr = in UInt(5 bit)
      val regValue = out Bits(cfg.dataWidth bit)
    }
    val error = out Bool() // todo: including decoding errors
  }

  val instructionCache = Mem(Bits(32 bit), BigInt(1) << 20)
  val dataCache = Mem(Bits(cfg.dataWidth bit), BigInt(1) << 20)  simPublic()
  dataCache.initBigInt(Seq.fill(1 << 20)(BigInt(0)))

  val fetch = new Area {
    val pc = Reg(UInt(cfg.addrWidth bit)) init(cfg.initPcAddr)
    val instrFromCache = instructionCache.readAsync((pc >> 2).resized, writeFirst)
    val naturalNextPc = pc + 4
    val nextPcIsBranch = EXMEM.get(BRANCH) && EXMEM.get(BRANCH_ASSERT)
    val loadStall = Bool()
    val jumpReturnPc = UInt(cfg.addrWidth bit)
    when(!loadStall){
      when(EXMEM.get(IS_JUMP)){
        when(EXMEM.get(IS_JALR)){
//          pc := ( EXMEM.get(IMM_I).asSInt.resize(cfg.addrWidth) + EXMEM.get(RS1).asSInt ).asUInt
          pc := jumpReturnPc
        } otherwise( // jal
          pc := ( ( EXMEM.get(IMM_J) |<< 1 ).asSInt.resize(cfg.addrWidth) + EXMEM.get(PC).asSInt ).asUInt
        )
      } elsewhen(nextPcIsBranch){
        pc := EXMEM.get(BRANCH_ADDR)
      } otherwise(
        pc := naturalNextPc
      )
    }
    // todo: waiting for `fiber` framework in the future spinal version
    IFID.flushBy(nextPcIsBranch, EXMEM.get(IS_JUMP))
    IDEX.flushBy(nextPcIsBranch, EXMEM.get(IS_JUMP))
    EXMEM.flushBy(nextPcIsBranch, EXMEM.get(IS_JUMP))
    io.error := (instrFromCache === 0) || (instrFromCache === (BigInt(1) << instrFromCache.getWidth)-1)

    IFID.add(PC)(pc)
    IFID.add(Instruction)(instrFromCache)
  }

  val decode = new Area {
    val regf = Vec(Reg(Bits(cfg.dataWidth bit)), 32)
    regf.foreach(r=> r.init(0))
    regf(0) := 0 // x0 is hardwired to zero

    IDEX.add(RS1)(regf.read(rs1(IFID.get(Instruction))))
    IDEX.add(RS1Num)(rs1(IFID.get(Instruction)))
    IDEX.add(RS2)(regf.read(rs2(IFID.get(Instruction))))
    IDEX.add(RS2Num)(rs2(IFID.get(Instruction)))
    IDEX.add(RDNum)(rd(IFID.get(Instruction)))

    IDEX.add(IMM_B)(immGenB(IFID.get(Instruction)))
    IDEX.add(IMM_I)(immGenI(IFID.get(Instruction)))
    IDEX.add(IMM_S)(immGenS(IFID.get(Instruction)))
    IDEX.add(IMM_U)(immGenU(IFID.get(Instruction)))
    IDEX.add(IMM_J)(immGenJ(IFID.get(Instruction)))

    IDEX.add(ARITH_TYPE){
      IFID.get(Instruction)(30) ## funct3(IFID.get(Instruction))
    }
    IDEX.add(ALU_IMM_SRC){isImmType(IFID.get(Instruction))}

    IDEX.add(MEM_INSTR)(isMemType(IFID.get(Instruction))) // When sel=1, alu src is from
    IDEX.add(MEM_TO_REG)(isLoadType(IFID.get(Instruction)))
    IDEX.add(WRITE_REG)(isLoadType(IFID.get(Instruction)) || isRegAndImmType(IFID.get(Instruction)) || IFID.get(Instruction) === AUIPC)
    IDEX.add(BRANCH)(isBraType(IFID.get(Instruction)))
    IDEX.add(ALU_OP){
      opcode(IFID.get(Instruction)).mux(
        auipcType -> B"2'b11",
        regAndImmType -> B"2'b10",
        branchType -> B"2'b01",
        default -> B"2'b00"
      )
    }
    IDEX.add(IS_LUI)(IFID.get(Instruction) === LUI)
    IDEX.add(IS_JUMP)(isJumpType(IFID.get(Instruction)))
    IDEX.add(IS_JALR)(IFID.get(Instruction) === JALR)
    IDEX.add(IS_AUIPC)(IFID.get(Instruction) === AUIPC)
    io.test.regValue := regf(io.test.regAddr)
  }

  val execute = new Area {
    val alu = ArithLogicUnit(cfg)
    val rs1_value = SInt(cfg.dataWidth bit)
    val rs2_value = SInt(cfg.dataWidth bit)
    when(IDEX.get(IS_AUIPC)){
      alu.io.dataA := IDEX.get(PC).resized.asSInt
    } otherwise {
      alu.io.dataA := rs1_value
    }
    when(IDEX.get(MEM_INSTR)){
      when(~IDEX.get(MEM_TO_REG)){
        alu.io.dataB := IDEX.get(IMM_S).asSInt.resized
      } otherwise(
        alu.io.dataB := IDEX.get(IMM_I).asSInt.resized
      )
    } elsewhen (IDEX.get(IS_AUIPC)){
//      alu.io.dataB := IDEX.get(IMM_U).resizeLeft(cfg.addrWidth).asSInt
      alu.io.dataB := IDEX.get(IMM_U).resizeLeft(32).asSInt.resize(cfg.dataWidth)
    } otherwise(
      when(IDEX.get(ALU_IMM_SRC)){
        alu.io.dataB := IDEX.get(IMM_I).asSInt.resized
      } otherwise(
        alu.io.dataB := rs2_value
      )
    )
    val aluCtrlUnit = AluCtrlUnit(cfg)
    aluCtrlUnit.io.arith_type := IDEX.get(ARITH_TYPE)
    aluCtrlUnit.io.alu_op := IDEX.get(ALU_OP)
    aluCtrlUnit.io.is_imm := IDEX.get(ALU_IMM_SRC)
    alu.io.ctrl := aluCtrlUnit.io.ctrl

    EXMEM.add(PASS_RS1_VAL)(rs1_value)
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
    EXMEM.add(BRANCH_ADDR) { // todo: branch address calculation move to ID stage
      ( IDEX.get(PC).asSInt + ( IDEX.get(IMM_B) << 1).asSInt ).asUInt
    }
    EXMEM.get(BRANCH_ADDR).init(0)

    // forwarding logic
    val forward = new Area { // TODO: forward logic is wrong. ALU result bypass one cycle later than it should be.
      val fa = Bits(2 bit)
      val fb = Bits(2 bit)
      val prevWriteReg = EXMEM.get(WRITE_REG) && EXMEM.get(RDNum) =/= 0
      val prevNotWriteRs1 = !(prevWriteReg && EXMEM.get(RDNum) === IDEX.get(RS1Num))
      val prevNotWriteRs2 = !(prevWriteReg && EXMEM.get(RDNum) === IDEX.get(RS2Num))
      fa := 0; fb := 0 // default situation
      when(prevWriteReg){
        switch(EXMEM.get(RDNum)){
          is(IDEX.get(RS1Num)){
            fa := B"10"
          }
          is(IDEX.get(RS2Num)){
            fb := B"10"
          }
        }
      }
      when(MEMWB.get(WRITE_REG) && MEMWB.get(RDNum) =/= 0){
        when(prevNotWriteRs1 && MEMWB.get(RDNum) === IDEX.get(RS1Num)){
          fa := B"01"
        } elsewhen(prevNotWriteRs2 && MEMWB.get(RDNum) === IDEX.get(RS2Num)){
          fb := B"01"
        }
      }

      // jalr forward logic
      fetch.jumpReturnPc := (EXMEM.get(IMM_I).asSInt.resize(cfg.addrWidth)+EXMEM.get(PASS_RS1_VAL)).asUInt
    }
  }

  val memAccess = new Area { mem_area =>
    val address = EXMEM.get(ALU_RESULT).asUInt |>> log2Up(cfg.dataWidth/8)
    address.simPublic()
    val byteOffset = EXMEM.get(ALU_RESULT)(cfg.bOffsetRange).asUInt
    val halfWordOffset = EXMEM.get(ALU_RESULT)(cfg.hOffsetRange).asUInt
    val wordOffset = if(cfg.dataWidth > 32){
      EXMEM.get(ALU_RESULT)(cfg.wOffsetRange).asUInt
    } else {U(0)}
    val en = EXMEM.get(MEM_INSTR)

    val rdata = Bits(cfg.dataWidth bit)
    when(en){
      rdata := dataCache.readAsync(address.resized, writeFirst)
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
      is(B"110"){rdata1 := rdata32_v(wordOffset).resize(cfg.dataWidth).asBits}
      default   {rdata1 := rdata}
    }
    MEMWB.add(MEM_RDATA){rdata1}

    val wr = ~EXMEM.get(MEM_TO_REG)
    val wsel = Bits(2 bit) // bypass logic
    val dataWrite = wsel.mux(
      B"00" -> EXMEM.get(RS2),
      B"01" -> MEMWB.get(ALU_RESULT).asBits,
      B"10" -> MEMWB.get(MEM_RDATA),
      default -> B(0, cfg.dataWidth bit)
    )
    val wdata = Bits(cfg.dataWidth bit)
    val wdata8_v = dataWrite.subdivideIn(8 bit)
    val wdata16_v = dataWrite.subdivideIn(16 bit)
    val wdata32_v = dataWrite.subdivideIn(32 bit)
    switch(EXMEM.get(ARITH_TYPE)(2 downto 0)){
      is(B"000"){wdata := wdata8_v(byteOffset).asSInt.resize(cfg.dataWidth bit).asBits} // sb
      is(B"001"){wdata := wdata16_v(halfWordOffset).asSInt.resize(cfg.dataWidth bit).asBits} // sh
      is(B"010"){wdata := wdata32_v(wordOffset).asSInt.resize(cfg.dataWidth bit).asBits} // sw
      default   {wdata := dataWrite} // sd
    }
    when(en){
      dataCache.write(address.resized, wdata, wr)
    }

    val forward = new Area {
      val isBypassRs2 = MEMWB.get(WRITE_REG) && ( MEMWB.get(RDNum) =/= 0 ) && ( MEMWB.get(RDNum) === EXMEM.get(RS2Num) )
      when(isBypassRs2){
        when(MEMWB.get(MEM_TO_REG)){// load type
          wsel := B"10"
        } otherwise(
          wsel := B"01" // or Reg type
        )
      } otherwise(
        wsel := B"00" // no bypass
      )
    }
  }

  val writeBack = new Area {
    val regfWriteData = Bits(cfg.dataWidth bit)
    when(MEMWB.get(MEM_TO_REG)){
      regfWriteData := MEMWB.get(MEM_RDATA)
    }elsewhen(MEMWB.get(IS_LUI)){
//      regfWriteData := MEMWB.get(IMM_U) ## decode.regf(MEMWB.get(RDNum))(cfg.dataWidth-21 downto 0)
      regfWriteData := ( MEMWB.get(IMM_U) ## decode.regf(MEMWB.get(RDNum))(11 downto 0) ).asSInt.resize(cfg.dataWidth).asBits
    }elsewhen(MEMWB.get(IS_JUMP)){
      regfWriteData := (MEMWB.get(PC) + 4).resized.asBits
    }otherwise(
      regfWriteData := MEMWB.get(ALU_RESULT).asBits
    )
    val regfWriteEn = MEMWB.get(WRITE_REG) || MEMWB.get(IS_LUI) || MEMWB.get(IS_JUMP) || MEMWB.get(IS_AUIPC)
    when(regfWriteEn && MEMWB.get(RDNum) =/= 0){
      decode.regf.write(
        MEMWB.get(RDNum), regfWriteData
      )
    }

    // Data hazard detect unit
    val DHDU = new Area {
      when(
        IDEX.get(MEM_TO_REG) && (IDEX.get(RDNum) === rs1(IFID.get(Instruction)) || IDEX.get(RDNum) === rs2(IFID.get(Instruction)))
      ) {
        fetch.loadStall := True
      } otherwise(fetch.loadStall := False)
      IFID.stallBy(fetch.loadStall)
      IDEX.flushBy(MEM_TO_REG, WRITE_REG)(fetch.loadStall)
//      EXMEM.flushBy(MEM_TO_REG, WRITE_REG)(fetch.loadStall)
//      MEMWB.flushBy(MEM_TO_REG, WRITE_REG)(fetch.loadStall)
    }

    // bypass logic
    execute.rs1_value := execute.forward.fa.mux(
      B"00" -> IDEX.get(RS1).asSInt,
      B"01" -> regfWriteData.asSInt,
      B"10" -> EXMEM.get(ALU_RESULT),
      default-> S(0)
    )
    execute.rs2_value := execute.forward.fb.mux(
      B"00" -> IDEX.get(RS2).asSInt,
      B"01" -> regfWriteData.asSInt,
      B"10" -> EXMEM.get(ALU_RESULT),
      default-> S(0)
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
      .generateVerilog{
        val cpu = FiveStagesCpu(RocRvConfig())
//        cpu.initCodeRom("src/main/resource/test_asm_code/print/print.hex", 0)
        cpu
      }
  }
}