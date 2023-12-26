`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/06 16:35:02
// Design Name: 
// Module Name: IDEX_REG
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


module IDEX_REG(
reset,
clk,
Read_1_in,
Read_2_in,
PC_in,
ImmShift_in,
ImmExt_in,
OpCode,
rs_in,
rt_in,
rd_in,
shamt_in,
Funct_in,
Read_1_o,
Read_2_o,
PC_o,
ImmShift_o,
ImmExt_o,
OpCode_o,
rs_o,
rt_o,
rd_o,
shamt_o,
Funct_o,

ExtOp,
LuiOp,
ALUOp,
ALUSrcA,
ALUSrc,
RegDst,
MemRead,
MemWr,
Branch,
MemtoReg,
RegWr,
ExtOp_o,
LuiOp_o,
ALUOp_o,
ALUSrcA_o,
ALUSrc_o,
RegDst_o,
MemRead_o,
MemWr_o,
Branch_o,
MemtoReg_o,
RegWr_o
    );
    
    input reset;
    input clk;
    input [31:0] Read_1_in;
    input [31:0] Read_2_in;
    input [31:0] PC_in;
    input [31:0] ImmShift_in;
    input [31:0] ImmExt_in;
    input [5:0] OpCode;
    input [4:0] rs_in;
    input [4:0] rt_in;
    input [4:0] rd_in;
    input [4:0] shamt_in;
    input [5:0] Funct_in;
    output reg [31:0] Read_1_o;
    output reg [31:0] Read_2_o;
    output reg [31:0] PC_o;
    output reg [31:0] ImmShift_o;
    output reg [31:0] ImmExt_o;
    output reg [5:0] OpCode_o;
    output reg [4:0] rs_o;
    output reg [4:0] rt_o;
    output reg [4:0] rd_o;
    output reg [4:0] shamt_o;
    output reg [5:0] Funct_o;    
    input ExtOp;
    input LuiOp;
    input [3:0] ALUOp;
    input [1:0] ALUSrcA;
    input [1:0] ALUSrc;
    input [1:0] RegDst;
    input MemRead;
    input MemWr;
    input Branch;
    input [1:0] MemtoReg;
    input RegWr;
    output reg ExtOp_o;
    output reg LuiOp_o;
    output reg [3:0] ALUOp_o;
    output reg [1:0] ALUSrcA_o;
    output reg [1:0] ALUSrc_o;
    output reg [1:0] RegDst_o;
    output reg MemRead_o;
    output reg MemWr_o;
    output reg Branch_o;
    output reg [1:0] MemtoReg_o;
    output reg RegWr_o;
        
    always@(posedge reset or posedge clk) 
    begin
      if(reset)
        begin
        Read_1_o<=0;
        Read_2_o<=0;
        PC_o<=0;
        ImmShift_o<=0;
        ImmExt_o<=0;
        OpCode_o<=0;
        rs_o<=0;
        rt_o<=0;
        rd_o<=0;
        shamt_o<=0;
        Funct_o<=0;
        ExtOp_o<=0;
        LuiOp_o<=0;
        ALUOp_o<=0;
        ALUSrcA_o<=0;
        ALUSrc_o<=0;
        RegDst_o<=0;
        MemRead_o<=0;
        MemWr_o<=0;
        Branch_o<=0;
        MemtoReg_o<=0;
        RegWr_o<=0;
      end
      else 
      begin
        Read_1_o<=Read_1_in;
        Read_2_o<= Read_2_in;
        PC_o<=PC_in;
        ImmShift_o<=ImmShift_in;
        ImmExt_o<=ImmExt_in;
        OpCode_o<=OpCode;
        rs_o<=rs_in;
        rt_o<=rt_in;
        rd_o<=rd_in;
        shamt_o<=shamt_in;
        Funct_o<=Funct_in;
        ExtOp_o<=ExtOp;
        LuiOp_o<=LuiOp;
        ALUOp_o<=ALUOp;
        ALUSrcA_o<=ALUSrcA;
        ALUSrc_o<=ALUSrc;
        RegDst_o<=RegDst;
        MemRead_o<=MemRead;
        MemWr_o<=MemWr;
        Branch_o<=Branch;
        MemtoReg_o<=MemtoReg;
        RegWr_o<=RegWr;
      end        
    end
endmodule
