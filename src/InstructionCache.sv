/*********************************************************************************
 * Engineer: Nicholas Sica
 * 
 * Create Date: 06/05/2019 06:07:56 PM
 * Design Name: 
 * Module Name: InstructionCache
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

module InstructionCache #(parameter addr_wid = 64, instr_wid = 32, length = 100, bytes_per_word = instr_wid >> 3)
                         (input logic wr_instr_en_i,
                          input logic [instr_wid-1:0] wr_instr_i,
                          input logic [addr_wid-1:0]  addr_i, 
                          output logic [instr_wid-1:0] instr_o);
                        
    logic [length-1:0][instr_wid-1:0] cache_c;
    logic [addr_wid-1:0] 	      r_addr_c = {addr_wid{1'b0}};
    
    always_comb begin
        if(wr_instr_en_i == 1'b1) begin
            cache_c[r_addr_c] = wr_instr_i;
            r_addr_c += 64'b100;
	end
	    
        instr_o = cache_c[addr_i];
    end
endmodule


