`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Class: Fundamentals of Digital Logic and Processor
// Designer: Shulin Zeng
// 
// Create Date: 2021/04/30
// Design Name: MultiCycleCPU
// Module Name: MultiCycleCPU
// Project Name: Multi-cycle-cpu
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


module test_cpu();
    
    reg reset;
    reg clk;
    
    pipelineCPU pipelineCPU_1(.reset(reset), .clk(clk));
    
    initial begin
        reset = 1;
        clk = 1;
        #20000 reset = 0;
    end
    
    always #50 clk = ~clk;
    
endmodule
