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
			 input logic [63:0]  rd_data_i, pc_i,
                         output control_signals ctrl_signals_o,
                         output logic 	     pc_src_o, flush_o, pc_en_o, if_en_o,
			 output logic [2:0]  funct3_o,
			 output logic [4:0]  rs1_o, rs2_o, rd_o,
			 output logic [6:0]  funct7_o,
			 output logic [31:0] imm_o,
			 output logic [63:0] rs1_data_o, rs2_data_o, branch_pc_o);

    logic [63:0] rd_data_r, pc_r;
    logic [31:0] instr_r;
    logic [4:0]  ex_rd_r, wb_rd_r, rt_next;
    logic 	 inhibit_ctrl = 1'b0;
    logic 	 wr_reg_en_r;
    
    HazardDetection hazard_detection(.r_mem_en_i(ctrl_signals_o.mem_read), .branch_taken_i(pc_src_o), .ex_rd_i(ex_rd_r), .rs1_i(instr_r[19:15]), .rs2_i(instr_r[24:20]), 
				     .inhibit_ctrl_o(inhibit_ctrl), .flush_o, .pc_en_o, .if_en_o);

    RegisterFile reg_file(.clk_i, .rst_i(1'b0), .rs1_i(instr_r[19:15]), .rs2_i(instr_r[24:20]), .wr_reg_en_i(wr_reg_en_r), .rd_data_i(rd_data_r), .rd_i(wb_rd_r),
                          .rs1_data_o, .rs2_data_o);
                         
    Control ctrl(.inhibit_control_i(inhibit_ctrl), .instr_i(instr_r), 
                 .ctrl_signals_o);
    
    ImmGen imm_gen(.instr_i(instr_r),
		   .imm_o);
     
    always_comb begin
        pc_src_o = ((rs1_data_o == rs2_data_o) & ctrl_signals_o.beq) | ((rs1_data_o != rs2_data_o) & ctrl_signals_o.bne);  // Branch logic
	funct3_o = instr_r[14:12];
	funct7_o = instr_r[31:25];
	rs1_o = instr_r[19:15];
	rs2_o = instr_r[24:20];
	rd_o  = instr_r[11:7];	
        branch_pc_o = 64'(64'(imm_o) + pc_r);  // Branch logic
    end

    always_ff @(posedge clk_i) begin
	instr_r <= instr_i;
	rd_data_r <= rd_data_i;
	pc_r <= pc_i;
	instr_r <= instr_i;
	ex_rd_r <= ex_rd_i;
	wb_rd_r <= wb_rd_i;
	wr_reg_en_r <= wr_reg_en_i;
    end
endmodule







