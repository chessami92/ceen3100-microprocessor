`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date:    	23:01:32 09/04/2012 
// Design Name: 
// Module Name:    	RegisterFile 
// Project Name: 		microprocessor
// Description: 		
//
// Dependencies: 		None
//
//////////////////////////////////////////////////////////////////////////////////
module RegisterFile(
    readRegister1, readRegister2, writeRegister,
    writeData, regWrite, clk,
    readData1, readData2
    );
	
	input [4:0] readRegister1, readRegister2, writeRegister;
	input writeData, regWrite, clk;
	output [31:0] readData1, readData2;
	
	reg [31:0] readData1, readData2;
	
	reg [31:0] registers[31:0];
	
	always begin 
		readData1 <= registers[readRegister1];
		readData2 <= registers[readRegister2];
	end
	
	
	always @(posedge clk) begin
		if(regWrite == 1'b1) begin
			registers[writeRegister] <= writeData;
		end
	end
	
endmodule
