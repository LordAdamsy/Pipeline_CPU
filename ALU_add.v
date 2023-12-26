`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/06 17:01:58
// Design Name: 
// Module Name: ALU_add
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


module ALU_add(
reset,
clk,
ImmShift,
PC,
add_out
    );
    
    input reset;
    input clk;
    input [31:0] ImmShift;
    input [31:0] PC;
    output wire [31:0] add_out;
    
    assign    add_out=ImmShift+PC;

endmodule
