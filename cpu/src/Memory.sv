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


module Memory(input logic clk_i, mem_clk_i, mem_wr_en_i, mem_rd_en_i, mem_to_reg_i,
              input logic [2:0] funct3_i,
              input logic [63:0] mem_addr_i, wr_data_i, alu_result_i,
              output logic [63:0] rd_data_o);

    logic [63:0] r_data, mem_addr_r, wr_data_r, alu_result_r;

    always_ff @(posedge clk_i) begin
	mem_addr_r <= (mem_addr_i << 3);
        wr_data_r <= wr_data_i;
	alu_result_r <= alu_result_i;
    end

    always_comb begin
        case(mem_to_reg_i)
            1'b0: rd_data_o = r_data;
            1'b1: rd_data_o = alu_result_r;
        endcase
    end    
    
    Cache cache (.clk_i(mem_clk_i), .wr_en_i(mem_wr_en_i), .rd_en_i(mem_rd_en_i), .rst_i(rst), .addr_i(mem_addr_r | funct3_i), .data_i(wr_data_r), 
		 .data_o(r_data));

    //RAM ram(.clka(clk), .ena(1'b1), .wea(memWrite), .addra(addr), .dina(w_data), .douta(r_data));
endmodule




