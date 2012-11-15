`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date:    	22:24:51 10/30/2012 
// Design Name: 
// Module Name:    	Main 
// Project Name: 		microprocessor
//
// Dependencies: 
//
//////////////////////////////////////////////////////////////////////////////////
module Main(
	 input rotA,
	 input rotB,
	 input rotCenter,
	 input clk,
	 output wire [11:8] SF_D, 
    output wire LCD_E,
    output wire LCD_RS,
    output wire LCD_RW
    );
	
	wire right, left, down;
	
	wire [63:0] displayName;
	wire [63:0] displayValue;
	
	assign displayName = 64'h50433A20414C553A;
	
	RegisterDisplay registerDisplay (
		.displayNameBus(displayName),
		.displayValueBus(displayValue),
		.left(left),
		.right(right),
		.clk(clk),
		.SF_D(SF_D), 
		.LCD_E(LCD_E), 
		.LCD_RS(LCD_RS), 
		.LCD_RW(LCD_RW)
	);	
	
	RotaryButtonInterpret rotaryButtonInterpret (
		.rotA(rotA), 
		.rotB(rotB), 
		.rotCenter(rotCenter), 
		.clk(clk), 
		.right(right), 
		.left(left), 
		.down(down)
	);
	
	always @(posedge clk) begin
		if(down == 1)
			displayValue <= displayValue - 1;
	end

endmodule
