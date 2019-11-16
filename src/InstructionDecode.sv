/*********************************************************************************
 * Engineer: Nicholas Sica
 * 
 * Create Date: 06/05/2019 09:38:54 PM
 * Design Name: 
 * Module Name: InstructionDecode
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

module InstructionDecode(input logic         clk_i, wr_reg_en_i,
                         input logic [4:0]   ex_rd_i, wb_rd_i,
                         input logic [31:0]  instr_i,
			 input logic [63:0]  wr_reg_data_i, pc_i,
                         output 	     control_signals_o,
                         output logic 	     pc_src_o, flush_o, pc_en_o, if_en_o,
			 output logic [4:0]  rs1_o, rs2_o,	     
			 output logic [63:0] id_imm_o, id_rs1_data_o, id_rs2_data_o, branch_pc_o);

    logic [63:0] instr_s, wr_reg_data_s, pc_s;
    logic [31:0] instr_s;
    logic [4:0]  ex_rd_s, wb_rd_s, rt_next;
    logic inhibit_ctrl = 1'b0;
    logic wr_reg_en_s;
    
    HazardDetection hazard_detection(.r_mem_en_i(control_signals_o.mem_read), .branch_taken_i(pc_src_o), .ex_rd_i(ex_rd_s), .rs1_i(instr_s[19:15]), .rs2_i(instr_s[24:20]), 
				     .inhibit_ctrl_o(inhibit_ctrl), .flush_o, .pc_en_o, .if_en_o);

    RegisterFile reg_file(.clk_i, .rst_i(1'b0), .rs1_i(instr_s[19:15]), .rs2_i(instr_s[24:20]), .wr_reg_en_i(wr_reg_en_s), .wr_reg_data_i(wr_reg_data_s), .rd_i(wb_rd_s),
                          .rs1_data_o, .rs2_data_o);
                         
    Control ctrl(.inhibit_control_i(inhibit_ctrl), .instr_i(instr_s), 
                 .control_signals_o);
    
    ImmGen imm_gen(.instr_i(instr_s),
		   .imm_o(id_imm_o));
     
    always_comb begin        
        pc_src_o = ((id_rs_data_o == id_rt_data_o) & control_signals_o.beq) | ((id_rs_data_o != id_rt_data_o) & control_signals_o.bne);  // Branch logic
        branch_pc_o = 64'(64'(id_smm_o) + pc_s);  // Branch logic
    end

    always_ff @(posedge clk_s) begin
	instr_s <= instr_i;
	wr_reg_data_s <= wr_reg_data_i;
	pc_s <= pc_i;
	instr_s <= instr_i;
	ex_rd_s <= ex_rd_i;
	wb_rd_s <= wb_rd_i;
	wr_reg_en_s <= wr_reg_en_i;
    end
endmodule







