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

module Cache #(cache_type = 0, cache_size = 5, associativity = 3, word_num = 32, word_wid = 64) 
    (input logic en_i, clk_i, rst_i,
     input logic [31:0] addr_i,
     output logic [7:0] data_o);

    parameter int 	IDX_WID = $ceil($clog2(associativity));   
    //typedef logic [word_num-1:0][data_wid/8-1:0][7:0] block_t;
    //typedef block_t [cache_size-1:0] data_cache_t;
    //typedef enum { IDLE, READ_0, READ_1, READ_2, READ_3  } state_t;
    //state_t state = IDLE;

    logic [63:0] ram [0:4095];
    //logic [32:0] 				      ram_data, r_data;

    logic [associativity-1:0] hit = {associativity{1'b0}};
    logic [associativity-1:0] hit_valid = {associativity{1'b0}};
    logic [IDX_WID:0] 	      hit_idx = {IDX_WID+1{1'b0}};
    logic [associativity-1:0] inval_entry = {associativity{1'b0}};
    logic [IDX_WID:0] 	      inval_entry_idx = {IDX_WID+1{1'b0}};
    
    logic [cache_size-1:0][IDX_WID:0] 	      replace_idx;
    logic [cache_size-1:0] 		      replace_valid;    
 
    initial begin
	    assert(word_wid % 8 == 0);
    end

    genvar i;
    generate
	if(cache_type == 0) begin  // set associative
	    logic [cache_size-1:0][associativity-1:0][14:0] tag_store = {cache_size{ {associativity{15'b0}} }};  // { valid bit, 14 bit tag store }
	    logic [cache_size-1:0][associativity-1:0][word_wid-1:0] data_store = {cache_size{ {associativity{ {word_wid{1'b0}} }} }};
	    
	    for(i = 0; i < cache_size; i++) begin: g_lru
		    LRU #(cache_type, cache_size, associativity, word_wid) lru(.clk_i, .en_i(addr_i[24:22] == i), .hit_i(|hit), .rst_i, .valid_i(|hit_valid), 
                                                                       .idx_i(hit_idx), .inval_entry_i(|inval_entry), .inval_entry_idx_i(inval_entry_idx),
		    						                                   .valid_o(replace_valid[i]), .idx_o(replace_idx[i]));
	    end // block: g_lru

	    always_ff @(posedge clk_i) begin
	        if(replace_valid[addr_i[24:22]]) begin
	    	    data_store[addr_i[24:22]][replace_idx[addr_i[24:22]]] <= ram[addr_i[31:8]];
	    	    tag_store[addr_i[24:22]][replace_idx[addr_i[24:22]]] <= {1'b1, addr_i[21:8]};
	        end
	    end

	    always_latch begin
            inval_entry = {associativity{1'b0}};
            for(logic[IDX_WID-1:0] k = 0; k < associativity; k++) begin
                if(~tag_store[addr_i[24:22]][k][14]) begin
                    hit_valid[k] = 1'b1;
                    hit[k] = 1'b0;
                    inval_entry_idx = k;
                    inval_entry[k] = 1'b1;
		        end else if(tag_store[addr_i[24:22]][k][13:0] == addr_i[21:8]) begin
                    hit_valid[k] = 1'b1;
		            hit[k] = 1'b1;
		            hit_idx = k;
		        end else begin
		    	    hit[k] = 1'b0;
		            hit_valid[k] = 1'b1;
		        end 
            end // for (int k = 0; k < associativity; k++)
	    end // always_ff @ (posedge clk_i)
        
	end else if(cache_type == 1) begin  // direct mapped
	    logic [cache_size-1:0][14:0] tag_store;  // { valid bit, 14 bit tag store }
	    logic [cache_size-1:0][word_wid-1:0] data_store;
	    
	    always_ff @(posedge clk_i) begin
		    if(tag_store[addr_i[17:8]] == addr_i[31:18]) begin
		        hit <= 1'b1;
//		        data_o <= (data_store[addr_i[17:8]][addr_i[7:3]][((addr_i[2:0] + 1) << 3) : (addr_i[2:0] << 3)] & (8'b11111111 << (addr_i[2:0] << 3)));
		    end else begin
		        hit <= 1'b0;	    
		    end
	    end
	end // if (is_associative)      
    endgenerate
endmodule: Cache















