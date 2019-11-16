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
    
    logic [63:0] rs1_data, rs2_data, ex_result_s, mem_result_s, imm_s, rs1_data_s, rs2_data_s;
    logic [6:0]  funct7_s;
    logic [4:0]  rs1_s, rs2_s, rd_s, mem_rd_s, wb_rd_s;
    logic [3:0]  alu_ctrl_signal;
    logic [2:0]  funct3_s;
    logic [1:0]  alu_op_s;
    logic [1:0]  fwd_rs1, fwd_rs2 = 2'b0;
    logic 	 mem_reg_write_s, wb_reg_write_s, alu_src_s;
    
    ForwardingUnit fwd_unit(.mem_reg_write_i(mem_reg_write_s), .wb_reg_write_i(wb_reg_write_s), .rs1_i(rs1_s), .rs2_i(rs2_s), .mem_rd_i(mem_rd_s), .wb_rd_i(wb_rd_s),
                           .fwd_rs1_o(fwd_rs1), .fwd_rs2_o(fwd_rs2));
                           
    ALUControl alu_ctrl(.alu_op_i(alu_op_s), .funct3_i(funct3_s), .funct7_i(funct7_s), 
                        .ctrl_signal_o(alu_ctrl_signal));

    ALU alu(.ctrl_signal_i(alu_ctrl_signal), .op1_i(rs1_data), .op2_i(rs2_data),
            .alu_result_o);
        
    always_comb begin
	rd_o = rd_s;
	
        case(fwd_rs1)
            2'b00: rs1_data = rs1_data_s;
            2'b01: rs1_data = mem_result_s;
            2'b10: rs1_data = ex_result_s;
        endcase 
       
        casez({fwd_rs2, alu_src_s})
            3'b??1: rs2_data = imm_s;
            3'b000: rs2_data = rs2_data_s;
            3'b010: rs2_data = mem_result_s;
            3'b100: rs2_data = ex_result_s;
        endcase
        
        case(fwd_rs2)
            2'b00: wr_ram_data_o = rs2_data;
            2'b01: wr_ram_data_o = mem_result_s;
            2'b10: wr_ram_data_o = ex_result_s;
        endcase 
    end // always_comb
    
    always_ff @(posedge clk_i) begin
	mem_reg_write_s <= mem_reg_write_i;
	wb_reg_write_s <= wb_reg_write_i;
	alu_src_s <= alu_src_i;
	alu_op_s <= alu_op_i;
	funct3_s <= funct3_i;
        rs1_s <= rs1_i;
	rs2_s <= rs2_i;
	rd_s <= rd_i;
	mem_rd_s <= mem_rd_i;
	wb_rd_s <= wb_rd_i;
	funct7_s <= funct7_i;
	ex_result_s <= ex_result_i;
	mem_result_s <= mem_result_i;
	imm_s <= imm_i;
	rs1_data_s <= rs1_data_i;
	rs2_data_s <= rs2_data_i;
    end // always_ff @ (posedge clk_i)
endmodule: Execute










