`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/02/2019 05:40:12 PM
// Design Name: 
// Module Name: HazardDetection
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


module HazardDetection(input logic memRead, branchTaken, 
                       input logic[4:0] prevRt, rt, rs,                    
                       output logic inhibitControl, flush, en_pc, en_IF);

    always_comb begin
        /*
        if(branchTaken) begin
            en_pc = 1'b1;
            en_IF = 1'b0;
            flush = 1'b1;
            inhibitControl = 1'b0;
        end 
        */
        if( ((prevRt == rs) || (prevRt == rs)) && (memRead == 1'b1) ) begin
            en_pc = 1'b0;
            en_IF = 1'b0;
            flush = 1'b0;
            inhibitControl = 1'b1;
        end
    end
endmodule
