import spinal.core._
import spinal.lib._

object SelfContainTest extends App{
  class ClassA() {
    private var age: Int = 0

    def setAge(classB: ClassB): Unit = {
      age = classB.age
      println(s"age is ${age}")
    }
  }

  class ClassB(val age: Int) {
    val a = new ClassA()
    a.setAge(this)
  }

  new ClassB(42)
}
