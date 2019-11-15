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
`include "InstructionFetch.sv"
`include "InstructionDecode.sv"
`include "Execute.sv"
`include "Memory.sv"
`include "Writeback.sv"

module CPU(input logic clk_i, wr_instr_en_i,
           input logic[31:0] wr_instr_i);

    logic pc_en = 1'b1, if_en = 1'b1, flush = 1'b0, pc_src = 1'b0, alu_src, reg_dst;
    logic [1:0] alu_op;
    logic [4:0] rd;
    logic [31:0] branch_pc, rs_data = 32'b0, rt_data = 32'b0, imm, alu_result, rd_data, wr_ram_data, r_ram_data;
    
    logic [31:0] if_pc = 32'b0, if_instr;
    InstructionFetch if_stage(.clk_i, .pc_src_i(pc_src), .pc_en_i(pc_en), .if_en_i(if_en), .flush_i(flush), .wr_instr_en_i, .branch_pc_i(branch_pc), .wr_instr_i,
                              .pc_o(if_pc), .instr_o(if_instr));

    InstructionDecode id_stage(.clk_i, .pc_i(if_pc), .instr_i(if_instr), .wr_reg_en_i(wr_reg), .wr_reg_dest_i(), .wr_reg_data_i(), .ex_rd_i(ex_rd), .rd_data_i(rd_data),
			       .pc_src_o(pc_src), .flush_o(flush), .pc_en_o(pc_en), .if_en_o(if_en), .imm_o(id_imm), .rs1_data_o(id_rs1_data), 
			       .rs2_data_o(id_rs2_data), .branch_pc_o(branch_pc));

    Execute ex_stage(.fwd_mem_i(ex_fwd), .fwd_wb_i(mem_fwd),
                     .wr_ram_data_o, .alu_result_o());                   
  
    Memory mem_stage(.clk, .mem_wr_en_i(ex_mem_wr_en), .addr_i(ex_alu_result), .wr_ram_data_i(wr_ram_data), .r_ram_data_i(r_ram_data),
		     .alu_result_o(mem_alu_result));
    
    Writeback wb_stage(.memToReg(mem_wb.mem_to_reg), .r_ramData, .alu_result_i(mem_alu_result),
                       .rd_data_o);
endmodule: CPU

`ifndef __INTERFACES__
 `define __INTERFACES__

interface IDtoEX(input logic clk,
                 input logic[31:0] instr, tmpRsData, tmpRtData, tmpImm);
    logic tmpMemRead, memRead, tmpMemToReg, memToReg, tmpRegWrite, regWrite, tmpRegDst, regDst, tmpAluSrc, aluSrc;
    logic[1:0] tmpAluOp, aluOp;
    logic[3:0] tmpMemWrite, memWrite;
    logic[4:0] rs, rt, rd;
    logic[31:0] imm, rsData, rtData;    
    
    always_ff @(posedge clk) begin
        rs       <= instr[25:21];
        rt       <= instr[20:16];
        rd       <= instr[15:11];
        rsData   <= tmpRsData;
        rtData   <= tmpRtData;
        imm      <= tmpImm;
        memWrite <= tmpMemWrite;
        memRead  <= tmpMemRead;
        memToReg <= tmpMemToReg;
        regWrite <= tmpRegWrite;
        regDst   <= tmpRegDst;
        aluOp    <= tmpAluOp;
        aluSrc   <= tmpAluSrc;
    end
    
    modport ex(input memWrite, memRead, regWrite, memToReg, rd);
endinterface: IDtoEX

interface EXtoMEM(IDtoEX.ex ex,
                  input logic clk,
                  input logic[31:0] tmpResult);
    logic regWrite, memToReg;
    logic[3:0] memWrite, memRead;
    logic[4:0] rd;
    logic[31:0] aluResult;
    
    always_ff @(posedge clk) begin
        memWrite  <= ex.memWrite;
        memRead   <= ex.memRead;
        regWrite  <= ex.regWrite;
        memToReg  <= ex.memToReg;
        rd        <= ex.rd;
        aluResult <= tmpResult;
    end
    
    modport mem(input regWrite, memToReg, rd, aluResult);
    modport fwd(input regWrite, aluResult, rd);
endinterface: EXtoMEM

interface MEMtoWB(EXtoMEM.mem mem,
                  input logic clk);
    logic regWrite, memToReg;
    logic[4:0] rd;
    logic[31:0] aluResult;
    
    always_ff @(posedge clk) begin
        rd        <= mem.rd;
        aluResult <= mem.aluResult;
        regWrite  <= mem.regWrite;
        memToReg  <= mem.memToReg;
    end
    
    modport mux(input memToReg, aluResult);
    modport fwd(input rd, regWrite, aluResult);
    modport w_reg(input regWrite, rd);
endinterface: MEMtoWB
`endif




