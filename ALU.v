`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/06 17:11:13
// Design Name: 
// Module Name: ALU
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


module ALU(ALUConf,ALU_OpCode, Sign, In1, In2, Zero, Result);
    // Control Signals
    input [4:0] ALUConf;
    input [5:0] ALU_OpCode;
    input Sign;
    // Input Data Signals
    input [31:0] In1;
    input [31:0] In2;
    // Output 
    output [2:0] Zero;
    output reg [31:0] Result;

    //Zero logic
    assign Zero = (Result == 0&&ALU_OpCode==6'h04)?3'b001:(In1!=In2&&ALU_OpCode==6'h11)?3'b010:(((In1[31]==1'b0&&In1>32'b0)||In1==0)&&ALU_OpCode==6'h12)?3'b100:(((In1[31]==1'b0&&In1>32'b0))&&ALU_OpCode==6'h13)?3'b011:((((In1[31]==1'b1)&&In1>32'b0)||In1==0)&&ALU_OpCode==6'h14)?3'b110:(((In1[31]==1'b1&&In1>32'b0))&&ALU_OpCode==6'h15)?3'b101:3'b0;

    //ALU logic
    wire [1:0] ss;
	assign ss = {In1[31], In2[31]};
	
	wire lt_31;
	assign lt_31 = (In1[30:0] < In2[30:0]);
	
	wire lt_signed;
	assign lt_signed = (In1[31] ^ In2[31])? 
		((ss == 2'b01)? 0: 1): lt_31;

    always @(*) begin
		case (ALUConf)
			5'b00000: Result <= In1 + In2;
			5'b00001: Result <= In1 | In2;
			5'b00010: Result <= In1 & In2;
			5'b00110: Result <= In1 - In2;
			5'b00111: Result <= {31'h00000000, Sign? lt_signed: (In1 < In2)};
			5'b01100: Result <= ~(In1 | In2);
			5'b01101: Result <= In1 ^ In2;
			5'b10000: Result <= (In2 >> In1[4:0]);
			5'b11000: Result <= ({{32{In2[31]}}, In2} >> In1[4:0]);
            5'b11001: Result <= (In2 << In1[4:0]);
            5'b11111: Result <= In1&(~In2);
			default: Result <= 32'h00000000;
		endcase
    end

endmodule