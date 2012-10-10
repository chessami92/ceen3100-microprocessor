`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:18:19 10/09/2012 
// Design Name: 
// Module Name:    Microprocessor 
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
module Microprocessor(
    input clk,
    output [7:0] led
    );
	
	//Control signals that are not in a buffer
	wire pcWrite, ifIdWrite;
	
	//Buffered signals
	wire [31:0] ifIdProgramCounter, ifIdInstruction;
	wire [1:0] ifIdWriteBackControl;
	wire [2:0] ifIdMemAccessControl;
	wire [3:0] ifIdCalculationControl;
	wire [31:0] idExProgramCounter, idExReadData1, idExReadData2, idExImmediateOperand;
	
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
		.writeRegister(), 
		.writeData(), 
		.regWrite(), 
		.clk(clk), 
		.writeBackControl(ifIdWriteBackControl), 
		.memAccessControl(ifIdMemAccessControl), 
		.calculationControl(ifIdCalculationControl), 
		.programCounterOut(idExProgramCounter), 
		.readData1(idExReadData1), 
		.readData2(idExReadData2), 
		.immediateOperand(idExImmediateOperand), 
		.rt(), 
		.rd(), 
		.pcWrite(pcWrite), 
		.ifIdWrite(ifIdWrite)
	);

endmodule
