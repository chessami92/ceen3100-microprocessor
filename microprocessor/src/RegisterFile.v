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
    input [4:0] readRegister1, 
	 input [4:0] readRegister2, 
	 input [4:0] writeRegister,
    input [31:0] writeData, 
	 input regWrite, 
	 input clk,
    output wire [31:0] readData1, 
    output wire [31:0] readData2
    );

	reg [31:0] registers[31:0];
	
	integer i;
	
	initial begin
		for(i = 0; i < 31; i = i + 1)
			registers[i] = 32'b0;
	end
	
	always @(posedge clk) begin
		if(regWrite == 1'b1) begin
			registers[writeRegister] <= writeData;
		end
	end
	
	assign readData1 = registers[readRegister1];
	assign readData2 = registers[readRegister2];
	
endmodule
