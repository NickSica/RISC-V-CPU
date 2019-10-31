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
`include "InstructionFetch.sv"
`include "InstructionDecode.sv"
`include "Execute.sv"
`include "Memory.sv"
`include "Writeback.sv"

module CPU(input logic clk, w_en,
           input logic[31:0] machineCode);
    
    logic en_pc = 1'b1, en_IF = 1'b1, flush = 1'b0, pcSrc = 1'b0, aluSrc, regDst;
    logic[1:0] aluOp;
    logic[4:0] rd;
    logic[31:0] pc = 32'b0, instr, branchPC, rsData = 32'b0, rtData = 32'b0, imm, aluResult, rdData, w_ramData, r_ramData;
    
    InstructionFetch instrFetch(.clk, .pcSrc, .en_pc, .en_IF, .flush, .w_en, .branchPC, .machineCode,
                                .pc, .instr);
    IFtoID if_id(.clk, .tmpPC(pc), .tmpInstr(instr));
                                
    InstructionDecode instrDec(.if_id, .clk, .w_reg(mem_wb.w_reg), .prevRt(id_ex.rt), .rdData,
                               .id_ex, .pcSrc, .flush, .en_pc, .en_IF, .imm, .rsData, .rtData, .branchPC);
    IDtoEX id_ex(.clk, .instr(if_id.instr), .tmpRsData(rsData), .tmpRtData(rtData), .tmpImm(imm));
     
    Execute exe(.id_ex, .fwdMEM(ex_mem.fwd), .fwdWB(mem_wb.fwd),
                .w_ramData, .aluResult);                   
    EXtoMEM ex_mem(.ex(id_ex.ex), .clk, .tmpResult(aluResult));
  
    Memory mem(.clk, .memWrite(ex_mem.memWrite), .addr(ex_mem.aluResult), .w_data(w_ramData), .r_data(r_ramData));
    MEMtoWB mem_wb(.clk, .mem(ex_mem.mem)); 
    
    Writeback wb(.memToReg(mem_wb.memToReg), .r_ramData, .aluResult(mem_wb.aluResult),
                 .rdData);
endmodule: CPU
