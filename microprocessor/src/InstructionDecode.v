`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date:    	12:20:01 09/09/2012 
// Design Name: 
// Module Name:    	InstructionDecode
// Project Name: 		microprocessor
// Description: 		
//
// Dependencies: 		RegisterFile.v, Control.v, HazardDetection.v
//
//////////////////////////////////////////////////////////////////////////////////
module InstructionDecode(
    input [31:0] programCounterIn,
    input [31:0] instruction,
    input [4:0] writeRegister,
    input [31:0] writeData,
    input [4:0] exMemRd,
    input regWrite,
    input exMemRegWrite,
    input clk,
    output reg [1:0] writeBackControl,
    output reg [1:0] memAccessControl,
    output reg [3:0] calculationControl,
    output reg [31:0] programCounterOut,
    output reg [31:0] readData1,
    output reg [31:0] readData2,
    output reg [31:0] immediateOperand,
    output reg [4:0] rs,
    output reg [4:0] rt,
    output reg [4:0] rd,
    output wire pcWrite,
    output wire ifIdWrite,
    output wire branch,
    output wire [31:0] branchProgramCounter
    );
	
	wire registerEqual;
	wire branchBuffer;
	reg flushNextInstruction;
	wire bubbleInstruction;
	wire [31:0] signExtendedImmediateValue;
	wire [5:0] currentOpCode;
	wire [4:0] currentRs, currentRt, currentRd;
	wire [31:0] readData1Buffer, readData2Buffer;
	wire [1:0] writeBackControlBuffer, memAccessControlBuffer;
	wire [3:0] calculationControlBuffer;
	
	//If registers are equal, set register equal to 1, otherwise set to 0
	assign registerEqual = (readData1Buffer == readData2Buffer ? 1 : 0);
	//Only allow a branch if the current instruction is not supposed to be flushed and the previous instruction was not a taken branch
	assign branch = branchBuffer & ~(flushNextInstruction | bubbleInstruction);
	//Set the program counter to the instruction to be taken if a branch is taken
	assign branchProgramCounter = programCounterIn + (signExtendedImmediateValue << 2);
	assign signExtendedImmediateValue = {{16{instruction[15]}}, instruction[15:0]};
	assign currentOpCode = instruction[31:26];
	assign currentRs = instruction[25:21];
	assign currentRt = instruction[20:16];
	assign currentRd = instruction[15:11];
	
	RegisterFile registerFile (
		.readRegister1(currentRs), 
		.readRegister2(currentRt), 
		.writeRegister(writeRegister), 
		.writeData(writeData), 
		.regWrite(regWrite), 
		.clk(clk),
		.readData1(readData1Buffer),
		.readData2(readData2Buffer)
	);
	
	Control control (
		.opCode(currentOpCode),
		.registerEqual(registerEqual),
		.writeBackControl(writeBackControlBuffer),
		.memAccessControl(memAccessControlBuffer),
		.calculationControl(calculationControlBuffer),
		.branch(branchBuffer)
	);
	
	HazardDetection hazardDetection (
		.idExMemRead(memAccessControl[1]), 
		.idExRegWrite(writeBackControl[1]),
		.exMemRegWrite(exMemRegWrite),
		.idExRt(rt), 
		.idExRd(rd),
		.ifIdRs(currentRs), 
		.ifIdRt(currentRt),
		.exMemRd(exMemRd),
		.opCode(currentOpCode),
		.pcWrite(pcWrite), 
		.ifIdWrite(ifIdWrite),
		.bubbleInstruction(bubbleInstruction)
	);
	
	always @(negedge clk) begin
		//If there is a hazard or the previous instruction was a branch that was taken, insert a bubble
		if(bubbleInstruction == 1 || flushNextInstruction == 1) begin
			writeBackControl <= 2'b0;
			memAccessControl <= 2'b0;
			calculationControl <= 4'b0;
			flushNextInstruction <= 1'b0;
		end
		else begin
			writeBackControl <= writeBackControlBuffer;
			memAccessControl <= memAccessControlBuffer;
			calculationControl <= calculationControlBuffer;
			flushNextInstruction <= branchBuffer;
		end
		
		programCounterOut <= programCounterIn;
		
		readData1 <= readData1Buffer;
		readData2 <= readData2Buffer;
		
		immediateOperand <= signExtendedImmediateValue;
		rs <= currentRs;
		rt <= currentRt;
		rd <= currentRd;
	end
	
endmodule
