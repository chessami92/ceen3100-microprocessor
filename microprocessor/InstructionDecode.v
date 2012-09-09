`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date:    	12:20:01 09/09/2012 
// Design Name: 
// Module Name:    	InstructionDecode
// Project Name: 		microprocessor
// Description: 		
//
// Dependencies: 		RegisterFile, Control
//
//////////////////////////////////////////////////////////////////////////////////
module InstructionDecode(
    input [31:0] programCounterIn,
	 input [31:0] instruction,
    input [4:0] writeRegister,
    input [31:0] writeData,
	 input regWrite,
    input clk,
	 output reg [1:0] writeBackControl,
    output reg [2:0] memAccessControl,
    output reg [3:0] calculationControl,
	 output reg [31:0] programCounterOut,
    output reg [31:0] readData1,
	 output reg [31:0] readData2,
    output reg [31:0] immediateOperand,
    output reg [4:0] writeRegister0,
	 output reg [4:0] writeRegister1
    );
	
	wire [31:0] readData1Temp, readData2Temp, signExtendedImmediateValue;
	wire [1:0] writeBackControlTemp;
	wire [2:0] memAccessControlTemp;
	wire [3:0] calculationControlTemp;
	
	RegisterFile registerFile (
		.readRegister1(instruction[25:21]), 
		.readRegister2(instruction[20:16]), 
		.writeRegister(writeRegister), 
		.writeData(writeData), 
		.regWrite(regWrite), 
		.clk(clk), 
		.readData1(readData1Temp),
		.readData2(readData2Temp)
	);
	
	Control control (
		.opCode(instruction[31:26]), 
		.writeBackControl(writeBackControlTemp), 
		.memAccessControl(memAccessControlTemp), 
		.calculationControl(calculationControlTemp)
	);
	
	assign signExtendedImmediateValue =  {{15{instruction[15]}}, instruction[15:0]};
	
	always @(posedge clk) begin
			writeBackControl <= writeBackControlTemp;
			memAccessControl <= memAccessControlTemp;
			calculationControl <= calculationControlTemp;
			programCounterOut <= programCounterIn;
			readData1 <= readData1Temp;
			readData2 <= readData2Temp;
			immediateOperand <= signExtendedImmediateValue;
			writeRegister0 <= instruction[20:16];
			writeRegister1 <= instruction[15:11];
	end
	
endmodule
