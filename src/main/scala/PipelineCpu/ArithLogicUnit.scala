package PipelineCpu

import Config.RocRvConfig
import spinal.core._
import spinal.lib._

object ALU_CTRL_CMD {
  // AND, OR, NOR, XOR: 00, 01, 10, 11
  // SLL, SRL, SRA: 100, 101, 110
  // ADD, SUB: 1000, 1001
  // SLT, SLTU: 1010, 1011
  def ALU_BIT_AND = B"0000"
  def ALU_BIT_OR  = B"0001"
  def ALU_BIT_NOR = B"0010"
  def ALU_BIT_XOR = B"0011"
  def ALU_SLL     = B"0100"
  def ALU_SRL     = B"0101"
  def ALU_SRA     = B"0110"
  def ALU_ADD     = B"1000"
  def ALU_SUB     = B"1001"
  def ALU_SLT     = B"1010"
  def ALU_SLTU    = B"1011"
}

case class ArithLogicUnit(cfg: RocRvConfig) extends Component {
  import ALU_CTRL_CMD._
  val io = new Bundle {
    val ctrl = in Bits(4 bit)
    val is32b = in Bool()
    val dataA, dataB = in SInt(cfg.dataWidth bit)
    val dataOut = out SInt(cfg.dataWidth bit)
    val zero = out Bool()
    val lessThan = out Bool()
    val uLessThan = out Bool()
  }
  val dataA = io.is32b ? (
    S(io.dataA.msb, 32 bit) @@ io.dataA(31 downto 0)
  ) | io.dataA
  val dataB = io.is32b ? (
    S(io.dataB.msb, 32 bit) @@ io.dataB(31 downto 0)
  ) | io.dataB

  val dataOut = SInt(cfg.dataWidth bit)
  io.lessThan := dataA < dataB
  io.uLessThan := dataA.asUInt < dataB.asUInt
  switch(io.ctrl){
    is(ALU_BIT_AND) {dataOut := dataA & dataB} // AND
    is(ALU_BIT_OR)  {dataOut := dataA | dataB} // OR
    is(ALU_BIT_NOR) {dataOut := ~(dataA | dataB)} // NOR
    is(ALU_BIT_XOR) {dataOut := dataA ^ dataB} // XOR
    is(ALU_SLL)     {dataOut := dataA << dataB.asUInt}
    is(ALU_SRL)     {dataOut := (dataA.asUInt >> dataB.asUInt).asSInt}
    is(ALU_SRA)     {dataOut := dataA >> dataB.asUInt}
    is(ALU_ADD)     {dataOut := dataA + dataB} // ADD //todo, 1 + 0x7fff_ffff = 0x7fff_ffff ?? for addw
    is(ALU_SUB)     {dataOut := dataA - dataB} // SUB
    is(ALU_SLT)     {dataOut := io.lessThan ? S(1, cfg.dataWidth bit) | S(0, cfg.dataWidth bit)} // SLT
    is(ALU_SLTU)    {dataOut := io.uLessThan ? S(1, cfg.dataWidth bit) | S(0, cfg.dataWidth bit)}
    default         {dataOut := 0}
  }
//  val dataOutSat32 = dataOut.sat(32)
//  io.dataOut := io.is32b ? (
//    S(dataOutSat32.msb, 32 bit) @@ dataOutSat32(31 downto 0)
//    ) | dataOut
  io.dataOut := io.is32b ? (
    S(dataOut(31), 32 bit) @@ dataOut(31 downto 0)
  ) | dataOut
  io.zero := dataOut === 0
}
