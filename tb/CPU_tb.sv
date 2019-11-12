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
   // THESE ARE NOT CORRECT!!!
   logic[31:0][0:10] machineCode = {32'b001000_00000_00001_0000000000011110,      // ADDI $1 $0 30
				    32'b001000_00000_00010_0000000000011110,      // ADDI $2 $0 30
				    32'b000100_00001_00010_0000000000001000,      // BEQ  $1 $2 8     PC(8)+4+8
				    32'b001000_00000_00001_0000000000011100,      // ADDI $1 $0 28		
				    32'b001000_00000_00010_0000000000011100,      // ADDI $2 $0 28		
				    32'b000000_00011_00011_00110_00000_100000,    // ADD  $6 $3 $3		
				    32'b000000_00101_00101_00010_00000_100000,    // ADD  $2 $5 $5		
				    32'b000000_00010_00001_00001_00000_100000,    // ADD  $1 $2 $1		
				    32'b000000_00100_00100_00010_00000_100000,    // ADD  $2 $4 $4		
				    32'b000000_00110_00110_00010_00000_100000     // ADD  $2 $6 $6	  	    
				   };
   logic [31:0]      cpu_in = 32'b0;
   logic [31:0]      mem_instr;
   logic [31:0]      wb_instr;
   logic       w_en = 1'b0;
   logic       clk = 1'b0;
   int 	       counter = 0;	       
   always #100 clk = !clk;

   CPU cpu(.clk, .w_en, .cpu_in);

   $monitor("IF Stage Instruction: %32b", cpu.instrFetch.instr);
   $monitor("ID Stage Instruction: %32b", cpu.if_id.instr);
   $monitor("EX Stage Instruction: %32b", cpu.id_ex.instr);
   $monitor("EX Stage Result: %32b", cpu.exe.aluResult);
   $monitor("MEM Stage Instruction: %32b", mem_instr);
   $monitor("WB Stage Instruction: %32b", wb_instr);
   
   always_comb begin
      if(wb_instr[6:0] == 7'b)
   end
      
   always_ff @(posedge clk) begin
      $display("");
      cpu_in <= machineCode[counter];
      mem_instr <= cpu.id_ex.instr;
      wb_instr <= mem_instr;
      $display("Cycle %0d: Instruction: %32b", counter, cpu_in);
      counter++;
   end


endmodule








