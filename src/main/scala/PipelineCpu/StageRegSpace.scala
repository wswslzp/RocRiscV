package PipelineCpu

import spinal.core._
import spinal.lib._
import Config.RocRvConfig

case class StageRegSpace(cfg: RocRvConfig) {
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
  object MEM_INSTR extends StageReg(Bool())
  object ALU_IMM_SRC extends StageReg(Bool())
  object ALU_OP extends StageReg(Bits(2 bit))
  object MEM_TO_REG extends StageReg(Bool())
  object WRITE_REG extends StageReg(Bool())
  object BRANCH extends StageReg(Bool())
  object IS_LUI extends StageReg(Bool())
  object IS_JUMP extends StageReg(Bool())
  object IS_JALR extends StageReg(Bool())
  object IS_AUIPC extends StageReg(Bool())
  // EXMEM
  object PASS_RS1_VAL extends StageReg(SInt(cfg.dataWidth bit))
  object ALU_RESULT extends StageReg(SInt(cfg.dataWidth bit))
  object BRANCH_ASSERT extends StageReg(Bool())
  object BRANCH_ADDR extends StageReg(UInt(cfg.addrWidth bit))
  // MEMWB
  object MEM_RDATA extends StageReg(Bits(cfg.dataWidth bit))

}
