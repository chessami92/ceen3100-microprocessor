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
	
	wire [1:0] idExWriteBackControl, idExMemAccessControl;
	wire [3:0] idExCalculationControl;
	wire [31:0] idExProgramCounter, idExReadData1, idExReadData2, idExImmediateOperand;
	wire [4:0] idExRs, idExRt, idExRd;
	
	wire [1:0] exMemWriteBackControl, exMemMemAccessControl;
	wire [31:0] exMemResult, exMemWriteData;
	wire [4:0] exMemRd;
	
	wire [1:0] memWbWriteBackControl;
	wire memWbRegWrite;
	wire [31:0] memWbReadData, memWbResult;
	wire [4;0] memWbRd;
	
	assign led = idExReadData1[7:0];
	assign memWbRegWrite = memWbWriteBackControl[1];
	
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
		.writeRegister(memWbRd), 
		//.writeData(), 
		.regWrite(memWbRegWrite), 
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
		.memWbRegWrite(memWbRegWrite), 
		.memWbRd(memWbRd), 
		//.memWbData(), 
		.clk(clk), 
		.writeBackControlOut(exMemWriteBackControl), 
		.memAccessControlOut(exMemMemAccessControl), 
		.result(exMemResult), 
		.writeData(exMemWriteData), 
		.rdOut(exMemRd)
	);
	
	MemoryAccess memoryAccess (
		.writeBackControlIn(exMemWriteBackControl), 
		.memAccessControl(exMemMemAccessControl), 
		.resultIn(exMemResult), 
		.writeData(exMemWriteData), 
		.rdIn(exMemRd), 
		.clk(clk), 
		.writeBackControlOut(memWbWriteBackControl), 
		.readData(memWbReadData), 
		.resultOut(memWbResult), 
		.rdOut(memWbRd)
	);

endmodule
