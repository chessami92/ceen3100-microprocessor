`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:57:59 10/30/2012
// Design Name:   Main
// Module Name:   C:/Users/Joshua/Google Drive/CEEN 3100/microprocessor/microprocessor/src/test/MainTest.v
// Project Name:  microprocessor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Main
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module MainTest;

	// Inputs
	reg rst;
	reg rotA;
	reg rotB;
	reg rotCenter;
	reg clk;

	// Outputs
	wire [11:8] SF_D;
	wire LCD_E;
	wire LCD_RS;
	wire LCD_RW;

	// Instantiate the Unit Under Test (UUT)
	Main uut (
		.rst(rst), 
		.rotA(rotA), 
		.rotB(rotB), 
		.rotCenter(rotCenter), 
		.clk(clk), 
		.SF_D(SF_D), 
		.LCD_E(LCD_E), 
		.LCD_RS(LCD_RS), 
		.LCD_RW(LCD_RW)
	);

	initial begin
		rst = 0;
		rotA = 0;
		rotB = 0;
		rotCenter = 0;

		#100000000 rotA = 1;
		#40 rotB = 1;
		#40 rotA = 0;
		#40 rotB = 0;
		
		#1000 rotB = 1;
		#40 rotA = 1;
		#40 rotB = 0;
		#40 rotA = 0;
	end
	
	always begin
		clk = 0;
		#12 clk = 1;
		#8;
	end
      
endmodule

