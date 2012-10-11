`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:42:14 10/09/2012 
// Design Name: 
// Module Name:    ForwardingUnit 
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
module ForwardingUnit(
    input [4:0] idExRs,
    input [4:0] idExRt,
    input [4:0] exMemRd,
	 input exMemRegWrite,
    input [4:0] memWbRd,
    input memWbRegWrite,
	 output reg [1:0] operand1Control,
	 output reg [1:0] operand2Control
    );
	
	parameter exMemForwardData = 2'b10, memWbForwardData = 2'b01, nominalOperand = 2'b00;
	
	always @(*) begin
		if(idExRs == exMemRd & exMemRegWrite == 1)
			operand1Control = exMemForwardData;
		else if(idExRs == memWbRd & memWbRegWrite == 1)
			operand1Control = memWbForwardData;
		else
			operand1Control = nominalOperand;
		
		if(idExRt == exMemRd & exMemRegWrite == 1)
			operand2Control = exMemForwardData;
		else if(idExRt == memWbRd & memWbRegWrite == 1)
			operand2Control = memWbForwardData;
		else
			operand2Control = nominalOperand;
	end

endmodule
