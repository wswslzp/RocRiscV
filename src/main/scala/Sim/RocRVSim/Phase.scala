package Sim.RocRVSim

import scala.reflect.io._
import scala.sys.process.{FileProcessLogger, Process, ProcessLogger}
import java.io.PrintWriter

abstract class Phase(rootFilePath: Path) {
  def getDir = rootFilePath.parent.toString()
  def getMain = rootFilePath.stripExtension

  def convert(): Unit
  def outFile: List[String]
}

object Phase {
//  val rvCplrPreFix = "riscv64-unknown-elf-"
  var rvCplrPreFix = "riscv64-linux-gnu-"
  var rvGCC = rvCplrPreFix + "gcc"
  var rvObjCopy = rvCplrPreFix + "objcopy"
  var rvObjDump = rvCplrPreFix + "objdump"
  var rvAs = rvCplrPreFix + "as"
  var arch = "rv64idf"
  var abi = "lp64"
}

case class NopPhase() extends Phase("nop/nop.nop") {
  override def convert(): Unit = {}

  override def outFile = "" :: Nil
}

case class Cpp2Bin(rootFile: Path) extends Phase(rootFile) {
  import Phase._

  override def convert(): Unit = {
    println(s"$rvGCC ${rootFile.toString()} -mabi=$abi -march=$arch -o $getDir/$getMain")
    Process(s"$rvGCC ${rootFile.toString()} -mabi=$abi -march=$arch -o $getDir/$getMain").!
    println(s"Compiled Done.")
  }

  override def outFile = s"$getDir/$getMain" :: Nil
}

case class Asm2Bin(rootFile: Path) extends Phase(rootFile) {
  import Phase._

  override def convert(): Unit = {
    println(s"$rvAs -o $getMain -march=$arch -mabi=$abi $getMain.s")
    Process(s"$rvAs -o $getMain -march=$arch -mabi=$abi $getMain.s").!
    println(s"Compiled Done.")
  }

  override def outFile = s"$getDir/$getMain" :: Nil
}

case class Bin2Dump(binFile: Path) extends Phase(binFile) {
  import Phase._

  override def convert(): Unit = {
    val writer = new PrintWriter(new java.io.File(s"$getDir/$getMain.d"))
    val dumpLogger = ProcessLogger({s=>
      writer.println(s)
    })
    println(s"$rvObjDump -d $binFile -M no-aliases,numeric")
    Process(s"$rvObjDump -d $binFile -M no-aliases,numeric").!(dumpLogger)
    println("Dump done.")
    writer.close()
  }

  override def outFile = s"$getDir/$getMain.d" :: Nil
}

case class Bin2Hex(binFile: Path) extends Phase(binFile) {
  import Phase._

  override def convert(): Unit = {
    println(s"$rvObjCopy -O ihex $binFile $getDir/$getMain.hex")
    Process(s"$rvObjCopy -O ihex $binFile $getDir/$getMain.hex").!
    println("Copy done.")
  }

  override def outFile = s"$getDir/$getMain.hex" :: Nil
}

abstract class Scheme(rootFilePath: Path) extends Phase(rootFilePath) {
  val root: Phase
  val leafPhases: List[Phase]

  override def convert(): Unit = {
    root.convert()
    leafPhases.foreach(_.convert())
  }

  override def outFile = leafPhases.flatMap(_.outFile)
}

case class NopScheme() extends Scheme("nop/nop.nop") {
  override val root = NopPhase()
  override val leafPhases = NopPhase() :: Nil
}

case class CppScheme(cppFile: Path) extends Scheme(cppFile){
  override val root = Cpp2Bin(cppFile)
  override val leafPhases = List(
    Bin2Hex(root.outFile.head),
    Bin2Dump(root.outFile.head)
  )
}

case class AsmScheme(asmFile: Path) extends Scheme(asmFile){
  override val root = Asm2Bin(asmFile)
  override val leafPhases = List(
    Bin2Hex(root.outFile.head),
    Bin2Dump(root.outFile.head)
  )
}

case class ObjScheme(binFile: Path) extends Scheme(binFile) {
  override val root = NopPhase()
  override val leafPhases = List(
    Bin2Hex(binFile),
    Bin2Dump(binFile)
  )
}

class SchemeFactory(filePath: Path) {
  def build(): Scheme = {
    filePath.extension match {
      case "cpp"=> CppScheme(filePath)
      case "c"  => CppScheme(filePath)
      case "asm"=> CppScheme(filePath)
      case "s"  => AsmScheme(filePath)
      case ""|"elf"   => ObjScheme(filePath)
      case _    => NopScheme()
    }
  }
}

object SchemeFactory {
  def apply(filePath: Path): Scheme = new SchemeFactory(filePath).build()
}
