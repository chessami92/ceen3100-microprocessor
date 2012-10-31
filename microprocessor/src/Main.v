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
	 input rst,
	 input rotA,
	 input rotB,
	 input rotCenter,
	 input clk,
	 output wire [11:8] SF_D, 
    output wire LCD_E,
    output wire LCD_RS,
    output wire LCD_RW
    );
	
	reg finishReset;
	
	reg lcdWriteEnable;
	reg [4:0] lcdLocation;
	reg [7:0] writeCharacter;
	wire [7:0] readCharacter;
	
	wire right, left, down;
	reg rightAck, leftAck, downAck;
	
	LcdController lcdController (
		.writeEnable(lcdWriteEnable), 
		.location(lcdLocation), 
		.data(writeCharacter),
		.clk(clk), 
		.readData(readCharacter),
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
	
	initial begin
		lcdLocation = 0;
		writeCharacter = 0;
		finishReset = 1;
		lcdWriteEnable = 0;
		
		rightAck = 0;
		leftAck = 0;
		downAck = 0;
	end
	
	always @(posedge clk) begin
		if (rst == 1) begin
			lcdWriteEnable = 1;
			lcdLocation <= lcdLocation + 1;
			writeCharacter = 8'h20;
			finishReset <= 1;
		end
		else if(finishReset == 1) begin
			lcdWriteEnable = 1;
			lcdLocation <= 0;
			writeCharacter = 8'h20;
			if(lcdLocation == 0)
				finishReset <= 0;
		end
		else if(right == 1 & rightAck == 0) begin
			writeCharacter = readCharacter + 1;
			lcdWriteEnable = 1;
			
			rightAck <= 1;
		end
		else if(left == 1 & leftAck == 0) begin
			writeCharacter = writeCharacter - 1;
			lcdWriteEnable = 1;
			
			leftAck <= 1;
		end
		else if(down == 1 & downAck == 0) begin
			lcdLocation <= lcdLocation + 1;
			writeCharacter = 8'h20;
			lcdWriteEnable = 1;
			
			downAck <= 1;
		end
		else begin
			lcdWriteEnable = 0;
			if(right == 0)
				rightAck <= 0;
			if(left == 0)
				leftAck <= 0;
			if(down == 0)
				downAck <= 0;
		end
	end

endmodule
