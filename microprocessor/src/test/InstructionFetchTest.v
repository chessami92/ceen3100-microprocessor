`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:09:49 10/09/2012
// Design Name:   InstructionFetch
// Module Name:   C:/Users/Joshua/Google Drive/CEEN 3100/microprocessor/microprocessor/src/test/InstructionFetchTest.v
// Project Name:  microprocessor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: InstructionFetch
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module InstructionFetchTest;

	// Inputs
	reg pcWrite;
	reg ifIdWrite;
	reg branch;
	reg [31:0] branchProgramCounter;
	reg clk;

	// Outputs
	wire [31:0] programCounterOut;
	wire [31:0] instruction;

	// Instantiate the Unit Under Test (UUT)
	InstructionFetch uut (
		.pcWrite(pcWrite), 
		.ifIdWrite(ifIdWrite), 
		.branch(branch),
		.branchProgramCounter(branchProgramCounter),
		.clk(clk), 
		.programCounterOut(programCounterOut), 
		.instruction(instruction)
	);

	initial begin
		pcWrite = 1;
		ifIdWrite = 1;
		branch = 0;
		branchProgramCounter = 0;
		clk = 1;
		
		//Branch occurred
		#6 branch = 1;
		branchProgramCounter = 48;
		
		//Normal incrementing
		#10 branch = 0;
	end
	
	always begin
		#5 clk = ~clk;
	end
      
endmodule

