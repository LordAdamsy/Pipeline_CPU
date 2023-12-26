`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/05 21:47:13
// Design Name: 
// Module Name: IFID_REG
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


module IFID_REG(
reset,
clk,
IFID_PC_in,
inst,
IFID_PC_o,
inst_o,
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
Jump
    );
    input  reset;
    input  clk;
    input  [31:0] IFID_PC_in;
    input  [31:0] inst;
    output reg [31:0] IFID_PC_o;
    output reg [31:0] inst_o;
    output reg ExtOp;
    output reg LuiOp;
    output reg [3:0] ALUOp;
    output reg [1:0] ALUSrc;
    output reg [1:0] ALUSrcA;
    output reg [1:0] RegDst;
    output reg MemRead;
    output reg MemWr;
    output reg [1:0] MemtoReg;
    output reg Branch;
    output reg RegWr;
    output reg [1:0] Jump;
   
    wire [5:0] OpCode;
    wire [5:0] Funct;
    
    assign OpCode=inst[31:26];
    assign Funct=inst[5:0];
    
    always @(posedge reset or posedge clk) begin
    if(reset)
      begin
      IFID_PC_o<=0;
      inst_o<=0;
      ExtOp<=0;
      LuiOp<=0;
      RegWr<=0;
      ALUSrc<=0;
      RegDst<=0;
      MemRead<=0;
      ALUSrcA<=0;
      MemWr<=0;
      MemtoReg<=0;
      Branch<=0;
      Jump<=0;
      end
    else 
    begin
     IFID_PC_o<=IFID_PC_in;
     inst_o<=inst; 
     if(OpCode==6'b0&&Funct!=6'h0&&Funct!=6'h02&&Funct!=6'h03&&Funct!=6'h08&&Funct!=6'h09)//R型指令
        begin
        RegDst<=2'b01;
        ALUSrc<=1'b00;
        ALUSrcA<=2'b00;
        Branch<=1'b0;
        MemRead<=1'b0;
        MemWr<=1'b0;
        RegWr<=1'b1;
        MemtoReg<=2'b00;
        Jump<=2'b00;
        end
      else if(OpCode==6'h23)//lw
        begin
        RegDst<=2'b00;
        ALUSrc<=2'b10;
        ALUSrcA<=2'b00;
        Branch<=1'b0;
        MemRead<=1'b1;
        MemWr<=1'b0;
        RegWr<=1'b1;
        MemtoReg<=2'b01; 
        Jump<=2'b00;
        end
      else if(OpCode==6'h2b)//sw    
        begin
        ALUSrc<=2'b10;
        ALUSrcA<=2'b00;
        Branch<=1'b0;
        MemRead<=1'b0;
        MemWr<=1'b1;
        RegWr<=1'b0;   
        Jump<=2'b00;
        end
      else if(OpCode==6'h04||OpCode==6'h11||OpCode==6'h12||OpCode==6'h13||OpCode==6'h14||OpCode==6'h15)//beq,bne,bgez,bgtz,blez,bltz
        begin
        ALUSrc<=2'b00;
        ALUSrcA<=2'b00;
        Branch<=1'b1;
        MemRead<=1'b0;
        MemWr<=1'b0;
        RegWr<=1'b0;  
        Jump<=2'b00;
        LuiOp<=1'b0;
        ExtOp<=1'b1;
        end
      else if(OpCode==6'h0f)//lui
        begin
        ALUSrc<=2'b10;
        ALUSrcA<=2'b00;
        RegDst<=2'b00;
        RegWr<=1'b1;
        MemWr<=1'b0;
        MemtoReg<=2'b00;
        LuiOp<=1'b1;
        ExtOp<=1'b1;
        Jump<=2'b00;
        Branch<=1'b0;
        end
      else if(OpCode==6'h08||OpCode==6'h0c||OpCode==6'h0a||OpCode==6'h0b)//其他i指令且需要符号拓展
        begin
        ALUSrc<=2'b10;
        ALUSrcA<=2'b00;
        RegDst<=2'b00;
        RegWr<=1'b1;
        MemtoReg<=2'b00;
        MemWr<=1'b0;
        Branch<=1'b0;
        ExtOp<=1'b1;
        LuiOp<=1'b0;
        Jump<=2'b00;
        end
      else if(OpCode==6'h09)//无符号拓展的i指令
        begin
        ALUSrc<=2'b10;
        ALUSrcA<=2'b00;
        RegDst<=2'b00;
        RegWr<=1'b1;
        MemtoReg<=2'b00;
        MemWr<=1'b0;
        Branch<=1'b0;  
        ExtOp<=2'b10;
        LuiOp<=1'b0;    
        Jump<=2'b00;    
        end
      else if(OpCode==6'h0&&(Funct==6'h0||Funct==6'h2||Funct==6'h3))//sll,sra,srl指令
        begin
        ALUSrcA<=2'b11;
        ALUSrc<=2'b00;
        RegDst<=2'b01;
        RegWr<=1'b1;
        MemRead<=1'b0;
        MemWr<=1'b0;
        Branch<=1'b0;
        MemtoReg<=2'b00;
        Jump<=2'b00;
        end
      else if(OpCode==6'h02)//j
        begin
        Jump<=2'b01;
        MemRead<=1'b0;
        MemWr<=1'b0;   
        Branch<=1'b0;   
        RegWr<=1'b0;  
        end
      else if(OpCode==6'h03)//jal
        begin
        RegWr<=1'b1;
        Jump<=2'b01;
        RegDst<=2'b10;
        ALUSrcA<=2'b10;
        ALUSrc<=2'b01;
        MemRead<=1'b0;
        MemWr<=1'b0;
        MemtoReg<=2'b00;
        Branch<=1'b0;
        end
      else if(OpCode==6'h0&&Funct==6'h08)//jr
        begin
        Jump<=2'b10;
        MemRead<=1'b0;
        MemWr<=1'b0;   
        Branch<=1'b0;   
        RegWr<=1'b0;  
        end
      end
    end
 
     //ALUOp
  always @(posedge reset or posedge clk) begin
      ALUOp[3] = inst[26];
      if (reset) begin
          ALUOp[2:0] = 3'b000;
      end else if (OpCode == 6'h00&&Funct!=6'h2f) begin 
          ALUOp[2:0] = 3'b010;
      end else if (OpCode == 6'h04) begin
          ALUOp[2:0] = 3'b001;
      end else if (OpCode == 6'h00 &&Funct==6'h2f) begin
          ALUOp[2:0] = 3'b111;
      end else if (OpCode == 6'h0c) begin
          ALUOp[2:0] = 3'b100;
      end else if (OpCode == 6'h0a || OpCode == 6'h0b) begin
          ALUOp[2:0] = 3'b101;
      end else begin
          ALUOp[2:0] = 3'b000;
      end
  end   
endmodule
