/*********************************************************************************
 * Engineer: Nicholas Sica
 * 
 * Create Date: 06/05/2019 09:28:06 PM
 * Design Name: 
 * Module Name: InstructionFetch
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

module InstructionFetch(input logic clk_i, pc_src_i, pc_en_i, if_en_i, flush_i, wr_instr_en_i,
                        input logic [63:0]  branch_pc_i, 
			input logic [31:0]  wr_instr_i,
                        output logic [63:0] pc_o,
			output logic [31:0] instr_o);
    logic [63:0] pc_c = 64'b0;
    logic [31:0] instr_c;
    
    always_comb begin
        if(pc_en_i) begin
            case(pc_src_i)
                1'b0: pc_c = pc_o + 4;
                1'b1: pc_c = branch_pc_i;
            endcase
        end 
        
        if(flush_i) begin
            instr_o = 32'b0;
        end else if(if_en_i) begin
            instr_o = instr_c;           
        end
    end
    
    always_ff @(posedge clk_i) begin
        if(pc_en_i) begin
            pc_o <= pc_c;
        end
    end
    
    InstructionCache instrCache(.wr_instr_en_i, .wr_instr_i, .addr_i(pc_o), .instr_o(instr_c));
endmodule



