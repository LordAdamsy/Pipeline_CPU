`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/06 17:20:01
// Design Name: 
// Module Name: EXMEM_REG
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


module EXMEM_REG(
reset,
clk,
add_result_in,
zero_in,
result_in,
Read_2_in,
RtorRd_in,
OpCode_in,
add_result_o,
zero_o,
result_o,
Read_2_o,
RtorRd_o,
OpCode_o,

MemWr_in,
MemRead_in,
Branch_in,
MemtoReg_in,
RegWr_in,
MemWr_o,
MemRead_o,
Branch_o,
MemtoReg_o,
RegWr_o
    );
    input reset;
    input clk;
    input [31:0] add_result_in;
    input [2:0] zero_in;
    input [31:0] result_in;
    input [31:0] Read_2_in;
    input [4:0] RtorRd_in;
    input [5:0]OpCode_in;
    output reg [31:0] add_result_o;
    output reg [2:0] zero_o;
    output reg [31:0] result_o;
    output reg [31:0] Read_2_o;
    output reg [4:0] RtorRd_o;    
    input MemWr_in;
    input MemRead_in;
    input Branch_in;
    input [1:0] MemtoReg_in;
    input RegWr_in;
    output reg MemWr_o;
    output reg MemRead_o;
    output reg Branch_o;
    output reg [1:0] MemtoReg_o;
    output reg RegWr_o;
    output reg [5:0] OpCode_o;
    
    always@(posedge clk or posedge reset)
      begin
      if(reset)
          begin
          add_result_o<=0;
          zero_o<=0;
          OpCode_o<=0;
          result_o<=0;
          Read_2_o<=0;
          RtorRd_o<=0;
          MemWr_o<=0;
          MemRead_o<=0;
          Branch_o<=0;
          MemtoReg_o<=0;
          RegWr_o<=0;
          end
      else 
          begin
          add_result_o<=add_result_in;
          zero_o<=zero_in;
          result_o<=result_in;
          Read_2_o<=Read_2_in;
          RtorRd_o<=RtorRd_in;
          MemWr_o<=MemWr_in;
          MemRead_o<=MemRead_in;
          Branch_o<=Branch_in;
          MemtoReg_o<=MemtoReg_in;
          RegWr_o<=RegWr_in; 
          OpCode_o<=OpCode_in;
          end
        end        
endmodule
