/*********************************************************************************
 * Engineer: Nicholas Sica
 * 
 * Create Date: 06/05/2019 09:28:06 PM
 * Design Name: 
 * Module Name: InstructionFetch
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
`include "InstructionCache.sv"

module InstructionFetch(input logic clk, pcSrc, en_pc, en_IF, flush, w_en,
                        input logic[31:0] branchPC, cpu_in,
                        output logic[31:0] pc, instr);
    logic[31:0] nextPC = 32'b0, tempInstr;
    
    always_comb begin
        if(en_pc) begin
            case(pcSrc)
                1'b0: nextPC = pc + 4;
                1'b1: nextPC = branchPC;
            endcase
        end 
        
        if(flush) begin
            instr = 32'b0;
        end else if(en_IF) begin
            instr = tempInstr;           
        end
    end
    
    always_ff @(posedge clk) begin
        if(en_pc) begin
            pc <= nextPC;
        end
    end
    
    InstructionCache instrCache(.w_en, .w_instr(cpu_in), .addr(pc), .instr(tempInstr));
endmodule

