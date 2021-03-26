package SingleCycle.Config

import spinal.core._
import spinal.lib._
import bus.amba4.axi._

case class IMemConfig(
                     depth: Int = 1 << 10
                     )

object IMemConfig {
  val axicfg: Axi4Config = Axi4Config(
    addressWidth = 32, dataWidth = 32
  )
}