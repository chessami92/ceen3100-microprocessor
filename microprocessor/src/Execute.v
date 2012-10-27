`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    	10:09:11 10/10/2012 
// Design Name: 
// Module Name:    	Execute 
// Project Name: 		microprocessor
//
// Dependencies: Alu.v, ForwardingUnit.v
//
//////////////////////////////////////////////////////////////////////////////////
module Execute(
    input [1:0] writeBackControlIn,
    input [1:0] memAccessControlIn,
    input [3:0] calculationControl,
    input [31:0] readData1,
    input [31:0] readData2,
    input [31:0] immediateOperand,
    input [4:0] rs,
    input [4:0] rt,
    input [4:0] rdIn,
    input memWbRegWrite,
	 input [4:0] memWbRd,
    input [31:0] memWbData,
	 input clk,
    output reg [1:0] writeBackControlOut,
    output reg [1:0] memAccessControlOut,
    output reg [31:0] result,
    output reg [31:0] writeData,
    output reg [4:0] rdOut
    );
	
	parameter exMemForwardData = 2'b10, memWbForwardData = 2'b01, nominalOperand = 2'b00;
	
	wire aluSrc, regDst;
	wire [1:0] aluOp;
	wire [1:0] operand1Control, operand2Control;
	wire [31:0] resultBuffer;
	reg [31:0] operand1, readData2Forwarded, operand2;
	
	assign regDst = calculationControl[3];
	assign aluSrc = calculationControl[0];
	assign aluOp = calculationControl[2:1];
	
	Alu alu (
		.operand1(operand1), 
		.operand2(operand2), 
		.opCode(immediateOperand[5:0]), 
		.result(resultBuffer)
	);
	
	ForwardingUnit forwardingUnit (
		.idExRs(rs), 
		.idExRt(rt), 
		.exMemRd(rdOut), 
		.exMemRegWrite(writeBackControlOut[1]), 
		.memWbRd(memWbRd), 
		.memWbRegWrite(memWbRegWrite), 
		.operand1Control(operand1Control), 
		.operand2Control(operand2Control)
	);
	
	initial begin
		operand1 = 0;
		readData2Forwarded = 0;
		operand2 = 0;
		writeBackControlOut = 0;
		memAccessControlOut = 0;
		result = 0;
		writeData = 0;
		rdOut = 0;
	end
	
	always @(*) begin
		case(operand1Control)
			nominalOperand: operand1 = readData1;
			memWbForwardData: operand1 = memWbData;
			exMemForwardData: operand1 = result;
			default: operand1 = 32'hxxxxxxxx;
		endcase
		
		
		case(operand2Control)
			nominalOperand: readData2Forwarded = readData2;
			memWbForwardData: readData2Forwarded = memWbData;
			exMemForwardData: readData2Forwarded = result;
			default: readData2Forwarded = 32'hxxxxxxxx;
		endcase
		
		if(aluSrc == 0) 
			operand2 = readData2Forwarded;
		else
			operand2 = immediateOperand;
	end
	
	always @(negedge clk) begin
		writeBackControlOut <= writeBackControlIn;
		memAccessControlOut <= memAccessControlIn;
		result <= resultBuffer;
		writeData <= readData2Forwarded;
		if(regDst == 0)
			rdOut <= rt;
		else
			rdOut <= rdIn;
	end
	
endmodule
