/*********************************************************************************
 * Engineer: Nicholas Sica
 * 
 * Create Date: 06/05/2019 09:53:04 PM
 * Design Name: 
 * Module Name: Execute
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

module Execute(input logic clk_i, mem_fwd_i, wb_fwd_i, reg_dst_i,
	       input logic [4:0] rs1_i, rs2_i,
	       output logic [31:0] w_ramData, aluResult);

    logic [31:0] rtData, rsData;
    logic [3:0]  ctrl_signal;
    logic [1:0]  fwd_rs1 = 2'b0, fwd_rs2 = 2'b0;
    
    ForwardingUnit fwdUnit(.mem_fwd_i, .wb_fwd_i, .rs1_i, .rs2_i,
                           .fwd_rs1, .fwd_rs2);
                           
    ALUControl alu_ctrl(.alu_op_i(), .funct_i(imm_i[:]), 
                        .ctrl_signal_o(.ctrl_signal));
    ALU alu(.ctrl_signal, .op1(rs1_data), .op2(rs2_data), 
            .result(alu_result_o));
                         
    always_comb begin
        case(reg_dst_i)
            1'b0: id_ex.rd <= id_ex.rt;
            1'b1: id_ex.rd <= id_ex.rd;
        endcase
        
        case(forwardRs)
            2'b00: rsData <= id_ex.rsData;
            2'b01: rsData <= fwdWB.aluResult;
            2'b10: rsData <= fwdMEM.aluResult;
        endcase 
       
        casez({forwardRt, id_ex.aluSrc})
            3'b??1: rtData <= id_ex.imm;
            3'b000: rtData <= id_ex.rtData;
            3'b010: rtData <= fwdWB.aluResult;
            3'b100: rtData <= fwdMEM.aluResult;
        endcase
        
        case(forwardRt)
            2'b00: w_ramData <= id_ex.rtData;
            2'b01: w_ramData <= fwdWB.aluResult;
            2'b10: w_ramData <= fwdMEM.aluResult;
        endcase 
    end 
endmodule: Execute










