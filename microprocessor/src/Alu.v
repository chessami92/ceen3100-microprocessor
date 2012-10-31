`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    	22:41:40 10/09/2012 
// Design Name: 
// Module Name:    	Alu 
// Project Name: 		microprocessor
//
// Dependencies: 		None	
//
//////////////////////////////////////////////////////////////////////////////////
module Alu(
    input signed [31:0] operand1,
    input signed [31:0] operand2,
    input [5:0] opCode,
    output reg [31:0] result
    );

	parameter ADD = 6'b000000, SUB = 6'b000001, AND = 6'b000010, OR = 6'b000011, SLT = 6'b000100;
	 
	always@(operand1, operand2, opCode)
	begin
		case(opCode)
			ADD: result = operand1 + operand2;
			SUB, SLT: result = operand1 - operand2;
			AND: result = operand1 & operand2;
			OR:  result = operand1 | operand2;
<<<<<<< Updated upstream
			default: result = 32'hxxxxxxxx;
=======
			default: result = 0;
>>>>>>> Stashed changes
		endcase
		
		//Assign only the sign bit for SLT calculation
		if(opCode == SLT)
			result = {31'h00000000, result[31]};
	end	
	
endmodule
