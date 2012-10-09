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
    output reg [4:0] rt,
	 output reg [4:0] rd,
	 output wire pcWrite,
	 output wire ifIdWrite
    );
	
	wire signExtendedImmediateValue;
	wire [5:0] currentOpCode;
	wire [4:0] currentRs, currentRt, currentRd;
	
	assign signExtendedImmediateValue = {{16{instruction[15]}}, instruction[15:0]};
	assign currentOpCode = instruction[31:26];
	assign currentRs = instruction[25:21];
	assign currentRt = instruction[20:16];
	assign currentRd = instruction[15:11];
	
	RegisterFile registerFile (
		.readRegister1(currentRs), 
		.readRegister2(currentRt), 
		.writeRegister(writeRegister), 
		.writeData(writeData), 
		.regWrite(regWrite), 
		.clk(clk),
		.readData1(readData1Buffer),
		.readData2(readData2Buffer)
	);
	
	Control control (
		.opCode(currentOpCode),
		.writeBackControl(writeBackControlBuffer),
		.memAccessControl(memAccessControlBuffer),
		.calculationControl(calculationControlBuffer)
	);
	
	HazardDetection hazardDetection (
		.idExMemRead(memAccessControl[1]), 
		.idExRt(rt), 
		.ifIdRs(currentRs), 
		.ifIdRt(currentRt),
		.pcWrite(pcWrite), 
		.ifIdWrite(ifIdWrite),
		.bubbleInstruction(bubbleInstruction)
	);
	
	always @(negedge clk) begin
			if(hazardDetection.bubbleInstruction == 1) begin
				writeBackControl <= 2'b0;
				memAccessControl <= 3'b0;
				calculationControl <= 4'b0;
			end
			else begin
				writeBackControl <= writeBackControlBuffer;
				memAccessControl <= memAccessControlBuffer;
				calculationControl <= calculationControlBuffer;
			end
			
			programCounterOut <= programCounterIn;
			
			readData1 <= readData1Buffer;
			readData2 <= readData2Buffer;
			
			immediateOperand <= signExtendedImmediateValue;
			rt <= currentRt;
			rd <= currentRd;
	end
	
endmodule
