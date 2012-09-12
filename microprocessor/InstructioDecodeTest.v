`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:06:50 09/11/2012
// Design Name:   InstructionDecode
// Module Name:   C:/Users/Joshua/Google Drive/CEEN 3100/microprocessor/microprocessor/InstructioDecodeTest.v
// Project Name:  microprocessor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: InstructionDecode
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module InstructioDecodeTest;

	// Inputs
	reg [31:0] programCounterIn;
	reg [31:0] instruction;
	reg [4:0] writeRegister;
	reg [31:0] writeData;
	reg regWrite;
	reg clk;

	// Outputs
	wire [1:0] writeBackControl;
	wire [2:0] memAccessControl;
	wire [3:0] calculationControl;
	wire [31:0] programCounterOut;
	wire [31:0] readData1;
	wire [31:0] readData2;
	wire [31:0] immediateOperand;
	wire [4:0] writeRegister0;
	wire [4:0] writeRegister1;

	// Instantiate the Unit Under Test (UUT)
	InstructionDecode uut (
		.programCounterIn, 
		.instruction, 
		.writeRegister, 
		.writeData, 
		.regWrite, 
		.clk, 
		.writeBackControl, 
		.memAccessControl, 
		.calculationControl, 
		.programCounterOut, 
		.readData1, 
		.readData2, 
		.immediateOperand, 
		.writeRegister0, 
		.writeRegister1
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		programCounterIn = 0;
		
		//Stimuli
		instruction = 32'b000000_00000_00001_00010_00000_000000;
		writeRegister = 0;
		writeData = 32'hFFFF_FFFF;
		regWrite = 1;
		
		#7.5 writeRegister = 1;
		
	end
	
	always begin
		#5 clk=~clk;
	end
      
endmodule

