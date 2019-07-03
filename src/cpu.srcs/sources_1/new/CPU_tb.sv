`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/06/2019 11:09:15 AM
// Design Name: 
// Module Name: CPU_tb
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


module CPU_tb();
    logic[31:0] machineCode = 32'b0;    // Change later
    logic w_en = 1'b0;
    logic clk = 1'b0;
    always #100 clk = !clk;
    initial begin
        #10 machineCode = 32'b001000_00000_00001_0000000000011110;      // ADDI $1 $0 30 
        w_en = 1'b1;
        #10 machineCode = 32'b001000_00000_00010_0000000000011110;      // ADDI $2 $0 30
        #10 machineCode = 32'b000100_00001_00010_0000000000001000;    // BEQ $1 $2 8     PC(8)+4+8
        #10 machineCode = 32'b001000_00000_00001_0000000000011100;      // ADDI $1 $0 28
        #10 machineCode = 32'b001000_00000_00010_0000000000011100;      // ADDI $2 $0 28
        #10 machineCode = 32'b000000_00011_00011_00110_00000_100000;    // ADD $6 $3 $3
        #10 machineCode = 32'b000000_00101_00101_00010_00000_100000;    // ADD $2 $5 $5
        #10 machineCode = 32'b000000_00010_00001_00001_00000_100000;    // ADD $1 $2 $1
        #10 machineCode = 32'b000000_00100_00100_00010_00000_100000;    // ADD $2 $4 $4
        #10 machineCode = 32'b000000_00110_00110_00010_00000_100000;    // ADD $2 $6 $6
    end
    
    CPU cpu(.clk, .w_en, .machineCode);
endmodule
