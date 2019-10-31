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

module ALUControl(input logic[1:0] aluOp,
                  input logic[5:0] funct,
                  output logic[3:0] ctrlSignal);
    
    always_comb begin
        casez({aluOp, funct})
            8'b00??????, 8'b10100000: ctrlSignal = 4'b0010; // Commands that use Add
            8'b01??????, 8'b10100010: ctrlSignal = 4'b0110; // Commands that use Subtract
            8'b10100100:              ctrlSignal = 4'b0000; // Commands that use AND
            8'b10100101:              ctrlSignal = 4'b0001; // Commands that use OR
            8'b10101010:              ctrlSignal = 4'b0111; // Commands that use Set if Less Than
        endcase
    end
endmodule
