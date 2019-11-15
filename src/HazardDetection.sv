`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/02/2019 05:40:12 PM
// Design Name: 
// Module Name: HazardDetection
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

module HazardDetection(input logic r_mem_en_i, branch_taken_i,
                       input logic[4:0] ex_rd_i, rs1_i, rs2_i,
                       output logic inhibit_ctrl_o, flush_o, pc_en_o, if_en_o);

    always_comb begin
        if(branch_taken_i) begin
            pc_en_o = 1'b1;
            if_en_o = 1'b0;
            flush_o = 1'b1;
            inhibit_ctrl_o = 1'b0;
        end 
        
        if(((ex_rd_i == rs1_i) || (ex_rd_i == rs2_i)) && (r_mem_en_i == 1'b1)) begin
            pc_en_o = 1'b0;
            if_en_o = 1'b0;
            flush_o = 1'b0;
            inhibit_ctrl_o = 1'b1;
        end
    end
endmodule: HazardDetection



