/*********************************************************************************
 * Engineer: Nicholas Sica
 * 
 * Create Date: 06/05/2019 09:53:29 PM
 * Design Name: 
 * Module Name: Writeback
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

module Writeback(input logic mem_to_reg_i,
                 input logic[63:0] mem_data_i, alu_result_i,
                 output logic[63:0] rd_data_o);
                 
    always_comb begin
        case(mem_to_reg_i)
            1'b0: rd_data_o = mem_data_i;
            1'b1: rd_data_o = alu_result_i;
        endcase 
    end 
endmodule
