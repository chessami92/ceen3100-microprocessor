`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date:    	14:49:43 10/14/2012 
// Design Name: 
// Module Name:    	WriteBack 
// Project Name: 		microprocessor
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 		None
//
//////////////////////////////////////////////////////////////////////////////////
module WriteBack(
    input memToReg,
    input [31:0] readData,
    input [31:0] result,
    output reg [31:0] writeData
    );

	always @(memToReg, readData, result) begin
		case(memToReg)
			1'b0: writeData = result;
			1'b1: writeData = readData;
			default: writeData = 32'hxxxxxxxx;
		endcase
	end

endmodule
