`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:41:40 10/09/2012 
// Design Name: 
// Module Name:    Alu 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Alu(
    input [31:0] operand1,
    input [31:0] operand2,
    input [5:0] opCode,
    output reg [31:0] result
    );

	parameter ADD = 6'b000000, SUB = 6'b000001, AND = 6'b000010, OR = 6'b000011, XOR = 6'b000100;
	 
	always@(operand1, operand2, opCode)
	begin
		case(opCode)
			ADD: result = operand1 + operand2;
			SUB: result = operand1 - operand2;
			AND: result = operand1 & operand2;
			OR:  result = operand1 | operand2;
			XOR: result = operand1 ^ operand2;
			default: result = 0;
		endcase
	end	
	
endmodule
