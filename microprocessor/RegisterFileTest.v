`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:39:51 09/04/2012
// Design Name:   RegisterFile
// Module Name:   C:/Users/Joshua/Google Drive/CEEN 3100/microprocessor/microprocessor/RegisterFileTest.v
// Project Name:  microprocessor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: RegisterFile
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module RegisterFileTest;

	// Inputs
	reg [4:0] readRegister1;
	reg [4:0] readRegister2;
	reg [4:0] writeRegister;
	reg [31:0]writeData;
	reg regWrite;
	reg clk;

	// Outputs
	wire [31:0] readData1;
	wire [31:0] readData2;

	// Instantiate the Unit Under Test (UUT)
	RegisterFile uut (
		.readRegister1(readRegister1), 
		.readRegister2(readRegister2), 
		.writeRegister(writeRegister), 
		.writeData(writeData), 
		.regWrite(regWrite), 
		.clk(clk), 
		.readData1(readData1),
		.readData2(readData2)
	);

	integer i; 

	initial begin
		//Initialize inputs
		clk = 0;
		
		//Stimuli		
		for (i = 0; i < 32; i = i +1) begin
			writeRegister=i;
			writeData=i;
			regWrite=1;
			#10;
		end
		
		writeRegister=0;
		writeData=0;
		regWrite=0;
		
		for (i = 0; i< 32; i = i + 1) begin
			readRegister1=i;
			readRegister2=(31-i);
			#10;
		end
	end
	
	always begin
		#5 clk=~clk;
	end
      
endmodule

