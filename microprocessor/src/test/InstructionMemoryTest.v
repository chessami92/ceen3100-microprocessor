`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:51:12 10/09/2012
// Design Name:   InstructionMemory
// Module Name:   C:/Users/Joshua/Google Drive/CEEN 3100/microprocessor/microprocessor/src/test/InstructionMemoryTest.v
// Project Name:  microprocessor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: InstructionMemory
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module InstructionMemoryTest;

	// Inputs
	reg [31:0] address;

	// Outputs
	wire [31:0] data;

	// Instantiate the Unit Under Test (UUT)
	InstructionMemory uut (
		.address(address), 
		.data(data)
	);

	initial begin
		// Initialize Inputs
		address = 0;

		#5 address = 4;
		#5 address = 8;
		#5 address = 12;
		#5 address = 16;
		#5 address = 48;
		#5 address = 0;
	end
      
endmodule

