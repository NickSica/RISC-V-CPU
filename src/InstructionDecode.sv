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

module InstructionDecode(input logic         clk_i, wr_reg_en_i, wr_reg_dest_i,
                         input logic [4:0]   ex_rd_i,
                         input logic [31:0]  instr_i, pc_i,
			 input logic [63:0]  wr_reg_data_i,
                         output 	     control_signals_o,
                         output logic 	     pc_src_o, flush_o, pc_en_o, if_en_o,
                         output logic [31:0] id_imm_o, id_rs1_data_o, id_rs2_data_o, branch_pc_o);
   logic inhibit_ctrl = 1'b0;
   logic[4:0] rt_next;
    
   HazardDetection hazard_detection(.r_mem_en_i(control_signals_o.mem_read), .branch_taken_i(pc_src_o), .ex_rd_i, .rs1_i(instr_i[19:15]), .rs2_i(if_id.instr[24:20]), 
				    .inhibit_ctrl_o(inhibit_ctrl), .flush_o, .pc_en_o, .if_en_o);

   RegisterFile reg_file(.clk_i, .rst_i(1'b0), .rs1_i(instr_i[19:15]), .rs2_i(instr_i[24:20]), .wr_reg_en_i, .wr_reg_data_i, .wr_reg_dest_i,
                        .rs1_data_o, .rs2_data_o);
                         
   Control ctrl(.inhibit_control_i(inhibit_ctrl), .instr_i(instr_i), 
                .control_signals_o);
   
   ImmGen imm_gen(.instr_i,
		  .imm_i(id_imm_o));
     
   always_comb begin        
        pc_src_o = ((id_rs_data_o == id_rt_data_o) & control_signals_o.beq) | ((id_rs_data_o != id_rt_data_o) & control_signals_o.bne);  // Branch logic
        branch_pc_o = 32'(32'(id_imm_o) + pc_i);  // Branch logic
   end
endmodule







