`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    	22:50:08 10/10/2012 
// Design Name: 
// Module Name:    	MemoryAccess 
// Project Name: 		microprocessor
//
// Dependencies: 		None
//
//////////////////////////////////////////////////////////////////////////////////
module MemoryAccess(
    input [1:0] writeBackControlIn,
    input [1:0] memAccessControl,
    input [31:0] resultIn,
    input [31:0] writeData,
	 input [4:0] rdIn,
    input clk,
    output reg [1:0] writeBackControlOut,
    output reg [31:0] readData,
    output reg [31:0] resultOut,
    output reg [4:0] rdOut
    );
	
	reg [31:0] memory [7:0];
	wire [31:0] readDataBuffer;
	wire memRead, memWrite;
	
	assign memRead = memAccessControl[1];
	assign memWrite = memAccessControl[0];
	
	initial begin
		memory[7] = 7;
		memory[6] = 6;
		memory[5] = 5;
		memory[4] = 4;
		memory[3] = 3;
		memory[2] = 2;
		memory[1] = 1;
		memory[0] = 0;
	end
	
	always @(negedge clk) begin
		writeBackControlOut <= writeBackControlIn;
		readData <= readDataBuffer;
		resultOut <= resultIn;
		if(memWrite == 1)
			memory[resultIn] <= writeData;
		rdOut <= rdIn; 
	end
	
	assign readDataBuffer = (memRead ? memory[resultIn] : 32'hxxxxxxxx);
	
endmodule
