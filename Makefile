vivado = vivado -mode batch -source
script = compile.tcl
tb_script = waveform.tcl
constr = ./V707/constraints.xdc

.PHONY: build clean

build:
	$(vivado) $(script) -tclargs $(constr) verilog

test:
	xvlog --nolog --sv src/*
	xvlog --nolog --sv tb/CPU_tb.sv
	xelab --nolog --debug typical CPU_tb -s top_sim
	xsim --nolog top_sim -t waveform.tcl
	xsim --nolog --g --view ./waves/tb.wcfg top_sim

clean: 
	-rm -r build
	-rm vivado*
	-rm webtalk*
	-rm -r x*
