vivado = vivado -mode batch -source
script = compile.tcl
tb_script = waveform.tcl
constr = ./V707/constraints.xdc


VLOG_LRU_SRC_FILES = LRU.sv \
		 LRU_tb.sv

VLOG_SRC_FILES = LRU.sv \
		 Cache.sv \
		 Cache_TB.sv

.PHONY: build clean

build:
	$(vivado) $(script) -tclargs $(constr)

test:
	vlog -sv $(VLOG_SRC_FILES)
	vsim -do cache_wave.do -do "run 30ns" Cache_TB

lru:
	vlog -sv $(VLOG_LRU_SRC_FILES)
	vsim LRU_tb

clean: 
	-rm -r build
	-rm vivado*
	-rm webtalk*
	-rm x*
