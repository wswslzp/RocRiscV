import spinal.core._
import spinal.core.sim._
import spinal.lib._

object StrCaseTest extends App{

  val a = "shit"
  val b = "game"
  val c = "damn"
  val d = "it"

  def str_match(s: String) = s match {
    case "shit"|"game" => "a or b"
    case "damn"|"it" => "c or d"
    case _ => "other"
  }

  println(str_match(a))
  println(str_match(b))
  println(str_match(c))
  println(str_match(d))

  def formatHex(dat: BigInt, width: Int = 64): String = {
    val hex_str = dat.toString(16)
    assert(width/4 > hex_str.length, s"Provided width $width is less than input data bit width ${hex_str.length}")
    val pos_prefix = "0" * (width/4 - hex_str.length)
    val neg_prefix = "f" * (width/4 - hex_str.length)
    if (hex_str.head > '8') {
      neg_prefix + hex_str
    } else {
      pos_prefix + hex_str
    }
  }

}
