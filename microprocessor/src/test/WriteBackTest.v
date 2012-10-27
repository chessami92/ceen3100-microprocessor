`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:57:18 10/14/2012
// Design Name:   WriteBack
// Module Name:   C:/Users/Joshua/Google Drive/CEEN 3100/microprocessor/microprocessor/src/test/WriteBackTest.v
// Project Name:  microprocessor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: WriteBack
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module WriteBackTest;

	// Inputs
	reg memToReg;
	reg [31:0] readData;
	reg [31:0] result;

	// Outputs
	wire [31:0] writeData;

	// Instantiate the Unit Under Test (UUT)
	WriteBack uut (
		.memToReg(memToReg), 
		.readData(readData), 
		.result(result), 
		.writeData(writeData)
	);

	initial begin
		memToReg = 0;
		readData = 100;
		result = 200;
		
		#5 memToReg = 1;
		
		#5 memToReg = 0;
		
		#5 memToReg = 1'bx;
	end
      
endmodule

