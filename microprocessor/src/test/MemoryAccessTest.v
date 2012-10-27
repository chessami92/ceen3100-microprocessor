`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:22:28 10/13/2012
// Design Name:   MemoryAccess
// Module Name:   C:/Users/Joshua/Google Drive/CEEN 3100/microprocessor/microprocessor/src/test/MemoryAccessTest.v
// Project Name:  microprocessor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: MemoryAccess
//
// Dependencies:
// 
////////////////////////////////////////////////////////////////////////////////

module MemoryAccessTest;

	// Inputs
	reg [1:0] writeBackControlIn;
	reg [1:0] memAccessControl;
	reg [31:0] resultIn;
	reg [31:0] writeData;
	reg [4:0] rdIn;
	reg clk;

	// Outputs
	wire [1:0] writeBackControlOut;
	wire [31:0] readData;
	wire [31:0] resultOut;
	wire [4:0] rdOut;

	// Instantiate the Unit Under Test (UUT)
	MemoryAccess uut (
		.writeBackControlIn(writeBackControlIn), 
		.memAccessControl(memAccessControl), 
		.resultIn(resultIn), 
		.writeData(writeData), 
		.rdIn(rdIn), 
		.clk(clk), 
		.writeBackControlOut(writeBackControlOut), 
		.readData(readData), 
		.resultOut(resultOut), 
		.rdOut(rdOut)
	);

	initial begin
		clk = 0;
		
		#5 writeBackControlIn = 0;
		memAccessControl = 2;
		resultIn = 100;
		writeData = 20;
		rdIn = 5;
		
		#40 writeBackControlIn = 1;
		memAccessControl = 1;
		resultIn = 3;
		writeData = 200;
		rdIn = 1;
		
		#40 writeBackControlIn = 2;
		memAccessControl = 2;
		resultIn = 3;
		writeData = 200;
		rdIn = 2;
	end
	
	always begin
		#20 clk = ~clk;
	end
      
endmodule

