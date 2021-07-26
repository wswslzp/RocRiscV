import spinal.core._
import spinal.core.sim._
import spinal.lib._
import fiber._

// todo: fiber framework is not support yet.
object GenTest extends App{
  val a, b=  Handle[Int]()
  val calculator = Handle {
    a.get + b.get
  }
  val printer = Handle {
    println(s"a + b = ${calculator.get}")
  }

  a.load(3)
  b.load(4)
}
