`ifndef __INTERFACES__
 `define __INTERFACES__

interface IFtoID(input logic clk,
                 input logic[31:0] tmpPC, tmpInstr);
    logic[31:0] pc, instr;
    
    always_ff @(posedge clk) begin
        instr <= tmpInstr;
        pc    <= tmpPC;
    end 
endinterface: IFtoID

interface IDtoEX(input logic clk,
                 input logic[31:0] instr, tmpRsData, tmpRtData, tmpImm);
    logic tmpMemRead, memRead, tmpMemToReg, memToReg, tmpRegWrite, regWrite, tmpRegDst, regDst, tmpAluSrc, aluSrc;
    logic[1:0] tmpAluOp, aluOp;
    logic[3:0] tmpMemWrite, memWrite;
    logic[4:0] rs, rt, rd;
    logic[31:0] imm, rsData, rtData;    
    
    always_ff @(posedge clk) begin
        rs       <= instr[25:21];
        rt       <= instr[20:16];
        rd       <= instr[15:11];
        rsData   <= tmpRsData;
        rtData   <= tmpRtData;
        imm      <= tmpImm;
        memWrite <= tmpMemWrite;
        memRead  <= tmpMemRead;
        memToReg <= tmpMemToReg;
        regWrite <= tmpRegWrite;
        regDst   <= tmpRegDst;
        aluOp    <= tmpAluOp;
        aluSrc   <= tmpAluSrc;
    end
    
    modport ex(input memWrite, memRead, regWrite, memToReg, rd);
endinterface: IDtoEX

interface EXtoMEM(IDtoEX.ex ex,
                  input logic clk,
                  input logic[31:0] tmpResult);
    logic regWrite, memToReg;
    logic[3:0] memWrite, memRead;
    logic[4:0] rd;
    logic[31:0] aluResult;
    
    always_ff @(posedge clk) begin
        memWrite  <= ex.memWrite;
        memRead   <= ex.memRead;
        regWrite  <= ex.regWrite;
        memToReg  <= ex.memToReg;
        rd        <= ex.rd;
        aluResult <= tmpResult;
    end
    
    modport mem(input regWrite, memToReg, rd, aluResult);
    modport fwd(input regWrite, aluResult, rd);
endinterface: EXtoMEM

interface MEMtoWB(EXtoMEM.mem mem,
                  input logic clk);
    logic regWrite, memToReg;
    logic[4:0] rd;
    logic[31:0] aluResult;
    
    always_ff @(posedge clk) begin
        rd        <= mem.rd;
        aluResult <= mem.aluResult;
        regWrite  <= mem.regWrite;
        memToReg  <= mem.memToReg;
    end
    
    modport mux(input memToReg, aluResult);
    modport fwd(input rd, regWrite, aluResult);
    modport w_reg(input regWrite, rd);
endinterface: MEMtoWB
`endif






