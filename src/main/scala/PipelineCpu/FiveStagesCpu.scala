package PipelineCpu

import spinal.core._
import spinal.lib._
import Config._
import spinal.core.sim._

// todo:
//  1. introduce branch hazard unit; Now we consider adopting
//      a static branch prediction method: Assume branch not taken.
//  2. including CSR instructions.
//  3. including exception & interrupts (need CSR)
/**
 * An Five stages pipeline RISC-V CPU.
 * Support RV64I, except for `fence`, `ecall`, `ebreak` and csr logic
 * @param cfg Configuration of the CPU
 */
class FiveStagesCpu(cfg: RocRvConfig) extends FiveStage {
  import DecodingMethod._
  import RiscVISA._
  import cfg.stageRegSpace._

  val io = new Bundle {
    val test = new Bundle {
      val regAddr = in UInt(5 bit)
      val regValue = out Bits(cfg.dataWidth bit)
    }
    val extInterrupt = in Bits(cfg.interruptSrcNum bit)

    val error = out Bool()
  }

  val instructionCache = Mem(Bits(32 bit), BigInt(1) << 20) simPublic()
  val dataCache = Mem(Bits(cfg.dataWidth bit), BigInt(1) << 20)  simPublic()
  val abc_out = dataCache(U(0xabc, 20 bit)) simPublic()

  val fetch = new Area {
    val pc = Reg(UInt(cfg.addrWidth bit)) init(cfg.initPcAddr)
    val instrFromCache = instructionCache.readAsync((pc >> 2).resized, writeFirst)
    instrFromCache.simPublic()
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
//    io.error := (instrFromCache === 0) || (instrFromCache === (BigInt(1) << instrFromCache.getWidth)-1)

    IFID.add(PC)(pc)
    IFID.add(Instruction)(instrFromCache)
  }

  val decode = new Area {
    val regf = Vec(Reg(Bits(cfg.dataWidth bit)), 32)
    regf.simPublic()
    regf.foreach(r=> r.init(0))
    regf(0) := 0 // x0 is hardwired to zero

//    val csr_regs =

    val rs1_reg_value = Bits(cfg.dataWidth bit)
    val rs2_reg_value = Bits(cfg.dataWidth bit)
//    IDEX.add(RS1)(regf.read(rs1(IFID.get(Instruction))))
    IDEX.add(RS1)(rs1_reg_value)
    IDEX.add(RS1Num)(rs1(IFID.get(Instruction)))
//    IDEX.add(RS2)(regf.read(rs2(IFID.get(Instruction))))
    IDEX.add(RS2)(rs2_reg_value)
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

    IDEX.add(IS_MEM_INSTR)(isMemType(IFID.get(Instruction))) // When sel=1, alu src is from
    IDEX.add(MEM_TO_REG)(isLoadType(IFID.get(Instruction)))
    IDEX.add(WRITE_REG)(
      isLoadType(IFID.get(Instruction)) || isRegAndImmType(IFID.get(Instruction)) || IFID.get(Instruction) === AUIPC || IFID.get(Instruction) === LUI
    )
    IDEX.add(WRITE_MEM)(
      isStoreType(IFID.get(Instruction))
    )
    IDEX.add(BRANCH)(isBraType(IFID.get(Instruction)))

    IDEX.add(ALU_OP){
      opcode(IFID.get(Instruction)).mux(
        auipcType -> B"2'b11",
        regAndImmType -> B"2'b10",
        branchType -> B"2'b01",
        default -> B"2'b00"
      )
    }
    IDEX.add(ALU_32B)(opcode(IFID.get(Instruction))(3))
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
    } elsewhen(IDEX.get(IS_LUI)){
      alu.io.dataA := IDEX.get(IMM_U).asSInt.resized
    } otherwise {
      alu.io.dataA := rs1_value
    }
    when(IDEX.get(IS_MEM_INSTR)){
      when(~IDEX.get(MEM_TO_REG)){
        alu.io.dataB := IDEX.get(IMM_S).asSInt.resized
      } otherwise(
        alu.io.dataB := IDEX.get(IMM_I).asSInt.resized
      )
    } elsewhen (IDEX.get(IS_AUIPC)){
//      alu.io.dataB := IDEX.get(IMM_U).resizeLeft(cfg.addrWidth).asSInt
      alu.io.dataB := IDEX.get(IMM_U).resizeLeft(32).asSInt.resize(cfg.dataWidth)
    } elsewhen (IDEX.get(IS_LUI)) {
      alu.io.dataB := S(12, cfg.dataWidth bit)
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
    aluCtrlUnit.io.is_lui := IDEX.get(IS_LUI)
    alu.io.ctrl := aluCtrlUnit.io.ctrl
    alu.io.is32b := IDEX.get(ALU_32B)

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
      //bypass logic to pass the reg file when read and write regf in same cycle.
      val bypass_regf_rs1 = MEMWB.get(RDNum) === rs1(IFID.get(Instruction))
      val bypass_regf_rs2 = MEMWB.get(RDNum) === rs2(IFID.get(Instruction))

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
        when(prevNotWriteRs1 && MEMWB.get(RDNum) === IDEX.get(RS1Num) ){
          when(MEMWB.get(RDNum) === IDEX.get(RS1Num)) {
            fa := B"01"
          } /*elsewhen(bypass_regf_rs1) {
            fa := B"11"
          }*/
        } elsewhen(prevNotWriteRs2 && MEMWB.get(RDNum) === IDEX.get(RS2Num)){
          when(MEMWB.get(RDNum) === IDEX.get(RS2Num)) {
            fb := B"01"
          } /*elsewhen(bypass_regf_rs2) {
            fb := B"11"
          }*/
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
    } else {U(0, cfg.wOffsetRange.length bit)}
    val en = EXMEM.get(IS_MEM_INSTR)

    val rdata = Bits(cfg.dataWidth bit)
    val raddr = address.resize(20)
    when(en){
      rdata := dataCache.readAsync(raddr, writeFirst)
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

    val wr = EXMEM.get(WRITE_MEM)
    val wsel = Bits(2 bit) // bypass logic
    val wmask = Bits(cfg.dataWidth bit)
    val dataWrite = wsel.mux(
      B"00" -> EXMEM.get(RS2),
      B"01" -> MEMWB.get(ALU_RESULT).asBits,
      B"10" -> MEMWB.get(MEM_RDATA),
      default -> B(0, cfg.dataWidth bit)
    )
    val wdata = Bits(cfg.dataWidth bit)
    val wdata8_v = Vec(Bits(8 bit), cfg.dataWidth/8)
    val wdata16_v = Vec(Bits(16 bit), cfg.dataWidth/16)
    val wdata32_v = Vec(Bits(32 bit), cfg.dataWidth/32)
    wdata8_v.foreach(_ := 0) // default assignment
    wdata16_v.foreach(_ := 0)
    wdata32_v.foreach(_ := 0)
    wdata8_v(byteOffset.resized) := dataWrite.resize(8) // mux assignment
    wdata16_v(halfWordOffset.resized) := dataWrite.resize(16)
    wdata32_v(wordOffset.resized) := dataWrite.resize(32)
    switch(EXMEM.get(ARITH_TYPE)(2 downto 0)){
      is(B"000"){
        wdata := wdata8_v.asBits
        wmask := ( B"8'hff" << (byteOffset << 3) ).resize(cfg.dataWidth)
      } // sb
      is(B"001"){
        wdata := wdata16_v.asBits
        wmask := ( B"16'hffff" << (halfWordOffset << 4) ).resize(cfg.dataWidth)
      } // sh
      is(B"010"){
        wdata := wdata32_v.asBits
        wmask := ( B"32'hffffffff" << (wordOffset << 5) ).resize(cfg.dataWidth)
      } // sw
      default   {
        wdata := dataWrite
        wmask := B"64'hffffffffffffffff"
      } // sd
    }
    dataCache.write(address.resized, wdata, wr & en, wmask)

    val forward = new Area {
      val isBypassRs2 = MEMWB.get(WRITE_REG) && ( MEMWB.get(RDNum) =/= 0 ) && ( MEMWB.get(RDNum) === EXMEM.get(RS2Num) )
      when(isBypassRs2){
        when(MEMWB.get(MEM_TO_REG)){// load type
          wsel := B"10"
        } otherwise(
          wsel := B"01" // or reg type
        )
      } otherwise(
        wsel := B"00" // no bypass
      )
    }

//    io.error := (instrFromCache === 0) || (instrFromCache === (BigInt(1) << instrFromCache.getWidth)-1)
    val memwb_inst = MEMWB.get(Instruction)
    memwb_inst.simPublic()
    // TODO: Decoding error needs to redesigned.
    io.error := (memwb_inst === 0) || (memwb_inst === (BigInt(1) << fetch.instrFromCache.getWidth)-1)
  }

  val writeBack = new Area {
    val regfWriteData = Bits(cfg.dataWidth bit)
    when(MEMWB.get(MEM_TO_REG)){
      regfWriteData := MEMWB.get(MEM_RDATA)
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
    }

    // bypass logic
    execute.rs1_value := execute.forward.fa.mux(
      B"00" -> IDEX.get(RS1).asSInt,
      B"01" -> regfWriteData.asSInt,
      B"10" -> EXMEM.get(ALU_RESULT),
      B"11" -> S(0)
    )
    execute.rs2_value := execute.forward.fb.mux(
      B"00" -> IDEX.get(RS2).asSInt,
      B"01" -> regfWriteData.asSInt,
      B"10" -> EXMEM.get(ALU_RESULT),
      B"11" -> S(0)
    )

    // Add bypass logic for load rs1 and rs2 to stage reg
    decode.rs1_reg_value := execute.forward.bypass_regf_rs1 ? regfWriteData | decode.regf(rs1(IFID.get(Instruction)))
    decode.rs2_reg_value := execute.forward.bypass_regf_rs2 ? regfWriteData | decode.regf(rs2(IFID.get(Instruction)))
  }

  def initCodeRom(hexFilePath: String, offset: Int): Unit = {
    import spinal.lib.misc.HexTools
    HexTools.initRam(instructionCache, hexFilePath, offset)
  }

  def initDataRam(content: Seq[BigInt]): Unit = {
    dataCache.initBigInt(content)
  }

  def initDataRam(hexFilePath: String, offset: Int): Unit = {
    import spinal.lib.misc.HexTools
    HexTools.initRam(dataCache, hexFilePath, offset)
  }
}

object FiveStagesCpu {
  def main(args: Array[String]): Unit = {
    SpinalConfig(targetDirectory = "rtl")
      .generateVerilog{
        val cpu = new FiveStagesCpu(RocRvConfig())
//        cpu.initCodeRom("src/main/resource/test_asm_code/print/print.hex", 0)
        cpu
      }
  }
}