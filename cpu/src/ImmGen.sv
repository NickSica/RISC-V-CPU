/*********************************************************************************
 * Engineer: Nicholas Sica
 * 
 * Create Date: 10/30/2019 07:34:09 PM
 * Design Name: 
 * Module Name: ImmGen
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

module ImmGen(input logic[31:0] instr_i,
	      output logic[31:0] imm_o);
    always_comb begin
	// I-Type {7'b1100111, 7'b0000011, 7'b0010011}
	// S-Type {7'b0100011}
	// B-Type {7'b1100011}
	// U-Type {7'b0110111, 7'b0010111}
	// J-Type {7'b1101111}
	case(instr_i[6:0])
	  7'b1100111, 7'b0000011, 7'b0010011, 7'b0100011, 7'b1100011, 7'b1101111: imm_o[31:20] = {12{instr_i[31]}};
	  7'b0110111, 7'b0010111: imm_o[31:20] = instr_i[31:20];
	endcase // case (instr_i[6:0])
      
      	case(instr_i[6:0])
	  7'b1100111, 7'b0000011, 7'b0010011, 7'b0100011, 7'b1100011: imm_o[19:12] = {8{instr_i[31]}};
	  7'b0110111, 7'b0010111, 7'b1101111: imm_o[19:12] = instr_i[19:12];
	endcase // case (instr_i[6:0])

	case(instr_i[6:0])
	  7'b1100111, 7'b0000011, 7'b0010011, 7'b0100011: imm_o[11] = instr_i[31];
	  7'b1100011: imm_o[11] = instr_i[7];
	  7'b0110111, 7'b0010111: imm_o[11] = 1'b0;
	  7'b1101111: imm_o[11] = instr_i[20];
	endcase // case (instr_i[6:0])

	case(instr_i[6:0])
	  7'b1100111, 7'b0000011, 7'b0010011, 7'b0100011, 7'b1100011, 7'b1101111: imm_o[10:5] = instr_i[30:25];
	  7'b0110111, 7'b0010111: imm_o[10:5] = 6'b0;
	endcase // case (instr_i[6:0])
	
	case(instr_i[6:0])
	  7'b1100111, 7'b0000011, 7'b0010011, 7'b1101111: imm_o[4:1] = instr_i[24:21];
	  7'b0100011, 7'b1100011: imm_o[4:1] = instr_i[11:8];
	  7'b0110111, 7'b0010111: imm_o[4:1] = 4'b0;
	endcase // case (instr_i[6:0])

	case(instr_i[6:0])
	  7'b1100111, 7'b0000011, 7'b0010011: imm_o[0] = instr_i[20];
	  7'b0100011: imm_o[0] = instr_i[7];
	  7'b1100011, 7'b0110111, 7'b0010111, 7'b1101111: imm_o[0] =1'b0;
	endcase // case (instr_i[6:0])
    end
endmodule: ImmGen







