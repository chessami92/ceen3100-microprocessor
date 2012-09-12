`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:19:13 09/11/2012
// Design Name:   InstructionDecode
// Module Name:   C:/Users/Joshua/Google Drive/CEEN 3100/microprocessor/microprocessor/InstructionDecodeTest.v
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

module InstructionDecodeTest;

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
		.programCounterIn(programCounterIn), 
		.instruction(instruction), 
		.writeRegister(writeRegister), 
		.writeData(writeData), 
		.regWrite(regWrite), 
		.clk(clk), 
		.writeBackControl(writeBackControl), 
		.memAccessControl(memAccessControl), 
		.calculationControl(calculationControl), 
		.programCounterOut(programCounterOut), 
		.readData1(readData1), 
		.readData2(readData2), 
		.immediateOperand(immediateOperand), 
		.writeRegister0(writeRegister0), 
		.writeRegister1(writeRegister1)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		programCounterIn = 100;
		instruction = 0;
		writeRegister = 0;
		writeData = 0;
		regWrite = 0;
		
		
	end
	
	always begin
		#5 clk=~clk;
	end
      
endmodule

