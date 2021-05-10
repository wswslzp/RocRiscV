package PipelineCpu

import spinal.core._
import spinal.lib._
import Config.RocRvConfig
import ALU_CTRL_CMD._

case class AluCtrlUnit(cfg: RocRvConfig) extends Component {
  val io = new Bundle {
    val alu_op = in Bits(2 bit)
    val arith_type = in Bits(4 bit)
    val is_imm = in Bool()
    val ctrl = out Bits(4 bit)
  }

  switch(io.alu_op){
    is(B"00"){io.ctrl := ALU_ADD}
    is(B"01"){io.ctrl := ALU_SUB}
    is(B"10"){
      switch(io.arith_type(2 downto 0)){
        is(B"000"){
          when(!io.is_imm && io.arith_type.msb){
            io.ctrl := ALU_SUB
          } otherwise(
            io.ctrl := ALU_ADD
          )
        }
        is(B"001"){io.ctrl := ALU_SLL}
        is(B"010"){io.ctrl := ALU_SLT}
        is(B"011"){io.ctrl := ALU_SLTU}
        is(B"100"){io.ctrl := ALU_BIT_XOR}
        is(B"101"){
          when(io.arith_type.msb){
            io.ctrl := ALU_SRA
          } otherwise(
            io.ctrl := ALU_SRL
            )
        }
        is(B"110"){io.ctrl := ALU_BIT_OR}
        is(B"111"){io.ctrl := ALU_BIT_AND}
      }
    }
    is(B"11"){io.ctrl := ALU_ADD}
  }
}
