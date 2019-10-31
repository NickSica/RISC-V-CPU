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

module ImmGen(input logic[31:0] instr,
	      output logic[31:0] imm);
   always_comb begin
      // I-Type {7'b1100111, 7'b0000011, 7'b0010011}
      // S-Type {7'b0100011}
      // B-Type {7'b1100011}
      // U-Type {7'b0110111, 7'b0010111}
      // J-Type {7'b1101111}
      case(instr[6:0])
	7'b1100111, 7'b0000011, 7'b0010011, 7'b0100011, 7'b1100011, 7'b1101111: imm[31:20] <= {12{instr[31]}};
	7'b0110111, 7'b0010111: imm[31:20] <= instr[31:20];
      endcase // case (instr[6:0])
      
      case(instr[6:0])
	7'b1100111, 7'b0000011, 7'b0010011, 7'b0100011, 7'b1100011: imm[19:12] <= {8{instr[31]}};
	7'b0110111, 7'b0010111, 7'b1101111: imm[19:12] <= instr[19:12];
      endcase // case (instr[6:0])

      case(instr[6:0])
	7'b1100111, 7'b0000011, 7'b0010011, 7'b0100011: imm[11] <= instr[31];
	7'b1100011: imm[11] <= instr[7];
	7'b0110111, 7'b0010111: imm[11] <= 1'b0;
	7'b1101111: imm[11] <= instr[20];
      endcase // case (instr[6:0])

      case(instr[6:0])
	7'b1100111, 7'b0000011, 7'b0010011, 7'b0100011, 7'b1100011, 7'b1101111: imm[10:5] <= instr[30:25];
	7'b0110111, 7'b0010111: imm[10:5] <= 6'b0;
      endcase // case (instr[6:0])
      
      case(instr[6:0])
	7'b1100111, 7'b0000011, 7'b0010011, 7'b1101111: imm[4:1] <= instr[24:21];
	7'b0100011, 7'b1100011: imm[4:1] <= instr[11:8];
	7'b0110111, 7'b0010111: imm[4:1] <= 4'b0;
      endcase // case (instr[6:0])

      case(instr[6:0])
	7'b1100111, 7'b0000011, 7'b0010011: imm[0] <= instr[20];
	7'b0100011: imm[0] <= instr[7];
	7'b1100011, 7'b0110111, 7'b0010111, 7'b1101111: imm[0] <= 1'b0;
      endcase // case (instr[6:0])
   end
endmodule: ImmGen



