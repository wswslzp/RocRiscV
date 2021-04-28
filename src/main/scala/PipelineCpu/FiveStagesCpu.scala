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
  object RS1Num extends StageReg(UInt(5 bit))
  object RS2 extends StageReg(Bits(cfg.dataWidth bit))
  object RS2Num extends StageReg(UInt(5 bit))
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
    val instrFromCache = instructionCache.readAsync((pc >> 2).resized, writeFirst)
    val naturalNextPc = pc + 4
    val nextPcIsBranch = EXMEM.get(BRANCH) && EXMEM.get(BRANCH_ASSERT) // Only for `BEQ`
    val loadStall = Bool()
    when(!loadStall){
      pc := nextPcIsBranch ? EXMEM.get(BRANCH_ADDR) | naturalNextPc
    }
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
    val rs1_value = SInt(cfg.dataWidth bit)
    val rs2_value = SInt(cfg.dataWidth bit)
    alu.io.dataA := rs1_value
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
        alu.io.dataB := rs2_value
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

    // forwarding logic
    val forward = new Area {
      val fa = Bits(2 bit)
      val fb = Bits(2 bit)
      val prevWriteReg = EXMEM.get(WRITE_REG) && EXMEM.get(RDNum) =/= 0
      val prevNotWriteRs1 = !(prevWriteReg && EXMEM.get(RDNum) === IDEX.get(RS1Num))
      val prevNotWriteRs2 = !(prevWriteReg && EXMEM.get(RDNum) === IDEX.get(RS2Num))
      when(prevWriteReg){
        switch(EXMEM.get(RDNum)){
          is(IDEX.get(RS1Num)){
            fa := B"10"; fb := 0
          }
          is(IDEX.get(RS2Num)){
            fa := 0; fb := B"10"
          }
          default{
            fa := 0; fb := 0
          }
        }
      } elsewhen(MEMWB.get(WRITE_REG) && MEMWB.get(RDNum) =/= 0){
        when(prevNotWriteRs1 && MEMWB.get(RDNum) === IDEX.get(RS1Num)){
          fa := B"01"; fb := 0
        } elsewhen(prevNotWriteRs2 && MEMWB.get(RDNum) === IDEX.get(RS2Num)){
          fa := 0; fb := B"01"
        } otherwise{
          fa := 0; fb := 0
        }
      } otherwise {
        fa := 0; fb := 0 // default situation
      }
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
      is(B"110"){rdata1 := rdata32_v(wordOffset).resize(cfg.dataWidth).asBits} // todo check if lwu is this
      default   {rdata1 := rdata}
    }
    MEMWB.add(MEM_RDATA){rdata1}

    val wr = ~EXMEM.get(MEM_TO_REG)
    val wsel = Bits(2 bit) // bypass logic
    val dataWrite = wsel.mux(
      B"00" -> EXMEM.get(RS2),
      B"01" -> EXMEM.get(ALU_RESULT).asBits,
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
        when(EXMEM.get(ALU_SRC_SEL)){// load type
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
    // todo: Don't write to x0
    val regfWriteData = MEMWB.get(MEM_TO_REG) ? MEMWB.get(MEM_RDATA) | MEMWB.get(ALU_RESULT).asBits
    when(MEMWB.get(WRITE_REG)){
      decode.regf.write(
        MEMWB.get(RDNum), regfWriteData
      )
    }

    // Data hazard detect unit
    val DHDU = new Area {
      when(
        IDEX.get(WRITE_REG) && (IDEX.get(RDNum) === rs1(IFID.get(Instruction)) || IDEX.get(RDNum) === rs2(IFID.get(Instruction)))
      ) {
        fetch.loadStall := True
      } otherwise(fetch.loadStall := False)
      IFID.stallBy(fetch.loadStall)
      IDEX.flushBy(MEM_TO_REG, WRITE_REG)(fetch.loadStall)
      EXMEM.flushBy(MEM_TO_REG, WRITE_REG)(fetch.loadStall)
      MEMWB.flushBy(MEM_TO_REG, WRITE_REG)(fetch.loadStall)
    }

    // bypass logic
    execute.rs1_value := execute.forward.fa.mux(
      B"00" -> IDEX.get(RS1).asSInt,
      B"01" -> EXMEM.get(ALU_RESULT),
      B"10" -> regfWriteData.asSInt,
      default-> S(0)
    )
    execute.rs2_value := execute.forward.fb.mux(
      B"00" -> IDEX.get(RS2).asSInt,
      B"01" -> EXMEM.get(ALU_RESULT),
      B"10" -> regfWriteData.asSInt,
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
      .generateVerilog(FiveStagesCpu(RocRvConfig()))
  }
}