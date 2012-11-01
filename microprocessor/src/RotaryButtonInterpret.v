`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:30:48 09/29/2012 
// Design Name: 
// Module Name:    RotaryButtonInterpret 
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
module RotaryButtonInterpret(
    input rotA,
    input rotB,
    input rotCenter,
	 input clk,
    output reg right,
    output reg left,
    output reg down
    );
	
	reg rotaryQ1, rotaryQ2, rotaryQ1Delay;
	reg [8:0] debounce; 
	
	initial begin
		rotaryQ1 = 1;
		rotaryQ2 = 0;
		rotaryQ1Delay = 1;
		debounce = 0;
	end
	
	always @(posedge clk) begin
		//Inputs when turning the knob according to the datasheet
		case ({rotB, rotA})
			2'b00: begin 
				rotaryQ1 <= 0; 
				rotaryQ2 <= rotaryQ2; 
			end
			2'b01: begin 
				rotaryQ1 <= rotaryQ1;
				rotaryQ2 <= 0;
			end
			2'b10: begin
				rotaryQ1 <= rotaryQ1;
				rotaryQ2 <= 1;
			end
			2'b11: begin
				rotaryQ1 <= 1;
				rotaryQ2 <= rotaryQ2;
			end
		endcase 
		
		rotaryQ1Delay <= rotaryQ1;
		//Interpretation of state machine according to datasheet
		if(rotaryQ1 == 1 && rotaryQ1Delay == 0) begin
			if(rotaryQ2 == 1) begin
				left <= 0;
				right <= 1;
			end
			else if(rotaryQ2 == 0) begin
				left <= 1;
				right <= 0;
			end
		end
		else if(rotaryQ1 == 0) begin
			left <= 0;
			right <= 0;
		end
		
		//Debouncing for rotary button press
		if(rotCenter == 0) begin
			debounce <= 0;
			down <= 0;
		end
		else 
			debounce <= debounce + 1;
			
		if(debounce == 9'hFFF) 
			down <= 1;
	end
endmodule
