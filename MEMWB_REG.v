`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/06 17:49:59
// Design Name: 
// Module Name: MEMWB_REG
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


module MEMWB_REG(
reset,
clk,
Read_data_in,
result_in,
RtorRd_in,
Read_data_o,
result_o,
RtorRd_o,

MemtoReg_in,
RegWr_in,
MemRead_in,
MemtoReg_o,
RegWr_o,
MemRead_o
    );
    
    input reset;
    input clk;
    input [31:0] Read_data_in;
    input [31:0] result_in;
    input [4:0] RtorRd_in;
    input MemRead_in;
    output reg [31:0] Read_data_o;
    output reg [31:0] result_o;
    output reg [4:0] RtorRd_o;
    input [1:0] MemtoReg_in;
    input RegWr_in;
    output reg [1:0] MemtoReg_o;
    output reg RegWr_o;
    output reg MemRead_o;
    
    always @(posedge reset or posedge clk)
    begin
    if(reset)
    begin
      Read_data_o<=0;
      result_o<=0;
      RtorRd_o<=0;
      MemtoReg_o<=0;
      RegWr_o<=0;
      MemRead_o<=0;
    end
    else
    begin
      Read_data_o<=Read_data_in;
      result_o<=result_in;
      RtorRd_o<=RtorRd_in;
      MemtoReg_o<=MemtoReg_in;
      RegWr_o<=RegWr_in;      
      MemRead_o<=MemRead_in;
    end
  end
endmodule
