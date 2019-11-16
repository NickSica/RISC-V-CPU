/*********************************************************************************
 * Engineer: Nicholas Sica
 * 
 * Create Date: 06/05/2019 09:53:04 PM
 * Design Name: 
 * Module Name: ALU
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

module ALU(input logic[3:0] ctrl_signal_i, 
           input logic[63:0] op1_i, op2_i,
           output logic[63:0] alu_result_o);
    
    always_comb begin
        case(ctrl_signal_i)
            4'b0000: alu_result_o = op1_i & op2_i;                                         // And
            4'b0001: alu_result_o = op1_i | op2_i;                                         // Or
            4'b0010: alu_result_o = 64'(op1_i + op2_i);                                    // Addition
            4'b0110: alu_result_o = 64'(op1_i - op2_i);                                    // Subtraction
            //4'b0111: alu_result_o = (signed'(op1_i) < signed'(op2_i)) ? 32'b1 : 32'b0;     // Set if Less than
            //4'b0010: alu_result_o = op1_i << op2_i[4:0];                                   // Logic left shift
            //4'b0011: alu_result_o = (signed'(op1_i) < signed'(op2_i)) ? 32'b1 : 32'b0;     // Signed less than
            //4'b0100: alu_result_o = (unsigned'(op1_i) < unsigned'(op2_i)) ? 32'b1 : 32'b0; // Unsigned less than
            //4'b0101: alu_result_o = op1_i ^ op2_i;                                         // Xor
            //4'b0110: alu_result_o = op1_i >> op2_i[4:0];                                   // Logic right shift
            //4'b0111: alu_result_o = op1_i >>> op2_i[4:0];                                  // Arithmetic right shift
        endcase
    end 
endmodule: ALU
