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
	reg [7:0] in0;
	reg [7:0] in1;
	reg select;

	// Outputs
	wire [7:0] out;

	// Instantiate the Unit Under Test (UUT)
	Multiplexer uut (
		.in0(in0), 
		.in1(in1), 
		.select(select), 
		.out(out)
	);
	
	defparam uut.inputWidth=8;	
	
	initial begin
		in0 = 'hFF;
		in1 = 0;
		select = 0;
		#5 select = 1;
		#5 in1 = 'hAA;
	end
      
endmodule

