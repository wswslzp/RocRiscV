package Config

import spinal.core._
import spinal.lib._
import Cache._
import PipelineCpu._

case class RocRvConfig(
                      dataWidth: Int = 64,
                      addrWidth: Int = 64,
                      interruptSrcNum: Int = 16
                      ) {
  val stageRegSpace = StageRegSpace(this)
  def initPcAddr: Int = 0x10180
  def interruptHandleAddr: Int = 0x1c090000
  def defaultInstCacheConfig: CacheConfig = CacheConfig(
    cacheReadWritePolicy = new CacheReadWritePolicy(ReadAllocate, WriteThrough, WriteAllocate),
    axi4Config = CacheConfig.defaultAxiCfg, cacheBlockSize = 32, addrWidth = addrWidth
  )
  def defaultDataCacheConfig: CacheConfig = CacheConfig(
    cacheReadWritePolicy = new CacheReadWritePolicy(ReadAllocate, WriteThrough, WriteAllocate),
    axi4Config = CacheConfig.defaultAxiCfg, cacheBlockSize = 32, addrWidth = addrWidth, dataWidth = dataWidth
  )

  def bOffsetRange = log2Up(dataWidth/8)-1 downto 0
  def hOffsetRange = log2Up(dataWidth/8)-1 downto 1
  def wOffsetRange = {
    require(dataWidth > 32)
    log2Up(dataWidth/8)-1 downto 2
  }
}

object DecodingMethod {
  def opcode(instr: Bits): Bits = instr(6 downto 0)
  def rd(instr: Bits): UInt = instr(11 downto 7).asUInt
  def funct3(instr: Bits): Bits = instr(14 downto 12)
  def rs1(instr: Bits): UInt = instr(19 downto 15).asUInt
  def rs2(instr: Bits): UInt = instr(24 downto 20).asUInt
  def funct7(instr: Bits): Bits = instr(31 downto 25)

  // TODO: This method cannot reuse the previous decoding logic ?
  //  It's OK, i think.
  // |funct7[31:25]|rs2[24:20]|rs1[19:15]|funct3[14:12]|rd[11:7]|opcode[6:0]|
  def immGenI(instr: Bits): Bits = funct7(instr) ## rs2(instr)
  def immGenS(instr: Bits): Bits = funct7(instr) ## rd(instr)
  def immGenB(instr: Bits): Bits = funct7(instr).msb ## rd(instr).lsb ## funct7(instr)(5 downto 0) ## rd(instr)(4 downto 1)
  def immGenU(instr: Bits): Bits = funct7(instr) ## rs2(instr) ## rs1(instr) ## funct3(instr)
  def immGenJ(instr: Bits): Bits = {
    val tmp = funct7(instr) ## rs2(instr) ## rs1(instr) ## funct3(instr)
    tmp(19) ## tmp(7 downto 0) ## tmp(8) ## tmp(18 downto 9)
  }

}

object CPUError {
  def illegalInstruction: Bits = B"00"
}

object RiscVISA {
  import DecodingMethod._

  def regType            = M"011-011" // both for 32/64, opcode(3)=1 -> 32, opcode(3)=0 -> 64
  def isRegType(i: Bits): Bool = opcode(i) === regType
  def ADD                = M"0000000----------000-----0110011"
  def SUB                = M"0100000----------000-----0110011"
  def SLL                = M"0000000----------001-----0110011"
  def SLT                = M"0000000----------010-----0110011"
  def SLTU               = M"0000000----------011-----0110011"
  def XOR                = M"0000000----------100-----0110011"
  def SRL                = M"0000000----------101-----0110011"
  def SRA                = M"0100000----------101-----0110011"
  def OR                 = M"0000000----------110-----0110011"
  def AND                = M"0000000----------111-----0110011"

  def immType            = M"001-011"
  def isImmType(i: Bits): Bool = opcode(i) === immType
  def ADDI               = M"-----------------000-----0010011"
  def SLLI               = M"000000-----------001-----0010011"
  def SLTI               = M"-----------------010-----0010011"
  def SLTIU              = M"-----------------011-----0010011"
  def XORI               = M"-----------------100-----0010011"
  def SRLI               = M"000000-----------101-----0010011"
  def SRAI               = M"010000-----------101-----0010011"
  def ORI                = M"-----------------110-----0010011"
  def ANDI               = M"-----------------111-----0010011"

  def regAndImmType      = M"0-1-011"
  def isRegAndImmType(i: Bits): Bool = opcode(i) === regAndImmType

  def MemType            = M"0-00011"
  def isMemType(i: Bits): Bool = opcode(i) === MemType
  def LoadType           = B"0000011"
  def isLoadType(i: Bits): Bool = opcode(i) === LoadType
  def StoreType          = B"0100011"
  def isStoreType(i: Bits): Bool = opcode(i) === StoreType
  def LB                 = M"-----------------000-----0000011"
  def LH                 = M"-----------------001-----0000011"
  def LW                 = M"-----------------010-----0000011"
  def LBU                = M"-----------------100-----0000011"
  def LHU                = M"-----------------101-----0000011"
  def LWU                = M"-----------------110-----0000011"
  def SB                 = M"-----------------000-----0100011"
  def SH                 = M"-----------------001-----0100011"
  def SW                 = M"-----------------010-----0100011"

  def LR                 = M"00010--00000-----010-----0101111"
  def SC                 = M"00011------------010-----0101111"

  def AMOSWAP            = M"00001------------010-----0101111"
  def AMOADD             = M"00000------------010-----0101111"
  def AMOXOR             = M"00100------------010-----0101111"
  def AMOAND             = M"01100------------010-----0101111"
  def AMOOR              = M"01000------------010-----0101111"
  def AMOMIN             = M"10000------------010-----0101111"
  def AMOMAX             = M"10100------------010-----0101111"
  def AMOMINU            = M"11000------------010-----0101111"
  def AMOMAXU            = M"11100------------010-----0101111"

  def branchType          = B"1100011"
  def isBraType(i: Bits): Bool = opcode(i) === branchType
  def BEQ (rvc : Boolean) = if(rvc) M"-----------------000-----1100011" else M"-----------------000---0-1100011"
  def BNE (rvc : Boolean) = if(rvc) M"-----------------001-----1100011" else M"-----------------001---0-1100011"
  def BLT (rvc : Boolean) = if(rvc) M"-----------------100-----1100011" else M"-----------------100---0-1100011"
  def BGE (rvc : Boolean) = if(rvc) M"-----------------101-----1100011" else M"-----------------101---0-1100011"
  def BLTU(rvc : Boolean) = if(rvc) M"-----------------110-----1100011" else M"-----------------110---0-1100011"
  def BGEU(rvc : Boolean) = if(rvc) M"-----------------111-----1100011" else M"-----------------111---0-1100011"
  def jumpType            = M"110-111"
  def isJumpType(i: Bits): Bool = opcode(i) === jumpType
  def JALR               = M"-----------------000-----1100111"
  def JAL(rvc : Boolean) = if(rvc) M"-------------------------1101111" else M"----------0--------------1101111"
  def LUI                = M"-------------------------0110111"
  def AUIPC              = M"-------------------------0010111"
  def auipcType          = M"0010111"
  def isAuipcType(i: Bits) = opcode(i) === auipcType

  def MULX               = M"0000001----------0-------0110011"
  def DIVX               = M"0000001----------1-------0110011"

  def MUL                = M"0000001----------000-----0110011"
  def MULH               = M"0000001----------001-----0110011"
  def MULHSU             = M"0000001----------010-----0110011"
  def MULHU              = M"0000001----------011-----0110011"


  def DIV                = M"0000001----------100-----0110011"
  def DIVU               = M"0000001----------101-----0110011"
  def REM                = M"0000001----------110-----0110011"
  def REMU               = M"0000001----------111-----0110011"



  def CSRRW              = M"-----------------001-----1110011"
  def CSRRS              = M"-----------------010-----1110011"
  def CSRRC              = M"-----------------011-----1110011"
  def CSRRWI             = M"-----------------101-----1110011"
  def CSRRSI             = M"-----------------110-----1110011"
  def CSRRCI             = M"-----------------111-----1110011"

  def ECALL              = M"00000000000000000000000001110011"
  def EBREAK             = M"00000000000100000000000001110011"
  def FENCEI             = M"00000000000000000001000000001111"
  def MRET               = M"00110000001000000000000001110011"
  def SRET               = M"00010000001000000000000001110011"
  def WFI                = M"00010000010100000000000001110011"

  def FENCE              = M"-----------------000-----0001111"
  def FENCE_I            = M"-----------------001-----0001111"
  def SFENCE_VMA         = M"0001001----------000000001110011"
}
