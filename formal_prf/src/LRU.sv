/*********************************************************************************
 * Engineer: Nicholas Sica
 * 
 * Create Date: 11/07/2019 04:53:04 PM
 * Design Name: 
 * Module Name: Cache
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

module LRU #(cache_type = 0, cache_size = 1024, associativity = 3, word_wid = 64, idx_wid = 3)
    (input logic clk_i, hit_i, valid_i, rst_i, en_i, inval_entry_i,
     input logic [idx_wid-1:0] 	idx_i, inval_entry_idx_i,
     output logic 		        valid_o,
     output logic [idx_wid-1:0] idx_o);

    logic [associativity-1:0][idx_wid:0] lru_shift_registers = {associativity{ {(idx_wid+1){1'b0}} }};  // bit 10 is a valid bit to make sure the data is valid
    logic [associativity-1:0] 		             reg_equals_idx;
    logic [associativity-1:0] 		             shift_reg_en;
    
    always_comb begin
        if(en_i) begin
    	    for(int i = associativity-1; i >= 0; i--) begin
	            reg_equals_idx[i] = ~hit_i | (idx_i != lru_shift_registers[i][idx_wid-1:0]);
	        end
        end else begin
            reg_equals_idx = {associativity{1'b0}};
        end
    end
    
    always_comb begin
        shift_reg_en[associativity-1] = reg_equals_idx[associativity-1] & valid_i;
        for(int j = associativity-2; j >= 0; j--) begin
            shift_reg_en[j] = shift_reg_en[j+1] & reg_equals_idx[j];
        end

        if(~hit_i & valid_i & en_i) begin
            valid_o = 1'b1;
        end else begin
            valid_o = 1'b0;
        end

        if(inval_entry_i) begin
            idx_o = inval_entry_idx_i;
        end else begin
	        idx_o = lru_shift_registers[0][idx_wid-1:0];
        end
    end // always_comb
    
    always_ff @(posedge clk_i) begin
        if(&shift_reg_en & ~inval_entry_i) begin
            lru_shift_registers[associativity-1] <= lru_shift_registers[0]; // instead of the below if statement in working version
	    end else if(shift_reg_en[associativity-1]) begin
	        lru_shift_registers[associativity-1] <= {1'b1, idx_i}; // instead of the below if statement in working version
	    end
        
	    for(int j = 0; j < associativity-1; j++) begin
	        if(shift_reg_en[j+1]) begin
	            lru_shift_registers[j] <= lru_shift_registers[j+1];
	        end	    
	    end
    end // always_ff @ (posedge clk_i)
endmodule: LRU






