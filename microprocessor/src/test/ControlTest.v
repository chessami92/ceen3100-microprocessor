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

	// Outputs
	wire [1:0] writeBackControl;
	wire [2:0] memAccessControl;
	wire [3:0] calculationControl;

	// Instantiate the Unit Under Test (UUT)
	Control uut (
		.opCode,
		.writeBackControl, 
		.memAccessControl, 
		.calculationControl
	);

	initial begin
		opCode = 0;
		#5 opCode = 1;
		#5 opCode = 2;
		#5 opCode = 3;
	end
	
endmodule

