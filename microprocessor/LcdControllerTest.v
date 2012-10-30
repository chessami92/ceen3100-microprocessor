`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:00:29 10/29/2012
// Design Name:   LcdController
// Module Name:   C:/Users/Joshua/Google Drive/CEEN 3100/microprocessor/microprocessor/LcdControllerTest.v
// Project Name:  microprocessor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: LcdController
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module LcdControllerTest;

	// Inputs
	reg writeEnable;
	reg [4:0] location;
	reg [7:0] data;
	reg clk;

	// Outputs
	wire [11:8] SF_D;
	wire LCD_E;
	wire LCD_RS;
	wire LCD_RW;

	// Instantiate the Unit Under Test (UUT)
	LcdController uut (
		.writeEnable(writeEnable), 
		.location(location), 
		.data(data), 
		.clk(clk), 
		.SF_D(SF_D), 
		.LCD_E(LCD_E), 
		.LCD_RS(LCD_RS), 
		.LCD_RW(LCD_RW)
	);

	initial begin
		// Initialize Inputs
		writeEnable = 0;
		location = 0;
		data = 0;
		clk = 0;
	end
	
	always begin
		#10 clk = ~clk;
	end      
endmodule
