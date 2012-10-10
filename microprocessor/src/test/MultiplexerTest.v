`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:06:17 09/09/2012
// Design Name:   Multiplexer
// Module Name:   C:/Users/Joshua/Google Drive/CEEN 3100/microprocessor/microprocessor/MultiplexerTest.v
// Project Name:  microprocessor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Multiplexer
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module MultiplexerTest;

	// Inputs
	reg [15:0] inputBus;
	reg [1:0]select;

	// Outputs
	wire [3:0] out;

	// Instantiate the Unit Under Test (UUT)
	Multiplexer uut (
		.inputBus,
		.select,
		.out
	);
	
	defparam uut.inputWidth=4;
	defparam uut.numInputs=4;
	defparam uut.selectLines=2;
	
	initial begin
		inputBus = 16'h3210;
		select = 0;
		#5 select = 1;
		#5 select = 2;
		#5 select = 3;
		#5 inputBus = 16'h0123;
		#5 select = 2;
		#5 select = 1;
		#5 select = 0;
	end
      
endmodule

