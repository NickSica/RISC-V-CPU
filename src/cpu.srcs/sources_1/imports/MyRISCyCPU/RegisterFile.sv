module RegisterFile(input logic clk, rst, w_en,
                    input logic[4:0] rd, rs, rt,
                    input logic[31:0] rdData,
                    output logic[31:0] rsData, rtData);
     
    logic[31:0][31:0] regs = 31'b0;

    always_ff @(posedge clk) begin
        if(!rst) begin
            if(w_en && (rd != 0)) begin
                regs[rd] = rdData;
            end
        end 
    end 

    always_comb begin
        if(rst || (rs == 0)) begin
            rsData = 32'b0;
        end else if(rs == rd) begin
            rsData = rdData;
        end else begin 
            rsData = regs[rs];
        end 
    end

    always_comb begin
        if(rst || (rt == 0)) begin
            rtData = 32'b0;
        end else if(rt == rd) begin
            rtData = rdData;        
        end else begin
            rtData = regs[rt];
        end 
    end
endmodule: RegisterFile