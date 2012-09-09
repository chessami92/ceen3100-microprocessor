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
    in0, in1, select,
	 out
    );
	
	parameter inputWidth = 0;
	
	input [inputWidth-1:0] in0, in1;
	input select;
	output wire [inputWidth-1:0] out;
	
	assign out = select ? in1: in0;
endmodule
