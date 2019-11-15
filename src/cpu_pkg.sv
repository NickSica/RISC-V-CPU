package cpu_pkg;
    struct {
	logic [3:0] mem_write;
	logic [1:0] alu_op;
	logic 	    beq;
	logic 	    bne;
        logic 	    reg_dst;
        logic 	    reg_write;
        logic 	    alu_src;
        logic 	    mem_read;
        logic 	    mem_to_reg;
    } control_signals;
endpackage: cpu_pkg
