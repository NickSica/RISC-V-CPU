`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/05/2019 09:38:54 PM
// Design Name: 
// Module Name: InstructionDecode
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module InstructionDecode(IFtoID if_id,
                         MEMtoWB.w_reg w_reg,
                         input logic clk,
                         input logic[4:0] prevRt,
                         input logic[31:0] rdData,
                         IDtoEX id_ex,
                         output logic pcSrc, flush, en_pc, en_IF,
                         output logic[31:0] imm, rsData, rtData, branchPC);
    logic inhibitControl = 1'b0, beq = 1'b0, bne = 1'b0;
    logic[4:0] rtNext;
    
    HazardDetection hazDet(.memRead(id_ex.memRead), .branchTaken(pcSrc), .prevRt, .rt(if_id.instr[20:16]), .rs(if_id.instr[25:21]), 
                           .inhibitControl, .flush, .en_pc, .en_IF);
                           
    RegisterFile regFile(.clk, .rst(1'b0), .w_en(w_reg.regWrite), .rd(w_reg.rd), .rs(if_id.instr[25:21]), .rt(if_id.instr[20:16]), .rdData(rdData),
                         .rsData, .rtData);
                         
    Control ctrl(.inhibitControl, .instr(if_id.instr), 
                 .id_ex, .beq, .bne);
    
    always_comb begin        
        pcSrc = ((rsData == rtData) & beq) | ((rsData != rtData) & bne);  // Branch logic
        branchPC = 32'(32'(imm) + if_id.pc);  // Branch logic
        imm <= { {16{if_id.instr[15]}}, if_id.instr[15:0] };
    end
endmodule
