package PipelineCpu

import spinal.core._
import spinal.lib._

class FiveStage extends Component with PipelineImpl {
  override val stage = Vector.fill(4)(new Stage())
  override type RefOwnerType = this.type
  concatStage()

  def IFID  = stage(0).setName("IFID")
  def IDEX  = stage(1).setName("IDEX")
  def EXMEM = stage(2).setName("EXMEM")
  def MEMWB = stage(3).setName("MEMWB")
}
