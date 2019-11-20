vivado = vivado -mode batch -source
script = compile.tcl
tb_script = waveform.tcl
constr = ./V707/constraints.xdc

VLOG_SRC_FILES = src/cpu_pkg.sv \
		 src/ALUControl.sv \
		 src/ALU.sv \
		 src/Cache.sv \
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
		 tb/CPU_tb.sv

.PHONY: build clean

build:
	$(vivado) $(script) -tclargs $(constr) verilog

test:
	xvlog --nolog --sv $(VLOG_SRC_FILES)
	xelab --nolog --debug typical CPU_tb -s top_sim
	xsim --nolog top_sim -t waveform.tcl
	xsim --nolog --g --view ./waves/CPU_tb_behav.wcfg top_sim

clean: 
	-rm -r build
	-rm vivado*
	-rm webtalk*
	-rm -r x*

