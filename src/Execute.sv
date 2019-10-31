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
`timescale 1ns / 1ps
`include "Interfaces.sv"
`include "ALU.sv"
`include "ALUControl.sv"
`include "ForwardingUnit.sv"

module Execute(IDtoEX id_ex,  
               EXtoMEM.fwd fwdMEM,
               MEMtoWB.fwd fwdWB,
               output logic[31:0] w_ramData, aluResult);

    logic[31:0] rtData, rsData;
    logic[3:0] ctrlSignal;
    logic[1:0] forwardRs = 2'b0, forwardRt = 2'b0;
    
    ForwardingUnit fwdUnit(.fwdMEM, .fwdWB, .rs(id_ex.rs), .rt(id_ex.rt),
                           .forwardRs, .forwardRt);
                           
    ALUControl aluControl(.aluOp(id_ex.aluOp), .funct(id_ex.imm[5:0]), 
                          .ctrlSignal);
    ALU alu(.ctrlSignal, .op1(rsData), .op2(rtData), 
            .result(aluResult));
                         
    always_comb begin
        case(id_ex.regDst)
            1'b0: id_ex.rd <= id_ex.rt;
            1'b1: id_ex.rd <= id_ex.rd;
        endcase
        
        case(forwardRs)
            2'b00: rsData <= id_ex.rsData;
            2'b01: rsData <= fwdWB.aluResult;
            2'b10: rsData <= fwdMEM.aluResult;
        endcase 
       
        casez({forwardRt, id_ex.aluSrc})
            3'b??1: rtData <= id_ex.imm;
            3'b000: rtData <= id_ex.rtData;
            3'b010: rtData <= fwdWB.aluResult;
            3'b100: rtData <= fwdMEM.aluResult;
        endcase
        
        case(forwardRt)
            2'b00: w_ramData <= id_ex.rtData;
            2'b01: w_ramData <= fwdWB.aluResult;
            2'b10: w_ramData <= fwdMEM.aluResult;
        endcase 
    end 
endmodule: Execute










