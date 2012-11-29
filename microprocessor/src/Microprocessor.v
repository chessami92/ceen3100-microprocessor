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
// Dependencies: 		InstructionFetch.v, InstructionMemory.v, InstructionDecode.v,
// RegisterFile.v, Control.v, HazardDetection.v, Execute.v, Alu.v, ForwardingUnit.v,
// MemoryAccess.v, WriteBack.v
//
//////////////////////////////////////////////////////////////////////////////////
module Microprocessor(
    input clk,
    output wire [31:0] programCounter,
    output wire [31:0] aluResult,
    output wire [31:0] r1,
    output wire [31:0] r2,
    output wire [31:0] r5,
    output wire [31:0] r7,
    output wire [31:0] mem25
    );
	
	//Control signals that are not in a buffer
	wire pcWrite, ifIdWrite, branch;
	wire [31:0] branchProgramCounter;
	
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
	wire [31:0] memWbReadData, memWbResult, memWbRegisterData;
	wire [4:0] memWbRd;
	
	assign memWbRegWrite = memWbWriteBackControl[1];
	
	//Only for output purposes
	assign programCounter = instructionFetch.programCounter;
	assign aluResult = exMemResult;
	assign r1 = instructionDecode.registerFile.registers[1];
	assign r2 = instructionDecode.registerFile.registers[2];
	assign r5 = instructionDecode.registerFile.registers[5];
	assign r7 = instructionDecode.registerFile.registers[7];
	assign mem25 = memoryAccess.memory[25];
	
	InstructionFetch instructionFetch (
		.pcWrite(pcWrite), 
		.ifIdWrite(ifIdWrite), 
		.branch(branch),
		.branchProgramCounter(branchProgramCounter),
		.clk(clk), 
		.programCounterOut(ifIdProgramCounter), 
		.instruction(ifIdInstruction)
	);
	
	InstructionDecode instructionDecode (
		.programCounterIn(ifIdProgramCounter), 
		.instruction(ifIdInstruction), 
		.writeRegister(memWbRd), 
		.writeData(memWbRegisterData), 
		.exMemRd(exMemRd),
		.regWrite(memWbRegWrite), 
		.exMemRegWrite(exMemWriteBackControl[1]),
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
		.ifIdWrite(ifIdWrite),
		.branch(branch),
		.branchProgramCounter(branchProgramCounter)
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
		.memWbData(memWbRegisterData), 
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
	
	WriteBack writeBack (
		.memToReg(memWbWriteBackControl[0]), 
		.readData(memWbReadData), 
		.result(memWbResult), 
		.writeData(memWbRegisterData)
	);

endmodule
