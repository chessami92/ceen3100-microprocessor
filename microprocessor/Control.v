`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date:    	16:41:03 09/09/2012
// Design Name: 
// Module Name:    	Control
// Project Name: 		microprocessor
// Description: 		
//
// Dependencies: 		None
//
//////////////////////////////////////////////////////////////////////////////////
module Control(
    input [5:0] opCode,
    output wire [1:0] writeBackControl,
    output wire [2:0] memAccessControl,
    output wire [3:0] calculationControl
    );

	reg regWrite, memToReg;
	reg branch, memRead, memWrite;
	reg regDst, aluOp1, aluOp0, aluSrc;
	
	assign writeBackControl = {regWrite, memToReg};
	assign memAccessControl = {branch, memRead, memWrite};
	assign calculationControl = {regDst, aluOp1, aluOp0, aluSrc};
	
	always @(opCode) begin
		case(opCode)
			'b000000 : begin //R format
				regWrite = 1; memToReg = 0;
				branch = 0; memRead = 0; memWrite = 0;
				regDst = 1; aluOp1 = 1; aluOp0 = 0; aluSrc = 0;
			end
			'b000001 : begin //Load Word
				regWrite = 1; memToReg = 1;
				branch = 0; memRead = 1; memWrite = 0;
				regDst = 0; aluOp1 = 0; aluOp0 = 0; aluSrc = 1;
			end
			'b000010 : begin //Store Word
				regWrite = 0; 
				branch = 0; memRead = 0; memWrite = 1;
				aluOp1 = 0; aluOp0 = 0; aluSrc = 1;
			end
			'b000011 : begin //Branch if Equal
				regWrite = 0; 
				branch = 1; memRead = 0; memWrite = 0; 
				aluOp1 = 0; aluOp0 = 1; aluSrc = 0; 
			end
		endcase
	end
endmodule
