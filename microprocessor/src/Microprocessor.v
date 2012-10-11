`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    	22:18:19 10/09/2012 
// Design Name: 
// Module Name:    	Microprocessor 
// Project Name: 		microprocessor
//
// Dependencies: 
//
//////////////////////////////////////////////////////////////////////////////////
module Microprocessor(
    input clk,
    output [7:0] led
    );
	
	//Control signals that are not in a buffer
	wire pcWrite, ifIdWrite;
	
	//Buffered signals
	wire [31:0] ifIdProgramCounter, ifIdInstruction;
	
	wire [1:0] idExWriteBackControl;
	wire [2:0] idExMemAccessControl;
	wire [3:0] idExCalculationControl;
	wire [31:0] idExProgramCounter, idExReadData1, idExReadData2, idExImmediateOperand;
	wire [4:0] idExRs, idExRt, idExRd;
	
	wire [1:0] exMemWriteBackControl;
	wire [2:0] exMemMemAccessControl;
	wire [31:0] exMemResult, exMemWriteData;
	wire [4:0] exMemRd;
	
	assign led = idExReadData1[7:0];
	
	InstructionFetch instructionFetch (
		.pcWrite(pcWrite), 
		.ifIdWrite(ifIdWrite), 
		.clk(clk), 
		.programCounterOut(ifIdProgramCounter), 
		.instruction(ifIdInstruction)
	);
	
	InstructionDecode instructionDecode (
		.programCounterIn(ifIdProgramCounter), 
		.instruction(ifIdInstruction), 
		//.writeRegister(), 
		//.writeData(), 
		//.regWrite(), 
		.clk(clk), 
		.writeBackControl(idExWriteBackControl), 
		.memAccessControl(idExMemAccessControl), 
		.calculationControl(idExCalculationControl), 
		.programCounterOut(idExProgramCounter), 
		.readData1(idExReadData1), 
		.readData2(idExReadData2), 
		.immediateOperand(idExImmediateOperand), 
		.rs(idExRs),
		.rt(idExRt), 
		.rd(idExRd), 
		.pcWrite(pcWrite), 
		.ifIdWrite(ifIdWrite)
	);
	
	Execute execute (
		.writeBackControlIn(idExWriteBackControl), 
		.memAccessControlIn(idExMemAccessControl), 
		.calculationControl(idExCalculationControl), 
		.readData1(idExReadData1), 
		.readData2(idExReadData2), 
		.immediateOperand(idExImmediateOperand), 
		.rs(idExRs), 
		.rt(idExRt), 
		.rdIn(idExRd), 
		//.memWbRegWrite(), 
		//.memWbRd(), 
		//.memWbData(), 
		.clk(clk), 
		.writeBackControlOut(exMemWriteBackControl), 
		.memAccessControlOut(exMemMemAccessControl), 
		.result(exMemResult), 
		.writeData(exMemWriteData), 
		.rdOut(exMemRd)
	);

endmodule
