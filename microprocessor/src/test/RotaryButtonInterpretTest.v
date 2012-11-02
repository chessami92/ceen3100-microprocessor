`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:50:39 09/29/2012
// Design Name:   RotaryButtonInterpret
// Module Name:   C:/Users/Joshua/Google Drive/CEEN 3100/MessingAround/RotaryButtonInterpretTest.v
// Project Name:  MessingAround
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: RotaryButtonInterpret
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module RotaryButtonInterpretTest;

	// Inputs
	reg rotA;
	reg rotB;
	reg rotCenter;
	reg clk;

	// Outputs
	wire right;
	wire left;
	wire down;

	// Instantiate the Unit Under Test (UUT)
	RotaryButtonInterpret uut (
		.rotA, 
		.rotB, 
		.rotCenter, 
		.clk, 
		.right, 
		.left, 
		.down
	);

	initial begin
		rotA = 0;
		rotB = 0;
		rotCenter = 0;
		clk = 0;
		
		#40 rotA = 1; //Right Turn
		#3000 rotB = 1;
		#3000 rotA = 0;
		#3000 rotB = 0;
		
		#3000 rotB = 1; //Left Turn
		#3000 rotA = 1;
		#3000 rotB = 0;
		#3000 rotA = 0;
		
		#3000 rotCenter = 1; //Down Press
		#250000 rotCenter = 0;
	end
	
	always begin
		#20 clk = ~clk;
	end
endmodule

