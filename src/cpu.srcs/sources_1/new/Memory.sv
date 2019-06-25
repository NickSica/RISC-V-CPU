`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/05/2019 09:28:32 PM
// Design Name: 
// Module Name: Memory
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


module Memory(input logic clk, 
              input logic[3:0] memWrite,
              input logic[31:0] addr, w_data,
              output logic[31:0] r_data);

    RAM ram(.clka(clk), .ena(1'b1), .wea(memWrite), .addra(addr), .dina(w_data), .douta(r_data));
endmodule
