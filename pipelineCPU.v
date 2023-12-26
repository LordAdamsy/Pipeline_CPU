`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/05 17:20:07
// Design Name: 
// Module Name: pipelineCPU
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


module pipelineCPU(reset,clk,out);

input reset;
input clk;
output wire [11:0] out;

wire PCSource;
wire [31:0] IFID_PC_in;
wire [31:0] inst;
wire [31:0] IFID_PC_o;
wire [31:0] inst_o;
wire IFID_ExtOp;
wire IFID_LuiOp;
wire [3:0] IFID_ALUOp;
wire [1:0] IFID_ALUSrcA;
wire [1:0] IFID_ALUSrc;
wire [1:0] IFID_RegDst;
wire IFID_MemRead;
wire IFID_MemWr;
wire IFID_Branch;
wire [1:0] IFID_MemtoReg;
wire IFID_RegWr;
wire [31:0] Read_data1;
wire [31:0] Read_data2;
wire [31:0] ImmExtOut;
wire [31:0] ImmShift;
wire [31:0] IDEX_Read_1_o;
wire [31:0] IDEX_Read_2_o;
wire [31:0] IDEX_PC_o;
wire [31:0] IDEX_ImmShift_o;
wire [31:0] IDEX_ImmExtOut_o;
wire [4:0] IDEX_rt_o;
wire [4:0] IDEX_rd_o;
wire [4:0] IDEX_shamt_o;
wire [5:0] IDEX_Funct_o;
wire IDEX_ExtOp;
wire IDEX_LuiOp;
wire [3:0] IDEX_ALUOp;
wire [1:0] IDEX_ALUSrcA;
wire [1:0] IDEX_ALUSrc;
wire [1:0] IDEX_RegDst;
wire IDEX_MemRead;
wire IDEX_MemWr;
wire IDEX_Branch;
wire [1:0] IDEX_MemtoReg;
wire IDEX_RegWr;
wire [31:0] adder_out;
wire [31:0] In1;
wire [31:0] In2;
wire [4:0] ALUConf;
wire Sign;
wire [2:0] zero;
wire [31:0] result;
wire [4:0] EXMEM_RtorRd_in;
wire [31:0] EXMEM_adder_o;
wire [2:0] EXMEM_zero;
wire [31:0] EXMEM_result_o;
wire [31:0] EXMEM_Read_2_o;
wire [4:0] EXMEM_RtorRd_o;
wire EXMEM_MemWr;
wire EXMEM_MemRead;
wire EXMEM_Branch;
wire [1:0] EXMEM_MemtoReg;
wire EXMEM_RegWr;
wire [31:0] DM_Read_data;
wire [31:0] MEMWB_Read_data_o;
wire [31:0] MEMWB_result_o;
wire [4:0] MEMWB_RtorRd_o;
wire [1:0] MEMWB_MemtoReg;
wire MEMWB_RegWr;
wire [31:0] write_data;
wire [31:0] PC_in;
wire [31:0] PC_o;
wire [4:0] IDEX_rs_o;
wire [1:0] forwardA;
wire [1:0] forwardB;
wire [31:0] forwardA_in;
wire [31:0] forwardB_in;
wire [31:0] PC_hazard_in;
wire [1:0] PC_MUX;
wire [1:0] IFID_MUX;
wire [1:0] IDEX_MUX;
wire [31:0] IFID_PC_hazard_in;
wire [31:0] inst_hazard;
wire IDEX_RegWr_hazard;
wire IDEX_MemWr_hazard;
wire IDEX_MemRead_hazard;
wire IDEX_Branch_hazard;
wire MEMWB_MemRead;
wire [1:0] forward_MEM;
wire [31:0] write_data_hazard;
wire [31:0] PC_in_first;
wire [1:0] Jump;
wire flush_IFID;
wire flush_IFIDEX;
wire [31:0] IFID_PC_hazard_in_flush;
wire [31:0] inst_hazard_flush;
wire [31:0] Read_data1_flush;
wire [31:0] Read_data2_flush;
wire [31:0] IFID_PC_o_flush;
wire [31:0] ImmShift_flush;
wire [31:0] ImmExtOut_flush;
wire [4:0] IFID_rs_in_flush;
wire [4:0] IFID_rt_in_flush;
wire [4:0] IFID_rd_in_flush;
wire [4:0] IFID_shamt_in_flush;
wire [5:0] IFID_Funct_in_flush;
wire IFID_ExtOp_flush;
wire IFID_LuiOp_flush;
wire [2:0] IFID_ALUOp_flush;
wire [1:0] IFID_ALUSrcA_flush;
wire [1:0] IFID_ALUSrc_flush;
wire [1:0] IFID_RegDst_flush;
wire IDEX_MemRead_hazard_flush;
wire IDEX_MemWr_hazard_flush;
wire IDEX_Branch_hazard_flush;
wire [1:0] IFID_MemtoReg_flush;
wire IDEX_RegWr_hazard_flush;
wire [5:0] IDEX_OpCode_o;
wire [5:0] IDEX_OpCode_in_flush;
wire [5:0] EXMEM_OpCode_o;
wire [31:0] code;
wire clk_o;
wire [11:0] outer;


clock_long cl(clk,reset,clk_o);
PC PCreg(reset,clk_o,PC_hazard_in,PC_o);
InstructionMem InstMem(reset,clk_o,PC_o,inst);
IFID_REG ifid_reg(reset,clk_o,IFID_PC_hazard_in_flush,inst_hazard_flush,IFID_PC_o,inst_o,IFID_ExtOp,IFID_LuiOp,IFID_ALUOp,IFID_ALUSrcA,IFID_ALUSrc,IFID_RegDst,IFID_MemRead,IFID_MemWr,IFID_Branch,IFID_MemtoReg,IFID_RegWr,Jump);
RegisterFile RF(reset, clk_o, MEMWB_RegWr, inst_o[25:21], inst_o[20:16], MEMWB_RtorRd_o, write_data, Read_data1, Read_data2);
ImmProcess Imm(IFID_ExtOp,IFID_LuiOp,inst_o[15:0],ImmExtOut,ImmShift);
IDEX_REG idex_reg(reset,clk_o,Read_data1_flush,Read_data2_flush,IFID_PC_o_flush,ImmShift_flush,ImmExtOut_flush,IDEX_OpCode_in_flush,IFID_rs_in_flush,IFID_rt_in_flush,IFID_rd_in_flush,IFID_shamt_in_flush,IFID_Funct_in_flush,
                  IDEX_Read_1_o,IDEX_Read_2_o,IDEX_PC_o,IDEX_ImmShift_o,IDEX_ImmExtOut_o,IDEX_OpCode_o,IDEX_rs_o,IDEX_rt_o,IDEX_rd_o,IDEX_shamt_o,IDEX_Funct_o,
                   IFID_ExtOp_flush,IFID_LuiOp_flush,IFID_ALUOp_flush,IFID_ALUSrcA_flush,IFID_ALUSrc_flush,IFID_RegDst_flush,IDEX_MemRead_hazard_flush,IDEX_MemWr_hazard_flush,IDEX_Branch_hazard_flush,IFID_MemtoReg_flush,IDEX_RegWr_hazard_flush,
                  IDEX_ExtOp,IDEX_LuiOp,IDEX_ALUOp,IDEX_ALUSrcA,IDEX_ALUSrc,IDEX_RegDst,IDEX_MemRead,IDEX_MemWr,IDEX_Branch,IDEX_MemtoReg,IDEX_RegWr);
ALU_add adder(reset,clk_o,IDEX_ImmShift_o,IDEX_PC_o,adder_out);
ALUControl conf(IDEX_ALUOp,IDEX_Funct_o,ALUConf,Sign);
ALU alu(ALUConf,IDEX_OpCode_o,Sign,In1,In2,zero,result);
EXMEM_REG exmem_reg(reset,clk_o,adder_out,zero,result,IDEX_Read_2_o,EXMEM_RtorRd_in,IDEX_OpCode_o,EXMEM_adder_o,EXMEM_zero,EXMEM_result_o,EXMEM_Read_2_o,EXMEM_RtorRd_o,EXMEM_OpCode_o,
                    IDEX_MemWr,IDEX_MemRead,IDEX_Branch,IDEX_MemtoReg,IDEX_RegWr,EXMEM_MemWr,EXMEM_MemRead,
                    EXMEM_Branch,EXMEM_MemtoReg,EXMEM_RegWr);
DataMem DM(reset,clk_o,EXMEM_result_o,write_data_hazard,EXMEM_MemWr,EXMEM_MemRead,DM_Read_data,code);
MEMWB_REG memwb_reg(reset,clk_o,DM_Read_data,EXMEM_result_o,EXMEM_RtorRd_o,MEMWB_Read_data_o,MEMWB_result_o,MEMWB_RtorRd_o,
                    EXMEM_MemtoReg,EXMEM_RegWr,EXMEM_MemRead,MEMWB_MemtoReg,MEMWB_RegWr,MEMWB_MemRead);
ForwardingUnit FU(reset,clk_o,EXMEM_RegWr,MEMWB_RegWr,EXMEM_RtorRd_o,MEMWB_RtorRd_o,EXMEM_MemWr,MEMWB_MemRead,IDEX_rs_o,IDEX_rt_o,forwardA,forwardB,forward_MEM);                 
HazardUnit HU(inst_o,IDEX_MemRead,IDEX_rt_o,inst_o[25:21],inst_o[20:16],PC_MUX,IFID_MUX,IDEX_MUX);


assign In1=(IDEX_ALUSrcA==2'b00)?forwardA_in:(IDEX_ALUSrcA==2'b11)?IDEX_shamt_o:32'b0;
assign In2=(IDEX_ALUSrc==2'b00)?forwardB_in:(IDEX_ALUSrc==2'b10)?IDEX_ImmExtOut_o:(IDEX_ALUSrc==2'b01)?(IDEX_PC_o):32'b0;
assign forwardA_in=(forwardA==2'b00)?IDEX_Read_1_o:(forwardA==2'b01)?write_data:(forwardA==2'b10)?EXMEM_result_o:32'b0;
assign forwardB_in=(forwardB==2'b00)?IDEX_Read_2_o:(forwardB==2'b01)?write_data:(forwardB==2'b10)?EXMEM_result_o:32'b0;
assign EXMEM_RtorRd_in=(IDEX_RegDst==2'b00)?IDEX_rt_o:(IDEX_RegDst==2'b01)?IDEX_rd_o:(IDEX_RegDst==2'b10)?5'd31:5'b0;
assign PCSource=(((zero==3'b001)&&(IDEX_OpCode_o==6'h04))||((zero==3'b010)&&(IDEX_OpCode_o==6'h11))||((zero==3'b100)&&(IDEX_OpCode_o==6'h12))||((zero==3'b011)&&(IDEX_OpCode_o==6'h13))||((zero==3'b110)&&(IDEX_OpCode_o==6'h14))||(zero==3'b101&&IDEX_OpCode_o==6'h15))&&IDEX_Branch;
assign write_data=(MEMWB_MemtoReg==2'b00)?MEMWB_result_o:(MEMWB_MemtoReg==2'b01)?MEMWB_Read_data_o:32'b0;
assign PC_in_first=PCSource?adder_out:(PC_o+4);
assign PC_in=(Jump==2'b01)?{IFID_PC_o[31:28],inst_o[25:0]<<2}:(Jump==2'b00)?PC_in_first:(Jump==2'b10)?Read_data1:0;
assign IFID_PC_in=PC_o+4;
assign PC_hazard_in=(PC_MUX==2'b01)?0:(PC_MUX==2'b10)?PC_o:(PC_MUX==2'b00)?PC_in:0;
assign IFID_PC_hazard_in=(IFID_MUX==2'b01)?0:(IFID_MUX==2'b10)?IFID_PC_o:(IFID_MUX==2'b00)?PC_o+4:0;
assign inst_hazard=(IFID_MUX==2'b01)?0:(IFID_MUX==2'b10)?inst_o:(IFID_MUX==2'b00)?inst:0;
assign IDEX_RegWr_hazard=(IDEX_MUX==2'b01)?0:(IDEX_MUX==2'b10)?IDEX_RegWr:(IDEX_MUX==2'b00)?IFID_RegWr:0;
assign IDEX_MemWr_hazard=(IDEX_MUX==2'b01)?0:(IDEX_MUX==2'b10)?IDEX_MemWr:(IDEX_MUX==2'b00)?IFID_MemWr:0;
assign IDEX_MemRead_hazard=(IDEX_MUX==2'b01)?0:(IDEX_MUX==2'b10)?IDEX_MemRead:(IDEX_MUX==2'b00)?IFID_MemRead:0;
assign IDEX_Branch_hazard=(IDEX_MUX==2'b01)?0:(IDEX_MUX==2'b10)?IDEX_Branch:(IDEX_MUX==2'b00)?IFID_Branch:0;
assign write_data_hazard=(forward_MEM==2'b00)?EXMEM_Read_2_o:(forward_MEM==2'b01)?MEMWB_Read_data_o:0;

assign flush_IFID=((((zero==3'b001&&IDEX_OpCode_o==6'h04)||(zero==3'b010&&IDEX_OpCode_o==6'h11)||(zero==3'b100&&IDEX_OpCode_o==6'h12)||(zero==3'b011&&IDEX_OpCode_o==6'h13)||(zero==3'b110&&IDEX_OpCode_o==6'h14)||(zero==3'b101&&IDEX_OpCode_o==6'h15))&&IDEX_Branch)||(inst_o[31:26]==6'h02||inst_o[31:26]==6'h03||(inst_o[31:26]==6'h0&&inst_o[5:0]==6'h08)))?1:0;//flush IFID
assign IFID_PC_hazard_in_flush=flush_IFID?0:IFID_PC_hazard_in;
assign inst_hazard_flush=flush_IFID?0:inst_hazard;

assign flush_IFIDEX=((zero==3'b001&&IDEX_OpCode_o==6'h04)||(zero==3'b010&&IDEX_OpCode_o==6'h11)||(zero==3'b100&&IDEX_OpCode_o==6'h12)||(zero==3'b011&&IDEX_OpCode_o==6'h13)||(zero==3'b110&&IDEX_OpCode_o==6'h14)||(zero==3'b101&&IDEX_OpCode_o==6'h15))&&IDEX_Branch?1:0;//flush IFIDEX
assign Read_data1_flush=flush_IFIDEX?0:Read_data1;
assign Read_data2_flush=flush_IFIDEX?0:Read_data2;
assign IFID_PC_o_flush=flush_IFIDEX?0:IFID_PC_o;
assign ImmShift_flush=flush_IFIDEX?0:ImmShift;
assign ImmExtOut_flush=flush_IFIDEX?0:ImmExtOut;
assign IFID_rs_in_flush=flush_IFIDEX?0:inst_o[25:21];
assign IFID_rt_in_flush=flush_IFIDEX?0:inst_o[20:16];
assign IFID_rd_in_flush=flush_IFIDEX?0:inst_o[15:11];
assign IFID_shamt_in_flush=flush_IFIDEX?0:inst_o[10:6];
assign IFID_Funct_in_flush=flush_IFIDEX?0:inst_o[5:0];
assign IFID_ExtOp_flush=flush_IFIDEX?0:IFID_ExtOp;
assign IFID_LuiOp_flush=flush_IFIDEX?0:IFID_LuiOp;
assign IFID_ALUOp_flush=flush_IFIDEX?0:IFID_ALUOp;
assign IFID_ALUSrcA_flush=flush_IFIDEX?0:IFID_ALUSrcA;
assign IFID_ALUSrc_flush=flush_IFIDEX?0:IFID_ALUSrc;
assign IFID_RegDst_flush=flush_IFIDEX?0:IFID_RegDst;
assign IDEX_MemRead_hazard_flush=flush_IFIDEX?0:IDEX_MemRead_hazard;
assign IDEX_MemWr_hazard_flush=flush_IFIDEX?0:IDEX_MemWr_hazard;
assign IDEX_Branch_hazard_flush=flush_IFIDEX?0:IDEX_Branch_hazard;
assign IFID_MemtoReg_flush=flush_IFIDEX?0:IFID_MemtoReg;
assign IDEX_RegWr_hazard_flush=flush_IFIDEX?0:IDEX_RegWr_hazard;
assign IDEX_OpCode_in_flush=flush_IFIDEX?0:inst_o[31:26];

assign out=DM.RAM_data[4];


endmodule
