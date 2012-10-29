`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date:    	21:58:15 09/18/2012 
// Design Name: 
// Module Name:    	HazardDetection 
// Project Name: 		microprocessor 
// Description: 
//
// Dependencies: 
//
//////////////////////////////////////////////////////////////////////////////////
module HazardDetection(
    input idExMemRead,
    input [4:0] idExRt,
    input [4:0] ifIdRs,
    input [4:0] ifIdRt,
    output reg pcWrite,
    output reg ifIdWrite,
    output reg bubbleInstruction
    );
	
	initial begin
		pcWrite = 1;
		ifIdWrite = 1;
		bubbleInstruction = 0;
	end
	
	always @(idExMemRead or idExRt or ifIdRs or ifIdRt) begin
		if(idExMemRead == 1'b1 & (idExRt == ifIdRs | idExRt == ifIdRt)) begin
			pcWrite = 0;
			ifIdWrite = 0;
			bubbleInstruction = 1;
		end
		else begin
			pcWrite = 1;
			ifIdWrite = 1;
			bubbleInstruction = 0;
		end
	end
endmodule
