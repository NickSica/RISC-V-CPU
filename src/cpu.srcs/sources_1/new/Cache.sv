`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/27/2019 01:04:33 AM
// Design Name: 
// Module Name: Cache
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


module BranchCache#(parameter cacheLength = 100, wordSize = 32)
             (input logic branchTaken,
              input logic[31:0] currInstr, prevInstr,
              output logic predictBranch);
    logic[cacheLength-1:0][wordSize:0] cache = 'b0;
    logic exists = 1'b0;
    int cachePos = 0;
    
    always_comb begin
        for(int i = 0; i < cacheLength; i++) begin
            exists = (cache[i] & prevInstr) | exists;
        end    
        
        if(exists) begin
            
        end else begin
            cache[cachePos] = {prevInstr, branchTaken};
        end 
    end
    
endmodule
