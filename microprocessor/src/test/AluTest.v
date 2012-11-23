`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   09:57:19 10/10/2012
// Design Name:   Alu
// Module Name:   C:/Users/Joshua/Google Drive/CEEN 3100/microprocessor/microprocessor/src/test/AluTest.v
// Project Name:  microprocessor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Alu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module AluTest;

	// Inputs
	reg [31:0] operand1;
	reg [31:0] operand2;
	reg [5:0] opCode;

	// Outputs
	wire [31:0] result;

	parameter ADD = 6'b000000, SUB = 6'b000001, AND = 6'b000010, OR = 6'b000011, SLT= 6'b000100;

	// Instantiate the Unit Under Test (UUT)
	Alu uut (
		.operand1(operand1), 
		.operand2(operand2), 
		.opCode(opCode), 
		.result(result)
	);

	initial begin
		operand1 = 2;
		operand2 = 3;
		opCode = ADD;
		
		#5 opCode = SUB;
		#5 opCode = AND;
		#5 opCode = OR;
		
		#5 operand1 = 5;
		operand2 = 5;
		opCode = SUB;
		
		#5 opCode = SLT;
		operand1 = 2;
		operand2 = 3;
		
		#5 operand1 = 3;
		operand2 = 2;
		
		#5 operand2 = 3;
		
		#5 operand1 = -3;
		operand2= 3;
	end
endmodule
