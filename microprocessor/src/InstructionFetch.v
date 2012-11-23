`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    	22:02:57 10/09/2012 
// Design Name: 
// Module Name:    	InstructionFetch 
// Project Name: 		microprocessor
//
// Dependencies: 		InstructionMemory.v
//
//////////////////////////////////////////////////////////////////////////////////
module InstructionFetch(
    input pcWrite,
    input ifIdWrite,
	 input branch,
	 input [31:0] branchProgramCounter,
    input clk,
    output reg [31:0] programCounterOut,
    output reg [31:0] instruction
    );
	
	reg [31:0] programCounter;
	wire [31:0] instructionBuffer;
	
	InstructionMemory instructionMemory (
		.address(programCounter), 
		.data(instructionBuffer)
	);
	
	initial begin
		programCounter = 0;
	end
	
	always @(negedge clk) begin
		if(pcWrite == 1)
			if(branch == 1)
				programCounter = branchProgramCounter;
			else
				programCounter = programCounter + 4;
		if(ifIdWrite == 1) begin
			programCounterOut <= programCounter; 
			instruction <= instructionBuffer;
		end
	end
endmodule
