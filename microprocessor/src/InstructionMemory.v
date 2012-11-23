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
		memory[0] =  32'b000010_00001_00101_0000000000010100;   //SW  R5, R1, 20
		memory[1] =  32'b000001_00001_00100_0000000000010100;   //LW  R4, R1, 20
		memory[2] =  32'b000000_00000_00001_00010_00000_000100; //SLT R2, R0, R1
		memory[3] =  32'b000000_00001_00110_00010_00000_000000; //ADD R2, R1, R6
		memory[4] =  32'b000000_00101_00100_00010_00000_000000; //ADD R2, R5, R4
		memory[5] =  32'b000011_00100_00101_0000000000000101;   //BEQ R4, R5, 5
		memory[6] =  32'b000000_00001_00100_00011_00000_000000; //ADD R3, R1, R4
		memory[7] =  32'b000000_00001_00100_00011_00000_000001; //SUB R3, R1, R4
		memory[8] =  32'b000000_00001_00111_00010_00000_000010; //AND R2, R1, R7
		memory[9] =  32'b000001_00001_00010_0000000000010101;   //LW  R2, R1, 21
		memory[10] = 32'b000000_00010_00101_00001_00000_000100; //SLT R1, R2, R5
		memory[11] = 32'b000000_00111_00010_00010_00000_000000; //ADD R2, R7, R2
		for(i = 12; i < 32; i = i + 1)
			memory[i] = 0;
	end
	
	assign data = memory[address[31:2]];

endmodule
