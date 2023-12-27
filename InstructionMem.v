`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/05 21:07:16
// Design Name: 
// Module Name: InstructionMem
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


module InstructionMem(reset, clk, Address,Mem_data);
	//Input Clock Signals
	input reset;
	input clk;
	//Input Data Signals
	input [31:0] Address;
	//Output Data
	output [31:0] Mem_data;
	
	parameter RAM_SIZE = 256;
	parameter RAM_SIZE_BIT = 8;
	parameter RAM_INST_SIZE = 32;
	
	reg [31:0] RAM_data[RAM_SIZE - 1: 0];

	//read data
	assign Mem_data = RAM_data[Address[RAM_SIZE_BIT + 1:2]];
	
	//write data
	integer i;
	always @(posedge reset or posedge clk) begin
		if (reset) begin
		    // init instruction memory
		    
		 // addi $s0 inbuff $zero
		 RAM_data[8'd0] <= {6'h08, 5'd0 , 5'd1 , 16'h0};   
		 //addi $sp $zero 60(数据存储器中的60号）
		 RAM_data[8'd1] <= {6'h08, 5'd0 , 5'd30 , 16'd64};
		 // lw $s1 0($s0)
		 RAM_data[8'd2] <= {6'h23, 5'd1 , 5'd2 , 16'h0};
		 // lw $s2 4($s0)
		 RAM_data[8'd3] <= {6'h23, 5'd1 , 5'd3 , 16'h4};   
		 //addi $s3 $s0 4
		 RAM_data[8'd4] <= {6'h08, 5'd1 , 5'd4 , 16'h4};
		 
		 //开辟数组空间,存在$s4中
		 RAM_data[8'd5] <= {6'h08, 5'd0 , 5'd5 , 16'd128};   
		 
		 //Loop;
		 //addi $s3 $s3 4
		 RAM_data[8'd6] <= {6'h08, 5'd4 , 5'd4 , 16'h4};
		 //lw $t0 0($s3)
		 RAM_data[8'd7] <= {6'h23, 5'd4 , 5'd6 , 16'h0};
		 //addi $s3 $s3 4
		 RAM_data[8'd8] <= {6'h08, 5'd4 , 5'd4 , 16'h4};
		 //lw $t1 0($s3)
		 RAM_data[8'd9] <= {6'h23, 5'd4 , 5'd7 , 16'h0};
		 //move $t2 $s1(addi $t2=$s1+0
		 RAM_data[8'd10] <= {6'h08, 5'd2 , 5'd8 , 16'h0};
		 //subb:
		 //subu $t3 $t2 $t0
		 RAM_data[8'd11] <= {6'h0, 5'd8 , 5'd6 ,5'd9, 5'h0,6'h23};
		 //jal x
		 RAM_data[8'd12] <= {6'h03, 26'd21};
		 //addi $t2 $t2 -1
		 RAM_data[8'd13] <= {6'h08, 5'd8 , 5'd8 , 16'hffff};
		 //bne $t2 $zero subb
		 RAM_data[8'd14] <= {6'h11, 5'd8 , 5'd0 , 16'hfffc};
		 //addi $s2 $s2 -1
		 RAM_data[8'd15] <= {6'h08, 5'd3 , 5'd3 , 16'hffff};
		 //bne $s2 $zero loop
		 RAM_data[8'd16] <= {6'h11, 5'd3 , 5'd0 , 16'hfff5};
		 
		 //sll $s1 $s1 2
		 RAM_data[8'd17] <= {6'h00, 5'd0 , 5'd2 , 5'd2 , 5'd2 , 6'h00};
		 //addu $k1 $s1 $s4
		 RAM_data[8'd18] <= {6'h00, 5'd2 , 5'd5 , 5'd10 , 5'd0 , 6'h21};
		 //lw $a0 0($k1)
		 RAM_data[8'd19] <= {6'h23, 5'd10 , 5'd11 , 16'h0};
		 //j end
		 RAM_data[8'd20] <= {6'h02, 26'd53};
		 
		 //x:
		 //addi $sp $sp -4
		 RAM_data[8'd21] <= {6'h08, 5'd30 , 5'd30 , 16'hfffc};
		 //sw $ra 0($sp)
		 RAM_data[8'd22] <= {6'h2b, 5'd30 , 5'd31 , 16'h0};
		 //bgez $t3  excute
		 RAM_data[8'd23] <= {6'h12, 5'd9 , 5'd0 , 16'h0003};
		 //lw $ra 0($sp)
		 RAM_data[8'd24] <= {6'h23, 5'd30 , 5'd31 , 16'h0};
		 //addi $sp $sp 4
		 RAM_data[8'd25] <= {6'h08, 5'd30 , 5'd30 , 16'h4};
		 //jr $ra
		 RAM_data[8'd26] <= {6'h0 , 5'd31 , 15'b0 , 6'h08};
		 //excute:
		 //sll $t4 $t2 2
		 RAM_data[8'd27] <= {6'h00, 5'd0 , 5'd8 , 5'd12 , 5'd2 , 6'h00};
		 //addu $k1 $t4 $s4
		 RAM_data[8'd28] <= {6'h00, 5'd5 , 5'd12 , 5'd10 , 5'd0 , 6'h21};
		 //lw $t5 0($k1)
		 RAM_data[8'd29] <= {6'h23, 5'd10 , 5'd13 , 16'h0};
		 //sll $t6 $t0 2
		 RAM_data[8'd30] <= {6'h00, 5'd0 , 5'd6 , 5'd14 , 5'd2 , 6'h00};
		 //subu $t6 $t4 $t6
		 RAM_data[8'd31] <= {6'h0 , 5'd12 , 5'd14 ,5'd14, 5'h0 , 6'h23};
		 //addu $k1 $t6 $s4
		 RAM_data[8'd32] <= {6'h00, 5'd5 , 5'd14 , 5'd10 , 5'd0 , 6'h21};
		 //lw $t7 0($k1)
		 RAM_data[8'd33] <= {6'h23, 5'd10 , 5'd15 , 16'h0};
		 //addu $t8 $t7 $t1
		 RAM_data[8'd34] <= {6'h00, 5'd7 , 5'd15 , 5'd16 , 5'd0 , 6'h21};
		 //subu $k0 $t5 $t8
		 RAM_data[8'd35] <= {6'h0 , 5'd13 , 5'd16 ,5'd17, 5'h0 , 6'h23};
		 //jal y
		 RAM_data[8'd36] <= {6'h03, 26'd40};
		 //lw $ra 0($sp)
		 RAM_data[8'd37] <= {6'h23, 5'd30 , 5'd31 , 16'h0};
		 //addi $sp $sp 4
		 RAM_data[8'd38] <= {6'h08, 5'd30 , 5'd30 , 16'h4};
		 //jr $ra
		 RAM_data[8'd39] <= {6'h0 , 5'd31 , 15'b0 , 6'h08};
		 
		 //y:
		 //addi $sp $sp -4
		 RAM_data[8'd40] <= {6'h08, 5'd30 , 5'd30 , 16'hfffc};
		 //sw $ra 0($sp)
	         RAM_data[8'd41] <= {6'h2b, 5'd30 , 5'd31 , 16'h0};
	         //bgtz $k0 sum
	         RAM_data[8'd42] <= {6'h13, 5'd17 , 5'd0 , 16'h5};
	         //addu $k1 $t4 $s4
	         RAM_data[8'd43] <= {6'h00, 5'd5 , 5'd12 , 5'd10 , 5'd0 , 6'h21};
	         //sw $t8 0($k1)
	         RAM_data[8'd44] <= {6'h2b, 5'd10 , 5'd16 , 16'h0};
	         //lw $ra 0($sp)
	         RAM_data[8'd45] <= {6'h23, 5'd30 , 5'd31 , 16'h0};
	         //addi $sp $sp 4
	         RAM_data[8'd46] <= {6'h08, 5'd30 , 5'd30 , 16'h4};
	         //jr $ra
	         RAM_data[8'd47] <= {6'h0 , 5'd31 , 15'b0 , 6'h08};
	         //sum:
	         //addu $k1 $t4 $s4
	         RAM_data[8'd48] <= {6'h00, 5'd5 , 5'd12 , 5'd10 , 5'd0 , 6'h21};
	         //sw $t5  0($k1)
	         RAM_data[8'd49] <= {6'h2b, 5'd10 , 5'd13 , 16'h0};
	         //lw $ra 0($sp)
	         RAM_data[8'd50] <= {6'h23, 5'd30 , 5'd31 , 16'h0};
	         RAM_data[8'd51] <= {32'b0};
	         //jr $ra
	         RAM_data[8'd52] <= {6'h0 , 5'd31 , 15'b0 , 6'h08};
	         
	         //end:
	         //lw $v0 0($k1)
	         RAM_data[8'd53] <= {6'h23, 5'd10 , 5'd17 , 16'h0};
	         //sll $18 $v0 28
	         RAM_data[8'd54] <= {6'h00, 5'd0 , 5'd17 , 5'd18 , 5'd28 , 6'h00}; 
	         //srl $18 $18 28
	         RAM_data[8'd55] <= {6'h00, 5'd0 , 5'd18 , 5'd18 , 5'd28 , 6'h02};
	         //sll $19 $v0 24
	         RAM_data[8'd56] <= {6'h00, 5'd0 , 5'd17 , 5'd19 , 5'd24 , 6'h00}; 
	         //srl $19 $19 28
	         RAM_data[8'd57] <= {6'h00, 5'd0 , 5'd19 , 5'd19 , 5'd28 , 6'h02};
	         //sll $20 $v0 20
	         RAM_data[8'd58] <= {6'h00, 5'd0 , 5'd17 , 5'd20 , 5'd20 , 6'h00};
	         //srl $20 $20 28
	         RAM_data[8'd59] <= {6'h00, 5'd0 , 5'd20 , 5'd20 , 5'd28 , 6'h02};
	         //sll $21 $v0 16
	         RAM_data[8'd60] <= {6'h00, 5'd0 , 5'd17 , 5'd21 , 5'd16 , 6'h00};
	         //srl $21 $21 28
	         RAM_data[8'd61] <= {6'h00, 5'd0 , 5'd21 , 5'd21 , 5'd28 , 6'h02};
	         
	         //addi $1 $0 1
	         RAM_data[8'd62] <= {6'h08, 5'd0 , 5'd1 , 16'h1};
	         //addi $2 $0 2
	         RAM_data[8'd63] <= {6'h08, 5'd0 , 5'd2 , 16'h2};
	         //addi $3 $0 3
	         RAM_data[8'd64] <= {6'h08, 5'd0 , 5'd3 , 16'h3};        
	          //addi $4 $0 4
	         RAM_data[8'd65] <= {6'h08, 5'd0 , 5'd4 , 16'h4}; 
	         //addi $5 $0 5
	         RAM_data[8'd66] <= {6'h08, 5'd0 , 5'd5 , 16'h5};         
	         //addi $6 $0 6
	         RAM_data[8'd67] <= {6'h08, 5'd0 , 5'd6 , 16'h6};
	         //addi $7 $0 7
	         RAM_data[8'd68] <= {6'h08, 5'd0 , 5'd7 , 16'h7};
	         //addi $8 $0 8
	         RAM_data[8'd69] <= {6'h08, 5'd0 , 5'd8 , 16'h8};         
	         //addi $9 $0 9
	         RAM_data[8'd70] <= {6'h08, 5'd0 , 5'd9 , 16'h9};     
	          //addi $10 $0 10
	         RAM_data[8'd71] <= {6'h08, 5'd0 , 5'd10 , 16'h10};        
	         //addi $11 $0 11
	         RAM_data[8'd72] <= {6'h08, 5'd0 , 5'd11 , 16'h11};         
	          //addi $12 $0 12
	         RAM_data[8'd73] <= {6'h08, 5'd0 , 5'd12 , 16'h12};            
	         //addi $13 $0 13
	         RAM_data[8'd74] <= {6'h08, 5'd0 , 5'd13 , 16'h13};         
	         //addi $14 $0 14
	         RAM_data[8'd75] <= {6'h08, 5'd0 , 5'd14 , 16'h14};
	         //addi $15 $0 15
	         RAM_data[8'd76] <= {6'h08, 5'd0 , 5'd15 , 16'h15};
	         
	         //bne $18 $0  下下一条
	         RAM_data[8'd77] <= {6'h11, 5'd18 , 5'd0 , 16'h1};
	         //addi $18 $0 number
	         RAM_data[8'd78] <= {6'h08, 5'd0 , 5'd18 , 16'b0000111011000000};
	         //bne $18 $1  下下一条
	         RAM_data[8'd79] <= {6'h11, 5'd18 , 5'd1 , 16'h1};
	         //addi $18 $0 number
	         RAM_data[8'd80] <= {6'h08, 5'd0 , 5'd18 , 16'b0000111011111001};
	          //bne $18 $2  下下一条
	         RAM_data[8'd81] <= {6'h11, 5'd18 , 5'd2 , 16'h1};
	         //addi $18 $0 number
	         RAM_data[8'd82] <= {6'h08, 5'd0 , 5'd18 , 16'b0000111010100100};        
	         //bne $18 $3  下下一条
	         RAM_data[8'd83] <= {6'h11, 5'd18 , 5'd3 , 16'h1};
	         //addi $18 $0 number
	         RAM_data[8'd84] <= {6'h08, 5'd0 , 5'd18 , 16'b0000111010110000};
	         //bne $18 $4  下下一条
	         RAM_data[8'd85] <= {6'h11, 5'd18 , 5'd4 , 16'h1};
	         //addi $18 $0 number
	         RAM_data[8'd86] <= {6'h08, 5'd0 , 5'd18 , 16'b0000111010011001};   
	          //bne $18 $5  下下一条
	         RAM_data[8'd87] <= {6'h11, 5'd18 , 5'd5 , 16'h1};
	         //addi $18 $0 number
	         RAM_data[8'd88] <= {6'h08, 5'd0 , 5'd18 , 16'b0000111010010010};  
	          //bne $18 $6  下下一条
	         RAM_data[8'd89] <= {6'h11, 5'd18 , 5'd6 , 16'h1};
	         //addi $18 $0 number
	         RAM_data[8'd90] <= {6'h08, 5'd0 , 5'd18 , 16'b0000111010000010};      
	         //bne $18 $7  下下一条
	         RAM_data[8'd91] <= {6'h11, 5'd18 , 5'd7 , 16'h1};
	         //addi $18 $0 number
	         RAM_data[8'd92] <= {6'h08, 5'd0 , 5'd18 , 16'b0000111011111000};  
	          //bne $18 $8  下下一条
	         RAM_data[8'd93] <= {6'h11, 5'd18 , 5'd8 , 16'h1};
	         //addi $18 $0 number
	         RAM_data[8'd94] <= {6'h08, 5'd0 , 5'd18 , 16'b0000111010000000};             
	         //bne $18 $9  下下一条
	         RAM_data[8'd95] <= {6'h11, 5'd18 , 5'd9 , 16'h1};
	         //addi $18 $0 number
	         RAM_data[8'd96] <= {6'h08, 5'd0 , 5'd18 , 16'b0000111010010000};           
	         //bne $18 $10  下下一条
	         RAM_data[8'd97] <= {6'h11, 5'd18 , 5'd10 , 16'h1};
	         //addi $18 $0 number
	         RAM_data[8'd98] <= {6'h08, 5'd0 , 5'd18 , 16'b0000111010001000};    
	         //bne $18 $11  下下一条
	         RAM_data[8'd99] <= {6'h11, 5'd18 , 5'd11 , 16'h1};
	         //addi $18 $0 number
	         RAM_data[8'd100] <= {6'h08, 5'd0 , 5'd18 , 16'b0000111010000011};  
	         //bne $18 $12  下下一条
	         RAM_data[8'd101] <= {6'h11, 5'd18 , 5'd12 , 16'h1};
	         //addi $18 $0 number
	         RAM_data[8'd102] <= {6'h08, 5'd0 , 5'd18 , 16'b0000111011000110};   
	         //bne $18 $13  下下一条
	         RAM_data[8'd103] <= {6'h11, 5'd18 , 5'd13 , 16'h1};
	         //addi $18 $0 number
	         RAM_data[8'd104] <= {6'h08, 5'd0 , 5'd18 , 16'b0000111010100001};  
	          //bne $18 $14  下下一条
	         RAM_data[8'd105] <= {6'h11, 5'd18 , 5'd14 , 16'h1};
	         //addi $18 $0 number
	         RAM_data[8'd106] <= {6'h08, 5'd0 , 5'd18 , 16'b0000111010000110};       
	         //bne $18 $15  下下一条
	         RAM_data[8'd107] <= {6'h11, 5'd18 , 5'd15 , 16'h1};
	         //addi $18 $0 number
	         RAM_data[8'd108] <= {6'h08, 5'd0 , 5'd18 , 16'b0000111010001110};      
	         
	         //bne $19 $1  下下一条
	         RAM_data[8'd109] <= {6'h11, 5'd19 , 5'd1 , 16'h1};
	         //addi $19 $0 number
	         RAM_data[8'd110] <= {6'h08, 5'd0 , 5'd18 , 16'b0000110111000000};                                             
	         //bne $19 $1  下下一条
	         RAM_data[8'd111] <= {6'h11, 5'd19 , 5'd1 , 16'h1};
	         //addi $19 $0 number
	         RAM_data[8'd112] <= {6'h08, 5'd0 , 5'd19 , 16'b0000110111111001}; 
	         //bne $19 $2  下下一条
	         RAM_data[8'd113] <= {6'h11, 5'd19 , 5'd2 , 16'h1};
	         //addi $19 $0 number
	         RAM_data[8'd114] <= {6'h08, 5'd0 , 5'd19 , 16'b0000110110100100};     
	         //bne $19 $3  下下一条
	         RAM_data[8'd115] <= {6'h11, 5'd19 , 5'd3 , 16'h1};
	         //addi $19 $0 number
	         RAM_data[8'd116] <= {6'h08, 5'd0 , 5'd19 , 16'b0000110110110000};    
	         //bne $19 $4  下下一条
	         RAM_data[8'd117] <= {6'h11, 5'd19 , 5'd4 , 16'h1};
	         //addi $19 $0 number
	         RAM_data[8'd118] <= {6'h08, 5'd0 , 5'd19 , 16'b0000110110011001};  
	         //bne $19 $5  下下一条
	         RAM_data[8'd119] <= {6'h11, 5'd19 , 5'd5 , 16'h1};
	         //addi $19 $0 number
	         RAM_data[8'd120] <= {6'h08, 5'd0 , 5'd19 , 16'b0000110110010010};          
	         //bne $19 $6  下下一条
	         RAM_data[8'd121] <= {6'h11, 5'd19 , 5'd6 , 16'h1};
	         //addi $19 $0 number
	         RAM_data[8'd122] <= {6'h08, 5'd0 , 5'd19 , 16'b0000110110000010};      
	         //bne $19 $7  下下一条
	         RAM_data[8'd123] <= {6'h11, 5'd19 , 5'd7 , 16'h1};
	         //addi $19 $0 number
	         RAM_data[8'd124] <= {6'h08, 5'd0 , 5'd19 , 16'b0000110111111000}; 
	         //bne $19 $8  下下一条
	         RAM_data[8'd125] <= {6'h11, 5'd19 , 5'd8 , 16'h1};
	         //addi $19 $0 number
	         RAM_data[8'd126] <= {6'h08, 5'd0 , 5'd19 , 16'b0000110110000000};      
	          //bne $19 $9  下下一条
	         RAM_data[8'd127] <= {6'h11, 5'd19 , 5'd9 , 16'h1};
	         //addi $19 $0 number
	         RAM_data[8'd128] <= {6'h08, 5'd0 , 5'd19 , 16'b0000110110010000};         
	          //bne $19 $10  下下一条
	         RAM_data[8'd129] <= {6'h11, 5'd19 , 5'd10 , 16'h1};
	         //addi $19 $0 number
	         RAM_data[8'd130] <= {6'h08, 5'd0 , 5'd19 , 16'b0000110110001000};         
	         //bne $19 $11  下下一条
	         RAM_data[8'd131] <= {6'h11, 5'd19 , 5'd11 , 16'h1};
	         //addi $19 $0 number
	         RAM_data[8'd132] <= {6'h08, 5'd0 , 5'd19 , 16'b0000110110000011};          
	         //bne $19 $12  下下一条
	         RAM_data[8'd133] <= {6'h11, 5'd19 , 5'd12 , 16'h1};
	         //addi $19 $0 number
	         RAM_data[8'd134] <= {6'h08, 5'd0 , 5'd19 , 16'b0000110111000110};          
	          //bne $19 $13  下下一条
	         RAM_data[8'd135] <= {6'h11, 5'd19 , 5'd13 , 16'h1};
	         //addi $19 $0 number
	         RAM_data[8'd136] <= {6'h08, 5'd0 , 5'd19 , 16'b0000110110100001};         
	          //bne $19 $14  下下一条
	         RAM_data[8'd137] <= {6'h11, 5'd19 , 5'd14 , 16'h1};
	         //addi $19 $0 number
	         RAM_data[8'd138] <= {6'h08, 5'd0 , 5'd19 , 16'b0000110110000110};   
	         //bne $19 $15  下下一条
	         RAM_data[8'd139] <= {6'h11, 5'd19 , 5'd15 , 16'h1};
	         //addi $19 $0 number
	         RAM_data[8'd140] <= {6'h08, 5'd0 , 5'd19 , 16'b0000110110001110};  
	         
	         //bne $20 $0  下下一条
	         RAM_data[8'd141] <= {6'h11, 5'd20 , 5'd0 , 16'h1};
	         //addi $18 $0 number
	         RAM_data[8'd142] <= {6'h08, 5'd0 , 5'd20 , 16'b0000101111000000};
	         //bne $20 $1  下下一条
	         RAM_data[8'd143] <= {6'h11, 5'd20 , 5'd1 , 16'h1};
	         //addi $20 $0 number
	         RAM_data[8'd144] <= {6'h08, 5'd0 , 5'd20 , 16'b0000101111111001};
	          //bne $20 $2  下下一条
	         RAM_data[8'd145] <= {6'h11, 5'd20 , 5'd2 , 16'h1};
	         //addi $20 $0 number
	         RAM_data[8'd146] <= {6'h08, 5'd0 , 5'd20 , 16'b0000101110100100};        
	         //bne $20 $3  下下一条
	         RAM_data[8'd147] <= {6'h11, 5'd20 , 5'd3 , 16'h1};
	         //addi $20 $0 number
	         RAM_data[8'd148] <= {6'h08, 5'd0 , 5'd20 , 16'b0000101110110000};
	         //bne $20 $4  下下一条
	         RAM_data[8'd149] <= {6'h11, 5'd20 , 5'd4 , 16'h1};
	         //addi $20 $0 number
	         RAM_data[8'd150] <= {6'h08, 5'd0 , 5'd20 , 16'b0000101110011001};   
	          //bne $20 $5  下下一条
	         RAM_data[8'd151] <= {6'h11, 5'd20 , 5'd5 , 16'h1};
	         //addi $20 $0 number
	         RAM_data[8'd152] <= {6'h08, 5'd0 , 5'd20 , 16'b0000101110010010};  
	          //bne $18 $6  下下一条
	         RAM_data[8'd153] <= {6'h11, 5'd20 , 5'd6 , 16'h1};
	         //addi $18 $0 number
	         RAM_data[8'd154] <= {6'h08, 5'd0 , 5'd20 , 16'b0000101110000010};      
	         //bne $18 $7  下下一条
	         RAM_data[8'd155] <= {6'h11, 5'd20 , 5'd7 , 16'h1};
	         //addi $18 $0 number
	         RAM_data[8'd156] <= {6'h08, 5'd0 , 5'd20 , 16'b0000101111111000};  
	          //bne $18 $8  下下一条
	         RAM_data[8'd157] <= {6'h11, 5'd20 , 5'd8 , 16'h1};
	         //addi $18 $0 number
	         RAM_data[8'd158] <= {6'h08, 5'd0 , 5'd20 , 16'b0000101110000000};             
	         //bne $18 $9  下下一条
	         RAM_data[8'd159] <= {6'h11, 5'd20 , 5'd9 , 16'h1};
	         //addi $18 $0 number
	         RAM_data[8'd160] <= {6'h08, 5'd0 , 5'd20 , 16'b0000101110010000};           
	         //bne $18 $10  下下一条
	         RAM_data[8'd161] <= {6'h11, 5'd20 , 5'd10 , 16'h1};
	         //addi $18 $0 number
	         RAM_data[8'd162] <= {6'h08, 5'd0 , 5'd20 , 16'b0000101110001000};    
	         //bne $18 $11  下下一条
	         RAM_data[8'd163] <= {6'h11, 5'd20 , 5'd11 , 16'h1};
	         //addi $18 $0 number
	         RAM_data[8'd164] <= {6'h08, 5'd0 , 5'd20 , 16'b0000101110000011};  
	         //bne $18 $12  下下一条
	         RAM_data[8'd165] <= {6'h11, 5'd20 , 5'd12 , 16'h1};
	         //addi $18 $0 number
	         RAM_data[8'd166] <= {6'h08, 5'd0 , 5'd20 , 16'b0000101111000110};   
	         //bne $18 $13  下下一条
	         RAM_data[8'd167] <= {6'h11, 5'd20 , 5'd13 , 16'h1};
	         //addi $18 $0 number
	         RAM_data[8'd168] <= {6'h08, 5'd0 , 5'd20 , 16'b0000101110100001};  
	          //bne $18 $14  下下一条
	         RAM_data[8'd169] <= {6'h11, 5'd20 , 5'd14 , 16'h1};
	         //addi $18 $0 number
	         RAM_data[8'd170] <= {6'h08, 5'd0 , 5'd20 , 16'b0000101110000110};       
	         //bne $18 $15  下下一条
	         RAM_data[8'd171] <= {6'h11, 5'd20 , 5'd15 , 16'h1};
	         //addi $18 $0 number
	         RAM_data[8'd172] <= {6'h08, 5'd0 , 5'd20 , 16'b0000101110001110};               
	   
	         //bne $20 $0  下下一条
	         RAM_data[8'd173] <= {6'h11, 5'd21 , 5'd0 , 16'h1};
	         //addi $18 $0 number
	         RAM_data[8'd174] <= {6'h08, 5'd0 , 5'd21 , 16'b0000011111000000};
	         //bne $20 $1  下下一条
	         RAM_data[8'd175] <= {6'h11, 5'd21 , 5'd1 , 16'h1};
	         //addi $20 $0 number
	         RAM_data[8'd176] <= {6'h08, 5'd0 , 5'd21 , 16'b0000011111111001};
	          //bne $20 $2  下下一条
	         RAM_data[8'd177] <= {6'h11, 5'd21 , 5'd2 , 16'h1};
	         //addi $20 $0 number
	         RAM_data[8'd178] <= {6'h08, 5'd0 , 5'd21 , 16'b0000011110100100};        
	         //bne $20 $3  下下一条
	         RAM_data[8'd179] <= {6'h11, 5'd21 , 5'd3 , 16'h1};
	         //addi $20 $0 number
	         RAM_data[8'd180] <= {6'h08, 5'd0 , 5'd21 , 16'b0000011110110000};
	         //bne $20 $4  下下一条
	         RAM_data[8'd181] <= {6'h11, 5'd21 , 5'd4 , 16'h1};
	         //addi $20 $0 number
	         RAM_data[8'd182] <= {6'h08, 5'd0 , 5'd21 , 16'b0000011110011001};   
	          //bne $20 $5  下下一条
	         RAM_data[8'd183] <= {6'h11, 5'd21 , 5'd5 , 16'h1};
	         //addi $20 $0 number
	         RAM_data[8'd184] <= {6'h08, 5'd0 , 5'd21 , 16'b0000011110010010};  
	          //bne $18 $6  下下一条
	         RAM_data[8'd185] <= {6'h11, 5'd21 , 5'd6 , 16'h1};
	         //addi $18 $0 number
	         RAM_data[8'd186] <= {6'h08, 5'd0 , 5'd21 , 16'b0000011110000010};      
	         //bne $18 $7  下下一条
	         RAM_data[8'd187] <= {6'h11, 5'd21 , 5'd7 , 16'h1};
	         //addi $18 $0 number
	         RAM_data[8'd188] <= {6'h08, 5'd0 , 5'd21 , 16'b0000011111111000};  
	          //bne $18 $8  下下一条
	         RAM_data[8'd189] <= {6'h11, 5'd21 , 5'd8 , 16'h1};
	         //addi $18 $0 number
	         RAM_data[8'd190] <= {6'h08, 5'd0 , 5'd21 , 16'b0000011110000000};             
	         //bne $18 $9  下下一条
	         RAM_data[8'd191] <= {6'h11, 5'd21 , 5'd9 , 16'h1};
	         //addi $18 $0 number
	         RAM_data[8'd192] <= {6'h08, 5'd0 , 5'd21 , 16'b0000011110010000};           
	         //bne $18 $10  下下一条
	         RAM_data[8'd193] <= {6'h11, 5'd21 , 5'd10 , 16'h1};
	         //addi $18 $0 number
	         RAM_data[8'd194] <= {6'h08, 5'd0 , 5'd21 , 16'b0000011110001000};    
	         //bne $18 $11  下下一条
	         RAM_data[8'd195] <= {6'h11, 5'd21 , 5'd11 , 16'h1};
	         //addi $18 $0 number
	         RAM_data[8'd196] <= {6'h08, 5'd0 , 5'd21 , 16'b0000011110000011};  
	         //bne $18 $12  下下一条
	         RAM_data[8'd197] <= {6'h11, 5'd21 , 5'd12 , 16'h1};
	         //addi $18 $0 number
	         RAM_data[8'd198] <= {6'h08, 5'd0 , 5'd21 , 16'b0000011111000110};   
	         //bne $18 $13  下下一条
	         RAM_data[8'd199] <= {6'h11, 5'd21 , 5'd13 , 16'h1};
	         //addi $18 $0 number
	         RAM_data[8'd200] <= {6'h08, 5'd0 , 5'd21 , 16'b0000011110100001};  
	          //bne $18 $14  下下一条
	         RAM_data[8'd201] <= {6'h11, 5'd21 , 5'd14 , 16'h1};
	         //addi $18 $0 number
	         RAM_data[8'd202] <= {6'h08, 5'd0 , 5'd21 , 16'b0000011110000110};       
	         //bne $18 $15  下下一条
	         RAM_data[8'd203] <= {6'h11, 5'd21 , 5'd15 , 16'h1};
	         //addi $18 $0 number
	         RAM_data[8'd204] <= {6'h08, 5'd0 , 5'd21 , 16'b0000011110001110};  
	         
	         //addi $24 $0 0x40000000
	         RAM_data[8'd205] <= {6'h08, 5'd0 , 5'd24 , 16'h4000};    
	         //sll $24 $24 16
	         RAM_data[8'd206] <= {6'h00, 5'd0 , 5'd24 , 5'd24 , 5'd16 , 6'h00};
	                  
	         //loop: 
	         //addi $26 $0 10001
	         RAM_data[8'd207] <= {6'h08, 5'd0 , 5'd26 , 16'd10};      
	         //sw $18 0x40000010($24)
	         RAM_data[8'd208] <= {6'h2b, 5'd24 , 5'd18 , 16'h10};    
	         //addi $26 $26 -1
	         RAM_data[8'd209] <= {6'h08, 5'd26 , 5'd26 , 16'hffff};
	         //bne $26 $0 跳转
	         RAM_data[8'd210] <= {6'h11, 5'd0 , 5'd26 , 16'hfffd};    
	         //addi $26 $0 10001
	         RAM_data[8'd211] <= {6'h08, 5'd0 , 5'd26 , 16'd10}; 
	         //sw $19 0x40000010($24)
	         RAM_data[8'd212] <= {6'h2b, 5'd24 , 5'd19 , 16'h10}; 
	         //addi $26 $26 -1
	         RAM_data[8'd213] <= {6'h08, 5'd26 , 5'd26 , 16'hffff};
	         //bne $26 $0 跳转
	         RAM_data[8'd214] <= {6'h11, 5'd0 , 5'd26 , 16'hfffd};    
	         //addi $26 $0 10001
	         RAM_data[8'd215] <= {6'h08, 5'd0 , 5'd26 , 16'd10};  
	         //sw $20 0x40000010($24)
	         RAM_data[8'd216] <= {6'h2b, 5'd24 , 5'd20 , 16'h10};   
	         //addi $26 $26 -1
	         RAM_data[8'd217] <= {6'h08, 5'd26 , 5'd26 , 16'hffff};
	         //bne $26 $0 跳转
	         RAM_data[8'd218] <= {6'h11, 5'd0 , 5'd26 , 16'hfffd};  
	         //addi $26 $0 10001
	         RAM_data[8'd219] <= {6'h08, 5'd0 , 5'd26 , 16'd10};    
	         //sw $21 0x40000010($24)
	        RAM_data[8'd220] <= {6'h2b, 5'd24 , 5'd21 , 16'h10}; 
	         //addi $26 $26 -1
	         RAM_data[8'd221] <= {6'h08, 5'd26 , 5'd26 , 16'hffff};
	         //bne $26 $0 跳转
	         RAM_data[8'd222] <= {6'h11, 5'd0 , 5'd26 , 16'hfffd}; 
	         
	         RAM_data[8'd223] <= {32'b0}; 
	         //j loop
	         RAM_data[8'd224] <= {6'h02, 26'd207};                                                             
	end
end

endmodule
