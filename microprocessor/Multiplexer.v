`timescale 1ns/ 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:43:26 09/09/2012 
// Design Name: 
// Module Name:    Multiplexer 
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
module Multiplexer(
	 inputBus, select,
	 out);
	
	parameter inputWidth = 0;
	parameter numInputs = 0;
	parameter selectLines = 0;

	input [(inputWidth*numInputs)-1:0] inputBus;
	input [selectLines-1:0] select;
	output [inputWidth-1:0] out;
	
	wire [inputWidth-1:0] inputArray [0:numInputs-1];
	
	assign out = inputArray[select];

	genvar i;
	generate
		 for(i = 0; i < numInputs; i = i + 1) begin: inputArrayAssignment
			  assign  inputArray[i] = inputBus[(i*inputWidth)+:inputWidth];
		 end
	endgenerate
	
endmodule
