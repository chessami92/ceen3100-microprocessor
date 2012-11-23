`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Create Date:   16:57:11 09/09/2012
// Design Name:   Control
// Module Name:   C:/Users/Joshua/Google Drive/CEEN 3100/microprocessor/microprocessor/ControlTest.v
// Project Name:  microprocessor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Control
//
// Dependencies:
// 
////////////////////////////////////////////////////////////////////////////////

module ControlTest;

	// Inputs
	reg [5:0] opCode;
	reg registerEqual;

	// Outputs
	wire [1:0] writeBackControl;
	wire [1:0] memAccessControl;
	wire [3:0] calculationControl;
	wire branch;

	// Instantiate the Unit Under Test (UUT)
	Control uut (
		.opCode,
		.registerEqual,
		.writeBackControl, 
		.memAccessControl, 
		.calculationControl,
		.branch
	);

	initial begin
		opCode = 0; //R-format
		registerEqual = 0;
		#5 opCode = 1; //Load Word
		#5 opCode = 2; //Store Word
		#5 opCode = 3; //Branch if equal
		#5 registerEqual = 1;
	end
endmodule
