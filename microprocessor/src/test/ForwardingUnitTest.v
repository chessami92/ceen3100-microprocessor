`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   09:42:47 10/10/2012
// Design Name:   ForwardingUnit
// Module Name:   C:/Users/Joshua/Google Drive/CEEN 3100/microprocessor/microprocessor/src/test/ForwardingUnitTest.v
// Project Name:  microprocessor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ForwardingUnit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ForwardingUnitTest;

	// Inputs
	reg [4:0] idExRs;
	reg [4:0] idExRt;
	reg [4:0] exMemRd;
	reg exMemRegWrite;
	reg [4:0] memWbRd;
	reg memWbRegWrite;

	// Outputs
	wire [1:0] operand1Control;
	wire [1:0] operand2Control;

	// Instantiate the Unit Under Test (UUT)
	ForwardingUnit uut (
		.idExRs(idExRs), 
		.idExRt(idExRt), 
		.exMemRd(exMemRd), 
		.exMemRegWrite(exMemRegWrite), 
		.memWbRd(memWbRd), 
		.memWbRegWrite(memWbRegWrite), 
		.operand1Control(operand1Control), 
		.operand2Control(operand2Control)
	);

	initial begin
		idExRs = 4;
		idExRt = 4;
		exMemRd = 7;
		exMemRegWrite = 1;
		memWbRd = 4;
		memWbRegWrite = 1;
		
		#5 idExRt = 7;
		
		#5 exMemRd = 4;
		
		#5 memWbRd = 7;
		
		#5 exMemRegWrite = 0;
		memWbRegWrite = 0;
	end
endmodule
