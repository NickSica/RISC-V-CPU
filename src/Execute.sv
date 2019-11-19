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

module Execute(input logic clk_i, mem_reg_write_i, wb_reg_write_i, alu_src_i,
	       input logic [1:0]   alu_op_i,   
	       input logic [2:0]   funct3_i,
	       input logic [4:0]   rs1_i, rs2_i, rd_i, mem_rd_i, wb_rd_i,
	       input logic [6:0]   funct7_i,
	       input logic [63:0]  ex_result_i, mem_result_i, imm_i, rs1_data_i, rs2_data_i,
	       output logic [4:0]  rd_o,
	       output logic [63:0] wr_ram_data_o, alu_result_o);
    
    logic [63:0] rs1_data, rs2_data, ex_result_r, mem_result_r, imm_r, rs1_data_r, rs2_data_r;
    logic [6:0]  funct7_r;
    logic [4:0]  rs1_r, rs2_r, mem_rd_r, wb_rd_r;
    logic [3:0]  alu_ctrl_signal;
    logic [2:0]  funct3_r;
    logic [1:0]  alu_op_r;
    logic [1:0]  fwd_rs1, fwd_rs2 = 2'b0;
    logic 	 mem_reg_write_r, wb_reg_write_r, alu_src_r;
    
    ForwardingUnit fwd_unit(.mem_reg_write_i(mem_reg_write_r), .wb_reg_write_i(wb_reg_write_r), .rs1_i(rs1_r), .rs2_i(rs2_r), .mem_rd_i(mem_rd_r), .wb_rd_i(wb_rd_r),
                           .fwd_rs1_o(fwd_rs1), .fwd_rs2_o(fwd_rs2));
                           
    ALUControl alu_ctrl(.alu_op_i(alu_op_r), .funct3_i(funct3_r), .funct7_i(funct7_r), 
                        .ctrl_signal_o(alu_ctrl_signal));

    ALU alu(.ctrl_signal_i(alu_ctrl_signal), .op1_i(rs1_data), .op2_i(rs2_data),
            .alu_result_o);
        
    always_comb begin
        case(fwd_rs1)
            2'b00: rs1_data = rs1_data_r;
            2'b01: rs1_data = mem_result_r;
            2'b10: rs1_data = ex_result_r;
        endcase 
       
        casez({fwd_rs2, alu_src_r})
            3'b??1: rs2_data = imm_r;
            3'b000: rs2_data = rs2_data_r;
            3'b010: rs2_data = mem_result_r;
            3'b100: rs2_data = ex_result_r;
        endcase
        
        case(fwd_rs2)
            2'b00: wr_ram_data_o = rs2_data;
            2'b01: wr_ram_data_o = mem_result_r;
            2'b10: wr_ram_data_o = ex_result_r;
        endcase 
    end // always_comb
    
    always_ff @(posedge clk_i) begin
	mem_reg_write_r <= mem_reg_write_i;
	wb_reg_write_r <= wb_reg_write_i;
	alu_src_r <= alu_src_i;
	alu_op_r <= alu_op_i;
	funct3_r <= funct3_i;
        rs1_r <= rs1_i;
	rs2_r <= rs2_i;
	rd_o <= rd_i;
	mem_rd_r <= mem_rd_i;
	wb_rd_r <= wb_rd_i;
	funct7_r <= funct7_i;
	ex_result_r <= ex_result_i;
	mem_result_r <= mem_result_i;
	imm_r <= imm_i;
	rs1_data_r <= rs1_data_i;
	rs2_data_r <= rs2_data_i;
    end // always_ff @ (posedge clk_i)
endmodule: Execute










