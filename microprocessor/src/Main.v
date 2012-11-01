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
	
	reg lcdWriteEnable;
	reg [4:0] lcdLocation;
	reg [7:0] writeCharacter;
	wire [7:0] readCharacter;
	
	reg [31:0] registerValue;
	reg registerUpdate;
	reg [2:0] registerUpdateNibble;
	reg [3:0] currentHex;
	
	wire right, left, down;
	reg previousRight, previousLeft, previousDown;
	
	wire bit0, bit1, bit2;
	
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
		lcdWriteEnable = 0;
		
		registerValue = 0;
		registerUpdate = 1;
		registerUpdateNibble = 0;
		currentHex = 0;
		
		previousRight = 0;
		previousLeft = 0;
		previousDown = 0;
	end
	
	always @(posedge clk) begin
		if(rst == 1) begin
			registerValue <= 0;
			registerUpdate <= 1;
			registerUpdateNibble <= 0;
			currentHex = 0;
		end
		else begin
			if(registerUpdate == 1) begin
				lcdLocation = registerUpdateNibble;
				
				case(registerUpdateNibble)
					0: currentHex = {1'b0, bit2, bit1, bit0};//registerValue[31:28];
					1: currentHex = registerValue[27:24];
					2: currentHex = registerValue[23:20];
					3: currentHex = registerValue[19:16];
					4: currentHex = registerValue[15:12];
					5: currentHex = registerValue[11:8];
					6: currentHex = registerValue[7:4];
					7: currentHex = registerValue[3:0];
					default: currentHex = 4'hx;
				endcase
				if(currentHex <= 9)
					writeCharacter = 8'h30 + currentHex;
				else if(currentHex >= 10)
					writeCharacter = 8'h30 + currentHex + 7;
				else
					writeCharacter = 8'h21;
				
				lcdWriteEnable = 1;
				
				registerUpdateNibble <= registerUpdateNibble + 1;
				if(registerUpdateNibble == 3'b111)
					registerUpdate <= 0;
			end
			
			if(previousRight == 0 & right == 1) begin
				registerValue <= registerValue + 1;
				registerUpdate <= 1;
			end
			if(previousLeft == 0 & left == 1) begin
				registerValue <= registerValue - 1;
				registerUpdate <= 1;
			end
			if(previousDown == 0 & down == 1) begin
				registerValue <= 0;
				registerUpdate <= 1;
			end
			
			previousRight <= right;
			previousLeft <= left;
			previousDown <= down;
		end
	end

endmodule
