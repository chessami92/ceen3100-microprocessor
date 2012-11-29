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
	
	reg [31:0] memory[31:0];
	
	integer i;
	
	initial begin
		memory[0] =  32'b000000_00010_00011_00001_00000_000000; //ADD R1, R2, R3
		memory[1] =  32'b000000_00100_00001_00101_00000_000001; //SUB R5, R4, R1
		memory[2] =  32'b000010_00001_00101_0000000000010100;   //SW  R5, R1, 20
		memory[3] =  32'b000001_00001_00111_0000000000010100;   //LW  R7, R1, 20
		memory[4] =  32'b000011_00101_00111_0000000000000010;   //BEQ R5, R7, 2
		memory[5] =  32'b000000_00010_00011_00001_00000_000000; //ADD R1, R2, R3
		memory[6] =  32'b000000_00110_00111_00001_00000_000000; //ADD R1, R6, R7
		memory[7] =  32'b000000_00111_00100_00010_00000_000001; //SUB R2, R7, R4
		memory[8] =  32'b000000_00101_00010_00001_00000_000001; //SUB R1, R5, R2
		for(i = 9; i < 32; i = i + 1)
			memory[i] = 0;
	end
	
	assign data = memory[address[31:2]];

endmodule
