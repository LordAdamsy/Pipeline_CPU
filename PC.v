`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/05 17:20:56
// Design Name: 
// Module Name: PC
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


module PC(reset, clk, PC_i, PC_o);
    //Input Clock Signals
    input reset;             
    input clk;
    //Input Control Signals             
    //Input PC             
    input [31:0] PC_i;
    //Output PC  
    output reg [31:0] PC_o; 


    always@(posedge reset or posedge clk)
    begin
        if(reset) begin
            PC_o <= 0;
        end
        else begin
            PC_o <= PC_i;
        end
    end
endmodule
