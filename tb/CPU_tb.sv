`timescale 1ns / 1ps
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
   logic[0:10][31:0] machineCode = {32'b000000011110_00000_000_00001_0010011,     // ADDI $1 $0 30
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
   logic [31:0]      cpu_in = 32'b0;
   logic [31:0]      if_instr, id_instr, exe_instr, mem_instr, wb_instr;
   logic       w_en = 1'b1;
   logic       clk = 1'b0;
   int 	       counter = 0;	       
   always #100 clk = !clk;

   CPU cpu(.clk, .w_en, .cpu_in);

   initial begin 
      $monitor("IF Stage Instruction: %32b", cpu.instrFetch.instr);
      $monitor("ID Stage Instruction: %32b", cpu.if_id.instr);
      $monitor("EX Stage Instruction: %32b", cpu.id_ex.instr);
      $monitor("EX Stage Result: %32b", cpu.exe.aluResult);
      $monitor("MEM Stage Instruction: %32b", mem_instr);
      $monitor("WB Stage Instruction: %32b", wb_instr);
   end

   always_ff @(posedge clk) begin
      int rs1 = mem_instr[19:15];
      int rs2 = mem_instr[24:20];
      int imm = mem_instr[31:20];
      if(mem_instr[6:0] == 7'b0110011 && mem_instr[14:12] == 3'b000) begin
	 int result = rs1 + rs2;
	 $display("Add Instruction Actual Result: %0d. Expected Result: %0d", cpu.ex_mem.aluResult, result);
      end 
      else if(mem_instr[6:0] == 7'b0010011 && mem_instr[14:12] == 3'b000) begin
	 int result = rs1 + imm;
	 $display("Addi Instruction Actual Result: %0d. Expected Result: %0d", cpu.ex_mem.aluResult, result);
      end
   end
   
   always_ff @(posedge clk) begin
      $display("");
      cpu_in <= machineCode[counter];
      if_instr  <= cpu.instrFetch.instr;
      id_instr  <= cpu.if_id.instr;
      exe_instr <= id_instr;
      mem_instr <= exe_instr;
      wb_instr <= mem_instr;
      $display("Cycle %0d: Instruction: %32b", counter, cpu_in);
      counter++;
   end


endmodule








