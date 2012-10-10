`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:30:24 10/09/2012
// Design Name:   Microprocessor
// Module Name:   C:/Users/Joshua/Google Drive/CEEN 3100/microprocessor/microprocessor/src/test/MicroprocessorTest.v
// Project Name:  microprocessor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Microprocessor
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module MicroprocessorTest;

	// Inputs
	reg clk;

	// Outputs
	wire [7:0] led;

	// Instantiate the Unit Under Test (UUT)
	Microprocessor uut (
		.clk(clk), 
		.led(led)
	);

	initial begin
		clk = 0;
	end
	
	always begin
		#20 clk = ~clk;
	end
      
endmodule

