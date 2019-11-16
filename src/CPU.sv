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
import cpu_pkg::ctrl_signals

module CPU(input logic clk_i, wr_instr_en_i,
           input logic[31:0] wr_instr_i);
    
    // IF Stage Signals
    logic 	 if_flush, if_pc_src = 1'b0; 	 
    logic 	 if_en, if_pc_en = 1'b1;
    logic [31:0] if_instr;
    logic [63:0] branch_pc;
    logic [63:0] if_pc = 64'b0;

    // ID Stage Signals
    control_signals ctrl_signals;
    logic [4:0]  id_rs1_s, id_rs2_s;
    logic [63:0] id_imm, id_rs1_data, id_rs2_data;

    // EX Stage Signals
    logic 	 ex_reg_dst_s, ex_reg_write_s, ex_alu_op_s, ex_alu_src_s, ex_mem_write_s, ex_mem_read_s, ex_mem_to_reg_s;
    logic [4:0]  ex_rd;
    
    // MEM Stage Signals
    logic 	 mem_reg_dst_s, mem_reg_write_s, mem_mem_write_s, mem_mem_read_s, mem_mem_to_reg_s;
    
    // WB Stage Signals
    logic 	 wb_reg_write_s;
    logic [4:0]  wb_rd_s;
    logic [63:0] wb_rd_data_s;

    InstructionFetch if_stage(.clk_i, .pc_src_i(if_pc_src), .pc_en_i(if_pc_en), .if_en_i(if_en), .flush_i(if_flush), .wr_instr_en_i, .branch_pc_i(branch_pc), .wr_instr_i,
                              .pc_o(if_pc), .instr_o(if_instr));

    InstructionDecode id_stage(.clk_i, .wr_reg_en_i(wb_reg_write_s), .ex_rd_i(ex_rd_s), .wb_rd_i(wb_rd_s), .instr_i(if_instr), .rd_data_i(wb_rd_data_s), .pc_i(if_pc),
			       .ctrl_signals_o(ctrl_signals), .pc_src_o(if_pc_src), .flush_o(if_flush), .pc_en_o(if_pc_en), .if_en_o(if_en), .funct3_o(id_funct3), 
			       .funct7_o(id_funct7), .rs1_o(id_rs1), .rs2_o(id_rs2), .imm_o(id_imm), .rs1_data_o(id_rs1_data), .rs2_data_o(id_rs2_data), 
			       .branch_pc_o(branch_pc));
    
    Execute ex_stage(.clk_i, .mem_rd_i(mem_rd), .wb_rd_i(wb_rd), .alu_src_i(ex_alu_src_s), .alu_op_i(ex_alu_op_s), .funct3_i(id_funct3), .rs1_i(id_rs1_s), .rs2_i(id_rs2_s), 
		     .rd_i(id_rd), .mem_rd_i(mem_rd), .wb_rd_i(wb_rd), .funct7_i(id_funct7), .ex_result_i(ex_alu_result), .mem_result_i(mem_alu_result), .imm_i(id_imm), 
		     .rs1_data_i(id_rs1_data), .rs2_data_i(id_rs2_data), 
		     .rd_o(ex_rd_s), .wr_ram_data_o(ex_wr_ram_data), .alu_result_o(ex_alu_result));

    Memory mem_stage(.clk_i, .mem_wr_en_i(ex_mem_wr_en), .mem_addr_i(ex_alu_result), .mem_addr_i(), .wr_data_i(ex_wr_ram_data),
		     .r_data_o(mem_alu_result));

    // Writeback Stage
    always_ff @(posedge clk_i) begin
	wb_rd_s <= mem_rd;
	wb_rd_data_s <= mem_alu_result;
    end

    // Passes the control signals forward
    always_ff @(posedge clk_i) begin
	ex_reg_dst_s <= ctrl_signals.reg_dst;
	ex_reg_write_s <= ctrl_signals.reg_write;
	ex_alu_op_s <= ctrl_signals.alu_op;
	ex_alu_src_s <= ctrl_signals.alu_src;
	ex_mem_write_s <= ctrl_signals.mem_write;
	ex_mem_read_s <= ctrl_signals.mem_read;
	ex_mem_to_reg_s <= ctrl_signals.mem_to_reg;

	mem_reg_dst_s <= ex_reg_dst_s;
	mem_reg_write_s <= ex_reg_write_s;
	mem_mem_write_s <= ex_mem_write_s;
	mem_mem_read_s <= ex_mem_read_s;
	mem_mem_to_reg_s <= ex_mem_to_reg_s;

	wb_reg_write_s <= mem_reg_write_s;
    end // always_ff @ (posedge clk_i)
endmodule: CPU











