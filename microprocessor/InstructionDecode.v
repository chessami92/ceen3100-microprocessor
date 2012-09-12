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
	
	wire signExtendedImmediateValue;
	
	RegisterFile registerFile (
		.readRegister1(instruction[25:21]), 
		.readRegister2(instruction[20:16]), 
		.writeRegister(writeRegister), 
		.writeData(writeData), 
		.regWrite(regWrite), 
		.clk(clk)
	);
	
	Control control (
		.opCode(instruction[31:26])
	);
	
	assign signExtendedImmediateValue =  {{15{instruction[15]}}, instruction[15:0]};
	
	always @(negedge clk) begin
			writeBackControl <= control.writeBackControl;
			memAccessControl <= control.memAccessControl;
			calculationControl <= control.calculationControl;
			programCounterOut <= programCounterIn;
			readData1 <= registerFile.readData1;
			readData2 <= registerFile.readData2;
			immediateOperand <= signExtendedImmediateValue;
			writeRegister0 <= instruction[20:16];
			writeRegister1 <= instruction[15:11];
	end
	
endmodule
