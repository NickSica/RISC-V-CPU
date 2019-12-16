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
import cpu_pkg::control_signals;

module Control(input logic        inhibit_control_i,
               input logic [31:0] instr_i,
	       output logic 	  is_branch_o, 
               output control_signals ctrl_signals_o);
    
    always_comb begin
        if(inhibit_control_i == 1'b0) begin
            case(instr_i[6:2])
              5'b01100: begin        // R-Type
                  ctrl_signals_o.reg_dst   = 1'b1;
                  ctrl_signals_o.reg_write = 1'b1;
                  ctrl_signals_o.alu_op    = 2'b10;
                  ctrl_signals_o.alu_src   = 1'b0;
                  ctrl_signals_o.mem_write = 4'b0000;
                  ctrl_signals_o.mem_read  = 1'b0;
		  ctrl_signals_o.mem_to_reg = 1'b1;
		  is_branch_o = 1'b0;		    
              end   
              
              5'b11000: begin        // SB-Type
                  ctrl_signals_o.reg_write = 1'b0;
                  ctrl_signals_o.alu_op    = 2'b01;
                  ctrl_signals_o.alu_src   = 1'b0;
                  ctrl_signals_o.mem_write = 4'b0000;
                  ctrl_signals_o.mem_read  = 1'b0;
		  is_branch_o = 1'b1;
              end
              
              5'b00100: begin        // I-Type not including Loads
                  ctrl_signals_o.reg_dst    = 1'b0;
                  ctrl_signals_o.reg_write  = 1'b1;
                  ctrl_signals_o.alu_op     = 2'b10;
                  ctrl_signals_o.alu_src    = 1'b1;
                  ctrl_signals_o.mem_write  = 4'b0000;
                  ctrl_signals_o.mem_read   = 1'b0;
                  ctrl_signals_o.mem_to_reg = 1'b1;
		  is_branch_o = 1'b0;		    
              end
              
              5'b00000: begin        // Loads
                  ctrl_signals_o.reg_dst    = 1'b0;
                  ctrl_signals_o.reg_write  = 1'b1;
                  ctrl_signals_o.alu_op     = 2'b00;
                  ctrl_signals_o.alu_src    = 1'b1;
                  ctrl_signals_o.mem_write  = 4'b0000; 
                  ctrl_signals_o.mem_read   = 1'b1;
                  ctrl_signals_o.mem_to_reg = 1'b0;
		  is_branch_o = 1'b0;		    
              end
              
              5'b01000: begin        // S-Type
                  ctrl_signals_o.reg_write = 1'b0;
                  ctrl_signals_o.alu_op    = 2'b00;
                  ctrl_signals_o.alu_src   = 1'b1;
                  ctrl_signals_o.mem_write = 4'b1111;
                  ctrl_signals_o.mem_read  = 1'b0;
		  is_branch_o = 1'b0;		    
              end
	      
	      default: begin
		  ctrl_signals_o.reg_dst    = 1'b0;
		  ctrl_signals_o.reg_write  = 1'b0;
		  ctrl_signals_o.alu_op     = 2'b00;
		  ctrl_signals_o.alu_src    = 1'b0;
		  ctrl_signals_o.mem_write  = 4'b0000;
		  ctrl_signals_o.mem_read   = 1'b0;
		  ctrl_signals_o.mem_to_reg = 1'b0;
		  is_branch_o = 1'b0;		    
	      end 
            endcase;
        end else begin
            ctrl_signals_o.reg_dst    = 1'b0;
            ctrl_signals_o.reg_write  = 1'b0;
            ctrl_signals_o.alu_op     = 2'b00;
            ctrl_signals_o.alu_src    = 1'b0;
            ctrl_signals_o.mem_write  = 4'b0000;
            ctrl_signals_o.mem_read   = 1'b0;
            ctrl_signals_o.mem_to_reg = 1'b0;
	    is_branch_o = 1'b0;		    
        end
    end 
endmodule: Control




