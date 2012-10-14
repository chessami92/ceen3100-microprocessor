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
	reg [1:0] writeBackControl;
	reg [31:0] readData;
	reg [31:0] result;

	// Outputs
	wire [31:0] writeData;

	// Instantiate the Unit Under Test (UUT)
	WriteBack uut (
		.writeBackControl(writeBackControl), 
		.readData(readData), 
		.result(result), 
		.writeData(writeData)
	);

	initial begin
		writeBackControl = 0;
		readData = 100;
		result = 200;
		
		#5 writeBackControl = 1;
		
		#5 writeBackControl = 2;
		
		#5 writeBackControl = 2'bxx;
	end
      
endmodule

