vivado = vivado -mode tcl -source
script = compile.tcl
constr = Basys3_Master.xdc

.PHONY: build clean

build:
	$(vivado) $(script) -tclargs $(constr) verilog
        
clean: build
	rm -r build
