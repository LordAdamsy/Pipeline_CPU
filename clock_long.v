`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/08 23:26:10
// Design Name: 
// Module Name: clock_long
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


module clock_long(
clk,reset,clk_o
    );
    
    input clk;
    input reset;
    output reg clk_o;
    
reg [31:0] counter;    
    
    
always @(posedge clk or posedge reset) begin
        if (reset) begin
            // reset
            counter <= 0;
        end
        else if (counter >= 32'd1500) begin
            counter <= 0;
        end
        else begin
            counter <= counter + 1;
        end
    end

always @(posedge clk or posedge reset) begin
	if (reset) begin
		// reset
		clk_o <= 0;
	end
	else if (counter >= 32'd1500) begin
		clk_o <= !clk_o;
	end
end
    
endmodule
