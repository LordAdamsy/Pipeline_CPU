`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/06 23:46:03
// Design Name: 
// Module Name: ForwardingUnit
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


module ForwardingUnit(
reset,
clk,
EXMEM_RegWr,
MEMWB_RegWr,
EXMEM_RtorRd_in,
MEMWB_RtorRd_in,
EXMEM_MemWr,
MEMWB_MemRead,
IDEX_rs_in,
IDEX_rt_in,
forwardA,
forwardB,
forward_MEM
    );
    
    input reset;
    input clk;
    input EXMEM_RegWr;
    input MEMWB_RegWr;
    input [4:0] EXMEM_RtorRd_in;
    input [4:0] MEMWB_RtorRd_in;
    input EXMEM_MemWr;
    input MEMWB_MemRead;
    input[4:0] IDEX_rs_in;
    input [4:0] IDEX_rt_in;
    output reg [1:0] forwardA;
    output reg [1:0] forwardB;
    output reg [1:0] forward_MEM;
    
    always@(*)
    begin
      if(EXMEM_RegWr&&(EXMEM_RtorRd_in!=0)&&(EXMEM_RtorRd_in==IDEX_rs_in))
        forwardA<=2'b10;
      else if(MEMWB_RegWr&&(MEMWB_RtorRd_in!=0)&&(MEMWB_RtorRd_in==IDEX_rs_in)&&((EXMEM_RtorRd_in!=IDEX_rs_in)||~EXMEM_RegWr))
        forwardA<=2'b01;
      else
        forwardA<=2'b00;
      if(EXMEM_RegWr&&(EXMEM_RtorRd_in!=0)&&(EXMEM_RtorRd_in==IDEX_rt_in))
        forwardB<=2'b10;
      else if(MEMWB_RegWr&&(MEMWB_RtorRd_in!=0)&&(MEMWB_RtorRd_in==IDEX_rt_in)&&((EXMEM_RtorRd_in!=IDEX_rt_in)||~EXMEM_RegWr))
        forwardB<=2'b01;
      else
        forwardB<=2'b00;
      if(MEMWB_MemRead&&EXMEM_MemWr&&(MEMWB_RtorRd_in==EXMEM_RtorRd_in))
        forward_MEM<=2'b01;
      else
        forward_MEM<=2'b00;
    end
    
endmodule
