package Sim.RocRVSim

import spinal.core.sim._
import Config._
import scala.collection.mutable
import scala.reflect.io._
import scala.io._

class RocRVTest[T <: RocRVDut](top: => RocRvTestTop[T]) {
  private var progMain = ""
  private var progDir = ""
  val iAddrInstrMap = mutable.HashMap[BigInt, String]()
  val simManager = new RocRVSimManager[T]()

  def convertSource(sourceFile: Path): this.type = {
    val scheme = SchemeFactory(sourceFile)
    progDir = scheme.getDir
    progMain = scheme.getMain
    scheme.convert()
    this
  }

  def readDumpFile(dumpFile: String = s"$progDir/$progMain.d"): this.type = {
    val dumpSource = Source.fromFile(dumpFile)
    dumpSource.getLines().foreach {line=>
      val instr_pat = "\\s*([0-9a-f]+):\\s+[0-9a-f]{8}\\s+(.*)".r
      instr_pat.findAllMatchIn(line).foreach {m=>
        iAddrInstrMap += BigInt(m.group(1), 16) -> m.group(2)
      }
    }
    dumpSource.close()
    this
  }

  def doSimulate(simConfig: SpinalSimConfig): Unit = {
    simConfig.compile({
      val testTop = top
      testTop.dut.initDCacheICahce(s"$progDir/$progMain.hex", 0)
      testTop
    }).doSim("RocRVTest"){dut=>
      simManager.setTop(dut)
      simManager.runSim()
    }
  }

  def realtimePrintInstruction(): Unit = {
    simManager.onReset {
      val start_pc = BigInt(top.dut.getRVCfg.initPcAddr)
      println(s"pc: ${start_pc.toString(16)}, inst: ${iAddrInstrMap(start_pc)}")
      top.pushAsciiInstr(iAddrInstrMap(start_pc))
    }
    simManager always {
      val pc = top.getPC
      val inst = iAddrInstrMap.getOrElse(pc, "nop")
      println(s"pc: ${pc.toString(16)}, inst: $inst")
      top.pushAsciiInstr(inst)
    }
  }

  def timeLimitOn(timeLimit: Int): Unit = {
    simManager initial {
      top.clockDomain.waitSampling(timeLimit)
      simManager fail("The test reach the time limit, possibly due to the deadlock in the design. Fix it or enlarge the limit.")
    }
  }

}

object RocRVTest {

  class RocRvSim[T <: RocRVDut] {
    var _srcFilePath: String = _
    var _cpu: ()=> T = _
    var _simConfig: SpinalSimConfig = SimConfig.withWave.allOptimisation.workspacePath("tb")
    private var _test: RocRVTest[T] = _
    def compile(cppFilePath: String): this.type = {
      _srcFilePath = cppFilePath
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
    private def genTest(): Unit = {
      if (_test == null){
        _test = new RocRVTest[T](new RocRvTestTop[T](_cpu))
      }
    }
    def top = {
      genTest()
      _test.simManager.top
    }
    def dut = {
      genTest()
      _test.simManager.top.dut
    }
    def runtimeRecord(): Unit = _test.realtimePrintInstruction()
    def timeLimitOn(cycle: Int): Unit = _test.timeLimitOn(cycle)
    def initial(block: => Unit): Unit = {
      genTest()
      _test.simManager.initial(block)
    }
    def always(block: => Unit): Unit = {
      genTest()
      _test.simManager.always(block)
    }
    def onReset(block: => Unit): Unit = {
      genTest()
      _test.simManager.onReset(block)
    }
    def onExit(block: => Unit): Unit = {
      genTest()
      _test.simManager.onExit(block)
    }
    def success(): Unit = {
      _test.simManager.success()
    }
    def fail(msg: String): Unit = {
      _test.simManager.fail(msg)
    }
    def ! : Unit = {
      genTest()
      _test.convertSource(_srcFilePath).readDumpFile()
      _test.doSimulate(_simConfig)
    }
    def run(src: String): Unit = {
      compile(src)
      this !
    }
  }

  def RiscVSim[T <: RocRVDut] = new RocRvSim[T]

  def main(args: Array[String]): Unit = {
    RiscVSim
      .compile("src/main/resource/test_asm_code/memacc/main.c")
      .simulate(new FiveStageCpuDut(RocRvConfig())).!
  }

}
