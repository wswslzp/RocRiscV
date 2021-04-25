package PipelineCpu

import spinal.core._
import spinal.core.sim._
import spinal.lib._

object StageRegSpace {
  object Instruction extends StageReg(Bits(32 bit))
  object PC extends StageReg(Bits(64 bit))

}
