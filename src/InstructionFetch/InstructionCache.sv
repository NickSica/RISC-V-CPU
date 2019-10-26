`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/05/2019 06:07:56 PM
// Design Name: 
// Module Name: InstructionCache
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


module InstructionCache#(parameter addrW = 32, instrW = 32, length = 100, bytesPerWord = instrW >> 3)
                        (input logic w_en,
                         input logic[instrW-1:0] w_instr,
                         input logic[addrW-1:0] addr, 
                         output logic[instrW-1:0] instr);
                        
    logic[length-1:0][instrW-1:0] cache;
    logic[addrW-1:0] w_addr = {addrW{1'b0}};
    
    always_comb begin
        if(w_en == 1'b1) begin
            cache[w_addr] = w_instr;
            w_addr = w_addr + 32'b100;
        end
        
        instr <= cache[addr];
    end
endmodule
