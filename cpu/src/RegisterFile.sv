module RegisterFile(input logic clk_i, rst_i, wr_reg_en_i,
                    input logic[4:0] rd_i, rs1_i, rs2_i,
                    input logic[63:0] rd_data_i,
                    output logic[63:0] rs1_data_o, rs2_data_o);
     
    logic[31:0][63:0] registers_r = {32{64'b0}};

    always_ff @(posedge clk_i) begin
        if(!rst_i) begin
            if(wr_reg_en_i && (rd_i != 0)) begin
                registers_r[rd_i] <= rd_data_i;
            end
        end 
    end 

    always_comb begin
        if(rst_i || (rs1_i == 0)) begin
            rs1_data_o = 64'b0;
        end else if(rs1_i == rd_i) begin
            rs1_data_o = rd_data_i;
        end else begin 
            rs1_data_o = registers_r[rs1_i];
        end 
    end

    always_comb begin
        if(rst_i || (rs2_i == 0)) begin
            rs2_data_o = 64'b0;
        end else if(rs2_i == rd_i) begin
            rs2_data_o = rd_data_i;
        end else begin
            rs2_data_o = registers_r[rs2_i];
        end 
    end
endmodule: RegisterFile
