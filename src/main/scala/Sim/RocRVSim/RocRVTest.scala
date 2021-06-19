package Sim.RocRVSim

import PipelineCpu.FiveStagesCpu
import spinal.core._
import spinal.core.sim._
import spinal.lib._
import Config._
import scala.beans.BeanProperty
import scala.collection.mutable
import scala.sys.process._
import scala.reflect.io._
import scala.io._
import scala.util.matching.Regex

class RocRVTest[T <: RocRVDut](top: => RocRvTestTop[T]) {
  import RocRVTest._
  var progMain = ""
  var progDir = ""
  val iAddrInstrMap = mutable.HashMap[BigInt, String]()
  val simManager = new RocRVSimManager[T]()

  def compileCppFile(cppFilePath: Path): this.type = {
    progMain = cppFilePath.stripExtension
    progDir = cppFilePath.parent.toString()
    // Insert three phase
    val compilePhase = Process(
      s"$rvGCC ${cppFilePath.toString()} -mabi=lp64 -march=rv64i -o $progDir/$progMain"
    )
    val copyPhase = Process(s"$rvObjCopy -O ihex $progDir/$progMain $progDir/$progMain.hex")
    val dumpLogger = new FileProcessLogger(new java.io.File(s"$progDir/$progMain.d"))
    val dumpPhase = Process(s"$rvObjDump -d $progDir/$progMain -M no-aliases,numeric")
    // Execute the phases
    SpinalInfo(s"Now Compiling $cppFilePath...")
    println(s"$rvGCC ${cppFilePath.toString()} -mabi=lp64 -march=rv64i -o $progDir/$progMain")
    val compile_flag = compilePhase.!
    if (compile_flag != 0) assert(assertion = false, "Compiled Fail!")
    else {
      SpinalInfo(s"Compiled done.")
      SpinalInfo(s"Converting $progMain into Hex file $progMain.hex...")
      println(s"$rvObjCopy -O ihex $progDir/$progMain $progDir/$progMain.hex")
      val copy_flag = copyPhase.!
      if (copy_flag == 0){
        SpinalInfo(s"Converting done.")
      } else {
        assert(assertion = false, s"Convert failed. Flag returned is $copy_flag")
      }
      SpinalInfo(s"Dumping disassembly...")
      println(s"$rvObjDump -d $progDir/$progMain -M no-aliases,numeric > $progDir/$progMain.d")
      val dump_flag = dumpPhase.!(dumpLogger)
      if (dump_flag == 0){
        SpinalInfo(s"Dumping done.")
      } else {
        assert(assertion = false, s"Dump failed. Flag return is $dump_flag")
      }
    }
    this
  }

  def compileAssembly(asmFilePath: Path): this.type = {
    progMain = asmFilePath.stripExtension
    progDir = asmFilePath.parent.toString()
    // insert three phase
    val compilePhase = Process(s"$rvAs -o $progMain.o -march=rv64i -mabi=lp64 $progMain.s")
    val copyPhase = Process(s"$rvObjCopy -O ihex $progDir/$progMain $progDir/$progMain.hex")
    val dumpLogger = new FileProcessLogger(new java.io.File(s"$progDir/$progMain.d"))
    val dumpPhase = Process(s"$rvObjDump -d $progDir/$progMain -M no-aliases,numeric")
    val compile_flag = compilePhase.!
    if (compile_flag != 0) assert(assertion = false, "Compiled Fail!")
    else {
      SpinalInfo(s"Compiled done.")
      SpinalInfo(s"Converting $progMain into Hex file $progMain.hex...")
      println(s"$rvObjCopy -O ihex $progDir/$progMain $progDir/$progMain.hex")
      val copy_flag = copyPhase.!
      if (copy_flag == 0){
        SpinalInfo(s"Converting done.")
      } else {
        assert(assertion = false, s"Convert failed. Flag returned is $copy_flag")
      }
      SpinalInfo(s"Dumping disassembly...")
      println(s"$rvObjDump -d $progDir/$progMain -M no-aliases,numeric > $progDir/$progMain.d")
      val dump_flag = dumpPhase.!(dumpLogger)
      if (dump_flag == 0){
        SpinalInfo(s"Dumping done.")
      } else {
        assert(assertion = false, s"Dump failed. Flag return is $dump_flag")
      }
    }
    this
  }

  def readDumpFile(dumpFile: String = s"$progDir/$progMain.d"): this.type = {
    val dumpSource = Source.fromFile(dumpFile)
    dumpSource.getLines().foreach {line=>
      val instr_pat = "\\s*([0-9a-f]+):\\s+[0-9a-f]{8}\\s+(.*)".r
      instr_pat.findAllMatchIn(line).foreach {m=>
//        SpinalInfo(s"addr: ${m.group(1)}, inst: ${m.group(2)}")
        iAddrInstrMap += BigInt(m.group(1), 16) -> m.group(2)
      }
    }
    dumpSource.close()
    this
  }

  def doSimulate(simConfig: SpinalSimConfig): Unit = {
    simConfig.compile({
      val testTop = top
      testTop.dut.initDCacheWithZeros()
      testTop.dut.initL1ICache(s"$progDir/${progMain}.hex", 0)
      testTop
    }).doSim("RocRVTest"){dut=>
      simManager.setTop(dut)
      simManager.runSim(this)
    }
  }

}

object RocRVTest {
  val rvCplrPreFix = "riscv64-unknown-elf-"
  val rvGCC = rvCplrPreFix + "gcc"
  val rvObjCopy = rvCplrPreFix + "objcopy"
  val rvObjDump = rvCplrPreFix + "objdump"
  val rvAs = rvCplrPreFix + "as"

  def apply(cppFilePath: String)(cpu: => RocRVDut)(
    simConfig: SpinalSimConfig = SimConfig.withWave.allOptimisation.workspacePath("tb")
  ): Unit = {
    val test = new RocRVTest(new RocRvTestTop(() => cpu))
    test.compileCppFile(Path(cppFilePath)).readDumpFile().doSimulate(simConfig)
  }

  class RocRVPreSim[T <: RocRVDut] {
    var _cppFilePath: String = _
    var _cpu: ()=> T = _
    var _simConfig: SpinalSimConfig = SimConfig.withWave.allOptimisation.workspacePath("tb")
    def compile(cppFilePath: String): this.type = {
      _cppFilePath = cppFilePath
      this
    }
    def simulate(cpu: => T): this.type = {
      _cpu = () => cpu
      this
    }
    def configAs(simConfig: SpinalSimConfig): this.type = {
      _simConfig = simConfig
      this
    }
  }

  implicit class RocRVSim[T <: RocRVDut](preSim: RocRVPreSim[T]) {
//    private val _test = new RocRVTest(new RocRvTestTop(preSim._cpu))
    private val _test = new RocRVTest[T]({
      val t = new RocRvTestTop[T](preSim._cpu)
      println("At this Moment, The top module instantiate.")
      t
    })
    _test.compileCppFile(Path(preSim._cppFilePath)).readDumpFile()

    def top = _test.simManager.top
    def dut = _test.simManager.top.dut
    def initial(block: => Unit): Unit = _test.simManager.initial(block)
    def always(block: => Unit): Unit = _test.simManager.always(block)

    def ! : Unit = {
      _test.doSimulate(preSim._simConfig)
    }
  }

  def RiscVSim[T <: RocRVDut] = new RocRVPreSim[T]

  def main(args: Array[String]): Unit = {
    RiscVSim
      .compile("src/main/resource/test_asm_code/memacc/main.c")
      .simulate(new FiveStageCpuDut(RocRvConfig())).!
  }

}
