vivado = vivado -mode batch -source
script = compile.tcl
tb_script = waveform.tcl
constr = ./V707/constraints.xdc

VLOG_SRC_FILES = src/cpu_pkg.sv \
		 src/fpga_cores/cache/data_cache.sv \
		 src/fpga_cores/cache/LRU.sv \
		 src/ALUControl.sv \
		 src/ALU.sv \
		 src/Control.sv \
		 src/CPU.sv \
		 src/Execute.sv \
		 src/ForwardingUnit.sv \
		 src/HazardDetection.sv \
		 src/ImmGen.sv \
		 src/InstructionCache.sv \
		 src/InstructionDecode.sv \
		 src/InstructionFetch.sv \
		 src/Interfaces.sv \
		 src/Memory.sv \
		 src/RegisterFile.sv \
		 src/Writeback.sv \
		 tb/tb.sv

.PHONY: build clean

build:
	$(vivado) $(script) -tclargs $(constr)

test:
	vlog -sv $(VLOG_SRC_FILES)
	vsim -do wave.do -do "run -all" +nowarn3691 tb 

clean: 
	-rm -r build
	-rm vivado*
	-rm webtalk*
	-rm x*

