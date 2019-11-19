/*********************************************************************************
 * Engineer: Nicholas Sica
 * 
 * Create Date: 05/30/2019 03:15:08 PM
 * Design Name: 
 * Module Name: Control
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

module Control(input logic            inhibit_control_i,
               input logic [31:0]     instr_i,
               output control_signals ctrl_signals_o);
    
    always_comb begin
        if(inhibit_control_i == 1'b0) begin
            case(instr_i[6:0])
                6'b000000: begin        // Opcode 0- ALU Stuff
                    ctrl_signals_o.beq       = 1'b0;
                    ctrl_signals_o.bne       = 1'b0;
                    ctrl_signals_o.reg_dst   = 1'b1;
                    ctrl_signals_o.reg_write = 1'b1;
                    ctrl_signals_o.alu_op    = 2'b10;
                    ctrl_signals_o.alu_src   = 1'b0;
                    ctrl_signals_o.mem_write = 4'b0000;
                    ctrl_signals_o.mem_read  = 1'b0;
                end   
                    
                6'b000100: begin        // Opcode 4: BEQ
                    ctrl_signals_o.beq       = 1'b1;
                    ctrl_signals_o.bne       = 1'b0;
                    ctrl_signals_o.reg_write = 1'b0;
                    ctrl_signals_o.alu_op    = 2'b01;
                    ctrl_signals_o.alu_src   = 1'b0;
                    ctrl_signals_o.mem_write = 4'b0000;
                    ctrl_signals_o.mem_read  = 1'b0;
                end
                    
                6'b000101: begin        // Opcode 5: BNE
                    ctrl_signals_o.beq       = 1'b0;
                    ctrl_signals_o.bne       = 1'b1;
                    ctrl_signals_o.reg_write = 1'b0;
                    ctrl_signals_o.alu_op    = 2'b01;
                    ctrl_signals_o.alu_src   = 1'b0;
                    ctrl_signals_o.mem_write = 4'b0000;
                    ctrl_signals_o.mem_read  = 1'b0;
                end
                
                6'b001000: begin        // opcode 8: ADDI
                    ctrl_signals_o.beq        = 1'b0;
                    ctrl_signals_o.bne        = 1'b0;
                    ctrl_signals_o.reg_dst    = 1'b0;
                    ctrl_signals_o.reg_write  = 1'b1;
                    ctrl_signals_o.alu_op     = 2'b00;
                    ctrl_signals_o.alu_src    = 1'b1;
                    ctrl_signals_o.mem_write  = 4'b0000;
                    ctrl_signals_o.mem_read   = 1'b0;
                    ctrl_signals_o.mem_to_reg = 1'b1;
                end
                
                6'b001010: begin        // Opcode 10: SLTI
                    ctrl_signals_o.beq        = 1'b0;
                    ctrl_signals_o.bne        = 1'b0;
                    ctrl_signals_o.reg_dst    = 1'b0;
                    ctrl_signals_o.reg_write  = 1'b1;
                    ctrl_signals_o.alu_op     = 2'b01;
                    ctrl_signals_o.alu_src    = 1'b1;
                    ctrl_signals_o.mem_write  = 4'b0000;
                    ctrl_signals_o.mem_read   = 1'b0;
                    ctrl_signals_o.mem_to_reg = 1'b1;
                end          
                  
                6'b100011: begin        // Opcode 35: LW
                    ctrl_signals_o.beq        = 1'b0;
                    ctrl_signals_o.bne        = 1'b0;
                    ctrl_signals_o.reg_dst    = 1'b0;
                    ctrl_signals_o.reg_write  = 1'b1;
                    ctrl_signals_o.alu_op     = 2'b00;
                    ctrl_signals_o.alu_src    = 1'b1;
                    ctrl_signals_o.mem_write  = 4'b0000; 
                    ctrl_signals_o.mem_read   = 1'b1;
                    ctrl_signals_o.mem_to_reg = 1'b0;
                end
                                
                6'b101011: begin        // Opcode 43: SW
                    ctrl_signals_o.beq       = 1'b0;
                    ctrl_signals_o.bne       = 1'b0;
                    ctrl_signals_o.reg_write = 1'b0;
                    ctrl_signals_o.alu_op    = 2'b00;
                    ctrl_signals_o.alu_src   = 1'b1;
                    ctrl_signals_o.mem_write = 4'b1111;
                    ctrl_signals_o.mem_read  = 1'b0;
                end
            endcase;
        end else begin
            ctrl_signals_o.beq        = 1'b0;
            ctrl_signals_o.bne        = 1'b0;
            ctrl_signals_o.reg_dst    = 1'b0;
            ctrl_signals_o.reg_write  = 1'b0;
            ctrl_signals_o.alu_op     = 2'b00;
            ctrl_signals_o.alu_src    = 1'b0;
            ctrl_signals_o.mem_write  = 4'b0000;
            ctrl_signals_o.mem_read   = 1'b0;
            ctrl_signals_o.mem_to_reg = 1'b0;
        end
    end 
endmodule: Control




