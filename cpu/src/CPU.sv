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
import cpu_pkg::control_signals;

module CPU(input logic clk_i, mem_clk_i, rst_i, wr_instr_en_i,
           input logic[31:0] wr_instr_i, 
	   output logic out_o);
    
    // IF Stage Signals
    logic [63:0] if_pc;
    logic [63:0] branch_pc;
    logic [31:0] if_instr;
    logic 	 if_flush;
    logic 	 if_pc_src; 	 
    logic 	 if_en;
    logic 	 if_pc_en;
    
    // ID Stage Signals
    control_signals ctrl_signals;
    logic [63:0] id_rs1_data, id_rs2_data;
    logic [31:0] id_imm;    
    logic [6:0]  id_funct7;
    logic [4:0]  id_rs1, id_rs2, id_rd;
    logic [2:0]  id_funct3;
    
    // EX Stage Signals
    logic [63:0] ex_alu_result, ex_wr_ram_data;
    logic [4:0]  ex_rd_r;
    logic [2:0]  ex_funct3_r;
    logic [1:0]  ex_alu_op_r;
    logic 	 ex_reg_dst_r, ex_reg_write_r, ex_alu_src_r, ex_mem_write_r, ex_mem_read_r, ex_mem_to_reg_r;
    
    // MEM Stage Signals
    logic [63:0] mem_rd_data;
    logic [4:0]  mem_rd_r;
    logic [2:0]  mem_funct3_r;
    logic 	 mem_reg_dst_r, mem_reg_write_r, mem_mem_write_r, mem_mem_read_r, mem_mem_to_reg_r;
        
    // WB Stage Signals
    logic [63:0] wb_rd_data_r;
    logic [4:0]  wb_rd_r;
    logic 	 wb_reg_write_r;
    
    InstructionFetch if_stage(.clk_i, .rst_i, .pc_src_i(if_pc_src), .pc_en_i(if_pc_en), .if_en_i(if_en), .flush_i(if_flush), .wr_instr_en_i, .branch_pc_i(branch_pc), .wr_instr_i,
                              .pc_o(if_pc), .instr_o(if_instr));

    InstructionDecode id_stage(.clk_i, .rst_i, .wr_reg_en_i(wb_reg_write_r), .ex_rd_i(ex_rd_r), .wb_rd_i(wb_rd_r), .instr_i(if_instr), .rd_data_i(wb_rd_data_r), .pc_i(if_pc),
			       .ex_mem_read_en_i(ex_mem_read_r),
			       .ctrl_signals_o(ctrl_signals), .pc_src_o(if_pc_src), .flush_o(if_flush), .pc_en_o(if_pc_en), .if_en_o(if_en), .funct3_o(id_funct3), 
			       .funct7_o(id_funct7), .rs1_o(id_rs1), .rs2_o(id_rs2), .rd_o(id_rd), .imm_o(id_imm), .rs1_data_o(id_rs1_data), .rs2_data_o(id_rs2_data), 
			       .branch_pc_o(branch_pc));
    
    Execute ex_stage(.clk_i, .rst_i, .mem_reg_write_i(mem_reg_write_r), .wb_reg_write_i(wb_reg_write_r), .alu_src_i(ex_alu_src_r), .alu_op_i(ex_alu_op_r), .funct3_i(id_funct3),
		     .rs1_i(id_rs1), .rs2_i(id_rs2), .rd_i(id_rd), .mem_rd_i(mem_rd_r), .wb_rd_i(wb_rd_r), .funct7_i(id_funct7), .ex_result_i(ex_alu_result),
		     .mem_result_i(mem_rd_data), .imm_i(id_imm), .rs1_data_i(id_rs1_data), .rs2_data_i(id_rs2_data),
		     .rd_o(ex_rd_r), .wr_ram_data_o(ex_wr_ram_data), .alu_result_o(ex_alu_result));

    Memory mem_stage(.clk_i, .mem_clk_i, .mem_wr_en_i(mem_mem_write_r), .mem_rd_en_i(mem_mem_read_r), .mem_to_reg_i(mem_mem_to_reg_r), .funct3_i(mem_funct3_r), 
		     .mem_addr_i(ex_alu_result), .wr_data_i(ex_wr_ram_data), .alu_result_i(ex_alu_result),
		     .rd_data_o(mem_rd_data));

    // Writeback Stage
    always_ff @(posedge clk_i) begin
	wb_rd_r <= mem_rd_r;
	wb_rd_data_r <= mem_rd_data;
    end

    always_comb begin
	out_o = wb_rd_r | wb_rd_data_r;
    end

    // Passes the control signals forward
    always_ff @(posedge clk_i) begin
        ex_funct3_r <= id_funct3;
	ex_reg_dst_r <= ctrl_signals.reg_dst;
	ex_reg_write_r <= ctrl_signals.reg_write;
	ex_alu_op_r <= ctrl_signals.alu_op;
	ex_alu_src_r <= ctrl_signals.alu_src;
	ex_mem_write_r <= ctrl_signals.mem_write;
	ex_mem_read_r <= ctrl_signals.mem_read;
	ex_mem_to_reg_r <= ctrl_signals.mem_to_reg;

        mem_funct3_r  <= ex_funct3_r;
	mem_rd_r      <= ex_rd_r;
	mem_reg_dst_r <= ex_reg_dst_r;
	mem_reg_write_r <= ex_reg_write_r;
	mem_mem_write_r <= ex_mem_write_r;
	mem_mem_read_r <= ex_mem_read_r;
	mem_mem_to_reg_r <= ex_mem_to_reg_r;
	
	wb_reg_write_r <= mem_reg_write_r;
    end // always_ff @ (posedge clk_i)
endmodule: CPU











