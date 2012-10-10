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
	reg [4:0] idExRt;
	reg [4:0] ifIdRs;
	reg [4:0] ifIdRt;

	// Outputs
	wire pcWrite;
	wire ifIdWrite;
	wire bubbleInstruction;

	// Instantiate the Unit Under Test (UUT)
	HazardDetection uut (
		.idExMemRead, 
		.idExRt, 
		.ifIdRs, 
		.ifIdRt, 
		.pcWrite, 
		.ifIdWrite, 
		.bubbleInstruction
	);

	initial begin
		idExMemRead = 0;
		idExRt = 0;
		ifIdRs = 0;
		ifIdRt = 0;
		
		#5 idExMemRead = 1;
		ifIdRs = 1;
		
		#5 ifIdRt = 1;
		ifIdRs = 0;
		
		#5 ifIdRs = 1;
	end
      
endmodule

