/*********************************************************************************
 * Engineer: Nicholas Sica
 * 
 * Create Date: 11/20/2019 10:19:30 PM
 * Design Name: 
 * Module Name: LRU_tb
 * Project Name: 
 * Target Devices: 
 * Tool Versions: 
 * Description: A cache implemented with cache_type = 0: set associative, 1: direct mapped
 * 
 * Dependencies: 
 * 
 * Revision:
 * Revision 0.01 - File Created
 * Additional Comments:
 * 
*********************************************************************************/
`timescale 1ns / 1ps

module LRU_tb ();
    logic clk = 1'b0;
    logic hit = 1'b0;
    logic hit_valid = 1'b0;
    logic replace_valid;
    logic [9:0] hit_idx = 10'b0;
    logic [9:0] replace_idx;

    always #1 clk = !clk;

    LRU lru(.clk_i(clk), .hit_i(hit), .valid_i(hit_valid), .idx_i(hit_idx), .valid_o(replace_valid), .idx_o(replace_idx));

    initial begin
	hit = 1'b1;
	hit_valid = 1'b1;
	hit_idx = 0;
	#2 hit_idx = 10'b0000000001;
	#2 hit_idx = 10'b0000000011;
	#2 hit_idx = 10'b0000000111;
	#2 hit_idx = 10'b0000000011;
	#2 hit = 1'b0;
    end
    
endmodule: LRU_tb
