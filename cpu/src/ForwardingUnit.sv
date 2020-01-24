/*********************************************************************************
 * Engineer: Nicholas Sica
 * 
 * Create Date: 05/30/2019 03:34:10 PM
 * Design Name: 
 * Module Name: ForwardingUnit
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

module ForwardingUnit(input logic rst_i, mem_reg_write_i, wb_reg_write_i,
                      input logic[4:0] rs1_i, rs2_i, mem_rd_i, wb_rd_i,
                      output logic[1:0] fwd_rs1_o, fwd_rs2_o);
                       
    always_comb begin
	if(rst_i) begin
	    fwd_rs1_o = 2'b0;
	    fwd_rs2_o = 2'b0;
	end else begin
            if((mem_reg_write_i) && (mem_rd_i != 5'b00000) && (mem_rd_i == rs1_i)) begin
		fwd_rs1_o = 2'b10;
            end else if((wb_reg_write_i) && (wb_rd_i != 5'b00000) && (wb_rd_i == rs1_i)) begin
		fwd_rs1_o = 2'b01;
            end else begin
		fwd_rs1_o = 2'b00;
            end
            
            if((mem_reg_write_i) && (mem_rd_i != 5'b00000) && (mem_rd_i == rs2_i)) begin
		fwd_rs2_o = 2'b10;
            end else if((wb_reg_write_i) && (wb_rd_i != 5'b00000) && (wb_rd_i == rs2_i)) begin
		fwd_rs2_o = 2'b01;
            end else begin
		fwd_rs2_o = 2'b00;
            end
	end // else: !if(rst_i)
    end // always_comb
endmodule



