`timescale 1ns / 1ps
/*********************************************************************************
 * Engineer: Nicholas Sica
 * 
 * Create Date: 06/01/2019 08:37:12 PM
 * Design Name: 
 * Module Name: ALUControl
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

module ALUControl(input logic [1:0] alu_op_i,
		  input logic [2:0] funct3_i,
                  input logic [6:0] funct7_i,
                  output logic [3:0] ctrl_signal_o);
    
    always_comb begin
        casez({funct7_i, alu_op_i, funct3_i})
          12'b???????_00_???, 12'b0000000_10_000: ctrl_signal_o = 4'b0010; // Commands that use Add
          12'b???????_01_???, 12'b0100000_10_000: ctrl_signal_o = 4'b0110; // Commands that use Subtract
	  12'b0000000_10_110                    : ctrl_signal_o = 4'b0001; // Commands that use OR
          12'b0000000_10_111                    : ctrl_signal_o = 4'b0000; // Commands that use AND
          //8'b10101010:              ctrl_signal_o = 4'b0111; // Commands that use Set if Less Than??
        endcase
    end
endmodule
