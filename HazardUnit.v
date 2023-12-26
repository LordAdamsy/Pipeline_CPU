`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/07 16:29:17
// Design Name: 
// Module Name: HazardUnit
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


module HazardUnit(
IFID_inst_o,
IDEX_MemRead,
IDEX_rt_o,
IFID_rs_o,
IFID_rt_o,
PC_MUX,
IFID_MUX,
IDEX_MUX
    );
    
   input [31:0] IFID_inst_o;
   input IDEX_MemRead;
   input [4:0] IDEX_rt_o;
   input [4:0] IFID_rs_o;
   input [4:0] IFID_rt_o;
   output reg [1:0] PC_MUX;
   output reg [1:0] IFID_MUX;
   output reg [1:0] IDEX_MUX; 
   
   always@(*)
     begin
       if((IDEX_MemRead&&((IDEX_rt_o==IFID_rs_o)||(IDEX_rt_o==IFID_rt_o))))
         begin
         PC_MUX<=2'b10;
         IFID_MUX<=2'b10;
         IDEX_MUX<=2'b01;
         end
       else
         begin
         PC_MUX<=2'b00;
         IFID_MUX<=2'b00;
         IDEX_MUX<=2'b00;
         end
       end         
endmodule
