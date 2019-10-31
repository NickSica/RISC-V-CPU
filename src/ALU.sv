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

module ALU(input logic[3:0] ctrlSignal, 
           input logic[31:0] op1, op2, 
           output logic[31:0] result);
    
    always_comb begin
        case(ctrlSignal)
            4'b0000: result = op1 & op2;                                         // And
            4'b0001: result = op1 | op2;                                         // Or
            4'b0010: result = 32'(op1 + op2);                                    // Addition
            4'b0110: result = 32'(op1 - op2);                                    // Subtraction
            4'b0111: result = (signed'(op1) < signed'(op2)) ? 32'b1 : 32'b0;     // Set if Less than
            //4'b0010: result = op1 << op2[4:0];                                   // Logic left shift
            //4'b0011: result = (signed'(op1) < signed'(op2)) ? 32'b1 : 32'b0;     // Signed less than
            //4'b0100: result = (unsigned'(op1) < unsigned'(op2)) ? 32'b1 : 32'b0; // Unsigned less than
            //4'b0101: result = op1 ^ op2;                                         // Xor
            //4'b0110: result = op1 >> op2[4:0];                                   // Logic right shift
            //4'b0111: result = op1 >>> op2[4:0];                                  // Arithmetic right shift
        endcase
    end 
endmodule: ALU
