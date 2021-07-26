import spinal.core._
import spinal.core.sim._
import spinal.lib._

import java.io.{File, PrintWriter}
import scala.sys.process._

object DumpTest extends App{

//  val dumpLogger = new FileProcessLogger(new java.io.File("./a.d"))
  val dumpfile = new File("/mnt/d/lzp/riscv/rvroc/a.d")
  val writer = new PrintWriter(dumpfile)
  val logger = ProcessLogger({s=>
    println("FUCK: " + s)
    writer.println(s)
  })
//  Process("ps -ef").run(logger)
  Process("ps -ef").!(logger)
//  Process("ps -ef").!!(logger)
  writer.close()
}
