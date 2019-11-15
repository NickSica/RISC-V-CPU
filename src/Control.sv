`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/30/2019 03:15:08 PM
// Design Name: 
// Module Name: Control
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
import cpu_pkg::control_signals;

module _control(input logic inhibit_control_i,
               input logic[31:0] instr_i,
               output control_signals_o);
    
    always_comb begin
        if(inhibit_control_i == 1'b0) begin
            case(instr_i[6:0])
                6'b000000: begin        // Opcode 0- ALU Stuff
                    control_signals.beq         = 1'b0;
                    control_signals.bne         = 1'b0;
                    control_signals.reg_dst   = 1'b1;
                    control_signals.reg_write = 1'b1;
                    control_signals.alu_op    = 2'b10;
                    control_signals.alu_src   = 1'b0;
                    control_signals.mem_write = 4'b0000;
                    control_signals.mem_read  = 1'b0;
                end   
                    
                6'b000100: begin        // Opcode 4: BEQ
                    control_signals.beq         = 1'b1;
                    control_signals.bne         = 1'b0;
                    control_signals.reg_write = 1'b0;
                    control_signals.alu_op    = 2'b01;
                    control_signals.alu_src   = 1'b0;
                    control_signals.mem_write = 4'b0000;
                    control_signals.mem_read  = 1'b0;
                end
                    
                6'b000101: begin        // Opcode 5: BNE
                    control_signals.beq               = 1'b0;
                    control_signals.bne               = 1'b1;
                    control_signals.reg_write = 1'b0;
                    control_signals.alu_op    = 2'b01;
                    control_signals.alu_src   = 1'b0;
                    control_signals.mem_write = 4'b0000;
                    control_signals.mem_read  = 1'b0;
                end
                
                6'b001000: begin        // opcode 8: ADDI
                    control_signals.beq       = 1'b0;
                    control_signals.bne       = 1'b0;
                    control_signals.reg_dst   = 1'b0;
                    control_signals.reg_write = 1'b1;
                    control_signals.alu_op    = 2'b00;
                    control_signals.alu_src   = 1'b1;
                    control_signals.mem_write = 4'b0000;
                    control_signals.mem_read  = 1'b0;
                    control_signals.mem_to_reg = 1'b1;
                end
                
                6'b001010: begin        // Opcode 10: SLTI
                    control_signals.beq       = 1'b0;
                    control_signals.bne       = 1'b0;
                    control_signals.reg_dst   = 1'b0;
                    control_signals.reg_write = 1'b1;
                    control_signals.alu_op    = 2'b01;
                    control_signals.alu_src   = 1'b1;
                    control_signals.mem_write = 4'b0000;
                    control_signals.mem_read  = 1'b0;
                    control_signals.mem_to_reg = 1'b1;
                end          
                  
                6'b100011: begin        // Opcode 35: LW
                    control_signals.beq       = 1'b0;
                    control_signals.bne       = 1'b0;
                    control_signals.reg_dst   = 1'b0;
                    control_signals.reg_write = 1'b1;
                    control_signals.alu_op    = 2'b00;
                    control_signals.alu_src   = 1'b1;
                    control_signals.mem_write = 4'b0000; 
                    control_signals.mem_read  = 1'b1;
                    control_signals.mem_to_reg = 1'b0;
                end
                                
                6'b101011: begin        // Opcode 43: SW
                    control_signals.beq       = 1'b0;
                    control_signals.bne       = 1'b0;
                    control_signals.reg_write = 1'b0;
                    control_signals.alu_op    = 2'b00;
                    control_signals.alu_src   = 1'b1;
                    control_signals.mem_write = 4'b1111;
                    control_signals.mem_read  = 1'b0;
                end
            endcase;
        end else begin
            control_signals.beq       = 1'b0;
            control_signals.bne       = 1'b0;
            control_signals.reg_dst   = 1'b0;
            control_signals.reg_write = 1'b0;
            control_signals.alu_op    = 2'b00;
            control_signals.alu_src   = 1'b0;
            control_signals.mem_write = 4'b0000;
            control_signals.mem_read  = 1'b0;
            control_signals.mem_to_reg = 1'b0;
        end
    end 
endmodule: _control


