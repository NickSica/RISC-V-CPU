/*********************************************************************************
 * Engineer: Nicholas Sica
 * 
 * Create Date: 06/05/2019 09:53:04 PM
 * Design Name: 
 * Module Name: Execute
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

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/06/2019 11:09:15 AM
// Design Name: 
// Module Name: CPU_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module CPU_tb();
   logic[0:9][31:0] machine_code = {32'b000000011110_00000_000_00001_0010011,     // ADDI $1 $0 30
				    32'b000000011110_00000_000_00010_0010011,     // ADDI $2 $0 30
				    32'b0000000_00010_00001_000_01000_1100011,    // BEQ  $1 $2 8     PC(8)+4+8
				    32'b000000011100_00000_000_00001_0010011,     // ADDI $1 $0 28		
				    32'b000000011100_00000_000_00010_0010011,     // ADDI $2 $0 28
				    32'b0000000_00011_00011_000_00110_0110011,    // ADD  $6 $3 $3		
				    32'b0000000_00101_00101_000_00010_0110011,    // ADD  $2 $5 $5		
				    32'b0000000_00010_00001_000_00001_0110011,    // ADD  $1 $2 $1		
				    32'b0000000_00100_00100_000_00010_0110011,    // ADD  $2 $4 $4		
				    32'b0000000_00110_00110_000_00010_0110011     // ADD  $2 $6 $6	  	    
				   };
    logic [31:0]     wr_instr = 32'b0;
    logic [31:0]     ex_instr, mem_instr, wb_instr;
    logic 	     wr_instr_en = 1'b0;
    logic 	     clk = 1'b1;
    logic 	     rst; 	     
    int 	     counter = 0;
    int 	     rs1, rs2, imm, result;
    always #100 clk = !clk;

    CPU cpu(.clk_i(clk), .rst_i(rst), .wr_instr_en_i(wr_instr_en), .wr_instr_i(wr_instr));

    initial begin 
	$monitor("IF Stage Instruction: %32b", cpu.if_instr);
	$monitor("ID Stage Instruction: %32b", cpu.id_stage.instr_r);
	$monitor("EX Stage Instruction: %32b", ex_instr);
	$monitor("EX Stage Result: %32b", cpu.ex_alu_result);
	$monitor("MEM Stage Instruction: %32b", mem_instr);
	$monitor("WB Stage Instruction: %32b", wb_instr);
	rst = 1'b1;
	#300 rst = 1'b0;
    end

    initial begin
	for(int i = 0; i < 9; i++) begin
	    #10 wr_instr_en = 1'b0;
	    wr_instr = machine_code[i];
	    wr_instr_en = 1'b1;
	end
	#10 wr_instr_en = 1'b0;
    end

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
	$display("");
	ex_instr <= cpu.id_stage.instr_r;
	mem_instr <= ex_instr;
	wb_instr <= mem_instr;
	$display("Cycle %0d: Instruction: %32b", counter, wr_instr);
	counter++;
    end
endmodule








