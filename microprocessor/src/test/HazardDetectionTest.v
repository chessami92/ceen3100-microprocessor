`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Create Date:   22:24:29 09/18/2012
// Design Name:   HazardDetection
// Module Name:   HazardDetectionTest.v
// Project Name:  microprocessor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: HazardDetection
//
// Dependencies:
// 
////////////////////////////////////////////////////////////////////////////////

module HazardDetectionTest;

	// Inputs
	reg idExMemRead;
	reg idExRegWrite;
	reg exMemRegWrite;
	reg [4:0] idExRt;
	reg [4:0] idExRd;
	reg [4:0] ifIdRs;
	reg [4:0] ifIdRt;
	reg [4:0] exMemRd;
	reg [5:0] opCode;

	// Outputs
	wire pcWrite;
	wire ifIdWrite;
	wire bubbleInstruction;

	// Instantiate the Unit Under Test (UUT)
	HazardDetection uut (
		.idExMemRead, 
		.idExRegWrite,
		.exMemRegWrite,
		.idExRt,
		.idExRd,
		.ifIdRs, 
		.ifIdRt, 
		.exMemRd,
		.opCode,
		.pcWrite, 
		.ifIdWrite, 
		.bubbleInstruction
	);

	initial begin
		idExMemRead = 0;
		idExRt = 0;
		idExRd = 0;
		ifIdRs = 0;
		ifIdRt = 0;
		exMemRd = 0;
		opCode = 0;
		idExRegWrite = 0;
		exMemRegWrite = 0;
		
		#5 idExMemRead = 1;
		ifIdRs = 1;
		
		#5 ifIdRt = 1;
		ifIdRs = 0;
		
		#5 ifIdRs = 1;
		
		#5 idExMemRead = 0;
		idExRegWrite = 1;
		idExRd = 1;
		
		//Branch opCode
		#5 opCode = 6'b000011;
		
		#5 idExRegWrite = 0;
		exMemRegWrite = 1;
		exMemRd = 1;
	end
endmodule
