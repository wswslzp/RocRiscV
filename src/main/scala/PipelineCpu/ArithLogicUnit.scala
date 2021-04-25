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
    val dataA, dataB = in SInt(cfg.dataWidth bit)
    val dataOut = out SInt(cfg.dataWidth bit)
    val zero = out Bool()
    val lessThan = out Bool()
    val uLessThan = out Bool()
  }

  io.lessThan := io.dataA < io.dataB
  io.uLessThan := io.dataA.asUInt < io.dataB.asUInt
  switch(io.ctrl){
    is(ALU_BIT_AND) {io.dataOut := io.dataA & io.dataB} // AND
    is(ALU_BIT_OR)  {io.dataOut := io.dataA | io.dataB} // OR
    is(ALU_BIT_NOR) {io.dataOut := ~(io.dataA | io.dataB)} // NOR
    is(ALU_BIT_XOR) {io.dataOut := io.dataA ^ io.dataB} // XOR
    is(ALU_SLL)     {io.dataOut := io.dataA << io.dataB.asUInt}
    is(ALU_SRL)     {io.dataOut := (io.dataA.asUInt >> io.dataB.asUInt).asSInt}
    is(ALU_SRA)     {io.dataOut := io.dataA >> io.dataB.asUInt}
    is(ALU_ADD)     {io.dataOut := io.dataA +| io.dataB} // ADD
    is(ALU_SUB)     {io.dataOut := io.dataA -| io.dataB} // SUB
    is(ALU_SLT)     {io.dataOut := io.lessThan ? S(1, cfg.dataWidth bit) | S(0, cfg.dataWidth bit)} // SLT
    is(ALU_SLTU)    {io.dataOut := io.uLessThan ? S(1, cfg.dataWidth bit) | S(0, cfg.dataWidth bit)}
    default         {io.dataOut := 0}
  }
  io.zero := io.dataOut === 0
}
