`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:53:13 10/10/2012
// Design Name:   Execute
// Module Name:   C:/Users/Joshua/Google Drive/CEEN 3100/microprocessor/microprocessor/src/test/ExecuteTest.v
// Project Name:  microprocessor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Execute
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ExecuteTest;

	// Inputs
	reg [1:0] writeBackControlIn;
	reg [2:0] memAccessControlIn;
	reg [3:0] calculationControl;
	reg [31:0] readData1;
	reg [31:0] readData2;
	reg [31:0] immediateOperand;
	reg [4:0] rs;
	reg [4:0] rt;
	reg [4:0] rdIn;
	reg memWbRegWrite;
	reg [4:0] memWbRd;
	reg [31:0] memWbData;
	reg clk;

	// Outputs
	wire [1:0] writeBackControlOut;
	wire [2:0] memAccessControlOut;
	wire [31:0] result;
	wire [31:0] writeData;
	wire [4:0] rdOut;
	
	parameter ADD = 6'b000000, SUB = 6'b000001, AND = 6'b000010, OR = 6'b000011, XOR = 6'b000100;

	// Instantiate the Unit Under Test (UUT)
	Execute uut (
		.writeBackControlIn(writeBackControlIn), 
		.memAccessControlIn(memAccessControlIn), 
		.calculationControl(calculationControl), 
		.readData1(readData1), 
		.readData2(readData2), 
		.immediateOperand(immediateOperand), 
		.rs(rs), 
		.rt(rt), 
		.rdIn(rdIn), 
		.memWbRegWrite(memWbRegWrite), 
		.memWbRd(memWbRd), 
		.memWbData(memWbData), 
		.clk(clk), 
		.writeBackControlOut(writeBackControlOut), 
		.memAccessControlOut(memAccessControlOut), 
		.result(result), 
		.writeData(writeData), 
		.rdOut(rdOut)
	);

	initial begin
		clk = 0;
		writeBackControlIn = 0;
		memAccessControlIn = 0;
		calculationControl = 0;
		readData1 = 0;
		readData2 = 0;
		immediateOperand = 0;
		rs = 10;
		rt = 10;
		rdIn = 10;
		memWbRegWrite = 0;
		memWbRd = 0;
		memWbData = 0;	
		
		//ADD R0, R0, R1
		#15 writeBackControlIn = 2;
		memAccessControlIn = 0;
		calculationControl = 4'b1000;
		readData1 = 15;
		readData2 = 1;
		immediateOperand = ADD;
		rs = 0;
		rt = 1;
		rdIn = 0;
		memWbRegWrite = 2;
		memWbRd = 1;
		memWbData = 255;		
		
		//SUB R2, R2, R0
		#10 writeBackControlIn = 2;
		memAccessControlIn = 0;
		calculationControl = 4'b1000;
		readData1 = 3;
		readData2 = 1;
		immediateOperand = SUB;
		rs = 2;
		rt = 0;
		rdIn = 2;
		memWbRegWrite = 2;
		memWbRd = 1;
		memWbData = 16;
	end
	
	always begin
		#5 clk = ~clk;
	end
      
endmodule

