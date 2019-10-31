`timescale 1ns / 1ps
/*********************************************************************************
 * Engineer: Nicholas Sica
 * 
 * Create Date: 05/30/2019 03:34:10 PM
 * Design Name: 
 * Module Name: ForwardingUnit
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
`include "Interfaces.sv"

module ForwardingUnit(EXtoMEM.fwd fwdMEM,
                      MEMtoWB.fwd fwdWB,
                      input logic[4:0] rs, rt,
                      output logic[1:0] forwardRs, forwardRt);
                       
    always_comb begin
        if((fwdMEM.regWrite) && (fwdMEM.rd != 5'b00000) && (fwdMEM.rd == rs)) begin
            forwardRs = 2'b10;
        end else if((fwdWB.regWrite) && (fwdWB.rd != 5'b00000) && (fwdWB.rd == rs)) begin
            forwardRs = 2'b01;
        end else begin
            forwardRs = 1'b00;
        end
        
        if((fwdMEM.regWrite) && (fwdMEM.rd != 5'b00000) && (fwdMEM.rd == rt)) begin
            forwardRt = 2'b10;
        end else if((fwdWB.regWrite) && (fwdWB.rd != 5'b00000) && (fwdWB.rd == rt)) begin
            forwardRt = 2'b01;
        end else begin
            forwardRt = 1'b00;
        end
    end
endmodule
