`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/06 17:37:29
// Design Name: 
// Module Name: DataMem
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


module DataMem(
reset,
clk,
address,
Wr_data,
MemWr,
MemRead,
Read_data,
code
    );
    
    input reset;
    input clk;
    input [31:0] address;
    input [31:0] Wr_data;
    input MemWr;
    input MemRead;
    output wire [31:0] Read_data;
    output wire [31:0] code;
    
	parameter RAM_SIZE = 256;
    parameter RAM_SIZE_BIT = 8;
    parameter RAM_INST_SIZE = 32;
    
    reg [31:0] RAM_data[RAM_SIZE - 1: 0];
        
    integer i;
    
    assign Read_data = MemRead? RAM_data[address[RAM_SIZE_BIT + 1:2]]: 32'h00000000;
    
      assign code=RAM_data[8'd4];
    
    always @(posedge reset or posedge clk)
    begin
      if(reset)
        begin
        RAM_data[8'd0]=32'd5;
        RAM_data[8'd1]=32'd5;
        RAM_data[8'd2]=32'd2;
        RAM_data[8'd3]=32'd12;
        RAM_data[8'd4]=32'd1;
        RAM_data[8'd5]=32'd12;
        RAM_data[8'd6]=32'd3;
        RAM_data[8'd7]=32'd20;
        RAM_data[8'd8]=32'd2;
        RAM_data[8'd9]=32'd15;
        RAM_data[8'd10]=32'd1;
        RAM_data[8'd11]=32'd8;
        RAM_data[8'd12]=32'd4;
        RAM_data[8'd13]=32'd1;
        RAM_data[8'd14]=32'd8;
        RAM_data[8'd15]=32'd1;
        RAM_data[8'd16]=32'd4;
        RAM_data[8'd17]=32'd2;
        RAM_data[8'd18]=32'd6;
        RAM_data[8'd19]=32'd5;
        RAM_data[8'd20]=32'd5;
        RAM_data[8'd21]=32'd1;
        for (i = 22; i < RAM_SIZE; i = i + 1)
        RAM_data[i] <= 32'h00000000;
        end
      else if(MemWr)
        begin
          RAM_data[address[RAM_SIZE_BIT + 1:2]] <= Wr_data;
        end
      end
endmodule
