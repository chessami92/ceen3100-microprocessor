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
    input idExRegWrite,
    input exMemRegWrite,
    input [4:0] idExRt,
    input [4:0] idExRd,
    input [4:0] ifIdRs,
    input [4:0] ifIdRt,
    input [4:0] exMemRd,
    input [5:0] opCode,
    output reg pcWrite,
    output reg ifIdWrite,
    output reg bubbleInstruction
    );
	
	initial begin
		pcWrite = 1;
		ifIdWrite = 1;
		bubbleInstruction = 0;
	end
	
	always @(*) begin
		//Dependent on instruction that will be acccessing memory, LW writes to idExRt
		if(idExMemRead == 1'b1 && (idExRt == ifIdRs || idExRt == ifIdRt)) begin
			pcWrite <= 0;
			ifIdWrite <= 0;
			bubbleInstruction <= 1;
		end
		//Branch instruction has special hazard conditions
		else if(opCode == 6'b000011) begin
			//Dependent on instruction in execution stage; instruction will be writing to idExRd
			if(idExRegWrite == 1'b1 && (idExRd == ifIdRs || idExRd == ifIdRt)) begin
				pcWrite <= 0;
				ifIdWrite <= 0;
				bubbleInstruction <= 1;
			end
			//Dependent on instruction in memory stage
			else if(exMemRegWrite == 1'b1 && (exMemRd == ifIdRs || exMemRd == ifIdRt)) begin
				pcWrite <= 0;
				ifIdWrite <= 0;
				bubbleInstruction <= 1;
			end
			else begin
				pcWrite <= 1;
				ifIdWrite <= 1;
				bubbleInstruction <= 0;
			end
		end
		else begin
			pcWrite <= 1;
			ifIdWrite <= 1;
			bubbleInstruction <= 0;
		end
	end
endmodule
