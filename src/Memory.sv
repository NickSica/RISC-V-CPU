`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/05/2019 09:28:32 PM
// Design Name: 
// Module Name: Memory
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Memory(input logic clk_i, mem_wr_en_i, mem_to_reg_i,
              input logic[63:0] mem_addr_i, wr_data_i, alu_result_i,
              output logic [63:0] rd_data_o);

    logic mem_wr_en_s, mem_to_reg_s;
    logic [63:0] r_data, mem_addr_s, wr_data_s, alu_result_s;

    always_ff @(posedge clk_i) begin
	mem_wr_en_s <= mem_wr_en_i;
	mem_to_reg_s <= mem_to_reg_i;
	mem_addr_s <= mem_addr_i;
	wr_data_s <= wr_data_i;
	alu_result_s <= alu_result_i;
    end

    always_comb begin
        case(mem_to_reg_s)
          1'b0: rd_data_o = r_data;
          1'b1: rd_data_o = alu_result_s;
        endcase 
    end 
    
    
    //RAM ram(.clka(clk), .ena(1'b1), .wea(memWrite), .addra(addr), .dina(w_data), .douta(r_data));
endmodule
