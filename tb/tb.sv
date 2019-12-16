/*********************************************************************************
 * Engineer: Nicholas Sica
 * 
 * Create Date: 06/06/2019 11:09:15 AM
 * Design Name: 
 * Module Name: tb
 * Project Name: RISC-V-CPU
 * Target Devices: 
 * Tool Versions: 
 * Description: 
 * 
 * Dependencies: 
 * 
 * Revision:
 * Revision 0.01 - File Created
 * Additional Comments:
 * 
*********************************************************************************/
`timescale 1ns / 1ps

typedef enum logic [6:0] {
    ALU_OP   = 7'b0110011,
    STORE    = 7'b0100011,
    LOAD     = 7'b0000011,
    ALU_OP_I = 7'b0010011,
    BRANCH   = 7'b1100011
} instr_type_t;

typedef struct {
    instr_type_t instr_type;
    logic [31:0] imm;
    logic [4:0]  rd, rs1, rs2;
    logic [2:0]  funct3;
} full_instr_t;

module tb();
    full_instr_t     instrs [0:9];
    logic [31:0]     wr_instr = 32'b0;
    logic [31:0]     ex_instr, mem_instr, wb_instr;
    logic 	     wr_instr_en = 1'b0;
    logic 	     mem_clk = 1'b0;
    logic        clk = 1'b0;
    logic 	     rst; 	     
    int 	     counter = 0;
    int 	     rs1, rs2, imm, result;
    always #4 clk = !clk;
    always #1 mem_clk = !mem_clk;

    CPU cpu(.clk_i(clk), .mem_clk_i(mem_clk), .rst_i(rst), .wr_instr_en_i(wr_instr_en), .wr_instr_i(wr_instr), .out_o());

    initial begin
	int result;
	int fd = $fopen("tb/test01", "r");
	int init_counter = 0;
	while(!($feof(fd))) begin
	    logic [6:0] op;
	    int 	imm, rd, rs1, rs2;
	    logic [2:0] funct3;
	    result = $fscanf(fd, "%7b,%d,%d,%d,%d,%3b", op, imm, rd, rs1, rs2, funct3);
	    instrs[init_counter] = '{instr_type_t'{op}, imm, rd, rs1, rs2, funct3};
	    init_counter++;	    
	end
	$fclose(fd);
	$readmemb("tb/test01.dat", cpu.if_stage.instr_cache.cache_c);
	$readmemb("src/fpga_cores/cache/ram.dat", cpu.mem_stage.cache.ram);
	rst = 1'b1;
	#12 rst = 1'b0;
    end

    /*
    initial begin
	for(int i = 0; i < 9; i++) begin
	    #10 wr_instr_en = 1'b0;
	    wr_instr = machine_code[i];
	    wr_instr_en = 1'b1;
	end
	#10 wr_instr_en = 1'b0;
    end
     */

    always_ff @(posedge clk) begin
	rs1 = mem_instr[19:15];
	rs2 = mem_instr[24:20];
	imm = mem_instr[31:20];
	if(mem_instr[6:0] == 7'b0110011 && mem_instr[14:12] == 3'b000) begin
	    result = rs1 + rs2;
	    $display("Add Instruction Actual Result: %0d. Expected Result: %0d", cpu.ex_alu_result, result);
	end 
	else if(mem_instr[6:0] == 7'b0010011 && mem_instr[14:12] == 3'b000) begin
	    result = rs1 + imm;
	    $display("Addi Instruction Actual Result: %0d. Expected Result: %0d", cpu.ex_alu_result, result);
	end
    end
    
    always_ff @(posedge clk) begin
	ex_instr <= cpu.id_stage.instr_r;
	mem_instr <= ex_instr;
	wb_instr <= mem_instr;

	if(counter == 30) begin
	    $exit();
	end else begin
	    counter++;
	end
    end // always_ff @ (posedge clk)

    always_ff @(negedge clk) begin
	$display("");
	$display("IF Stage Instruction: %32b", cpu.if_stage.instr_o);
	$display("ID Stage Instruction: %32b", cpu.id_stage.instr_r);
	$display("EX Stage Instruction: %32b", ex_instr);
	$display("EX Stage Result: %32b", cpu.ex_alu_result);
	$display("MEM Stage Instruction: %32b", mem_instr);
	$display("WB Stage Instruction: %32b", wb_instr);
    end
endmodule










