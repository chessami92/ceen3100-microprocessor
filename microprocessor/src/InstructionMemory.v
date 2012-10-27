`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date:   	21:43:55 10/09/2012 
// Design Name: 
// Module Name:    	InstructionMemory 
// Project Name: 		microprocessor
// Description: 
//
// Dependencies: 		None
//
//////////////////////////////////////////////////////////////////////////////////
module InstructionMemory(
    input [31:0] address,
    output wire [31:0] data
    );
	
	reg [31:0] memory[3:0];
	
	initial begin
		memory[3] = 32'b000000_01011_01100_01010_00000_000000; //add r10, r11, r12
		memory[2] = 32'b000000_01000_01001_00111_00000_000000; //add r7, r8, r9
		memory[1] = 32'b000000_00101_00110_00100_00000_000000; //add r4, r5, r6
		memory[0] = 32'b000000_00010_00011_00001_00000_000000; //add r1, r2, r3
	end
	
	assign data = memory[address[31:2]];

endmodule
