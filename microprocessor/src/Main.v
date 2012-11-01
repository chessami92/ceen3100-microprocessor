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
	
	//reg [63:0] displayNames;
	wire [31:0] displayName[1:0];
	reg writeDisplayName;
	reg [31:0] displayValue[1:0];
	reg activeValue;
	reg registerUpdate;
	reg [2:0] registerUpdateNibble;
	reg [1:0] displayNameUpdateCharacter;
	reg [3:0] currentHex;
	
	wire right, left, down;
	reg previousRight, previousLeft, previousDown;
	
	LcdController lcdController (
		.writeEnable(lcdWriteEnable), 
		.location(lcdLocation), 
		.data(writeCharacter),
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
	
	assign displayName[0] = 32'h52313A20;
	assign displayName[1] = 32'h52323A20;
	
	initial begin
		lcdLocation = 0;
		writeCharacter = 0;
		lcdWriteEnable = 0;
		
		activeValue = 0;
		registerUpdate = 1;
		registerUpdateNibble = 0;
		currentHex = 0;
		
		previousRight = 1;
		previousLeft = 1;
		previousDown = 1;
		
		writeDisplayName = 1;
		displayNameUpdateCharacter = 0;
	end
	
	always @(posedge clk) begin
		if(rst == 1) begin
			registerUpdate <= 1;
			registerUpdateNibble <= 0;
			currentHex = 0;
		end
		else begin
			if(registerUpdate == 1) begin
				if(writeDisplayName == 1) begin
					if(activeValue == 0)
						lcdLocation = displayNameUpdateCharacter;
					else
						lcdLocation = displayNameUpdateCharacter + 16;
						
					case(displayNameUpdateCharacter)
						0: writeCharacter = displayName[activeValue][31:24];
						1: writeCharacter = displayName[activeValue][23:16];
						2: writeCharacter = displayName[activeValue][15:8];
						3: writeCharacter = displayName[activeValue][7:0];
						default: writeCharacter = 8'h20;
					endcase
					lcdWriteEnable = 1;
					
					displayNameUpdateCharacter <= displayNameUpdateCharacter + 1;
					if(displayNameUpdateCharacter == 2'b11)
						writeDisplayName <= 0;
				end
				else begin	
					if(activeValue == 0)
						lcdLocation = registerUpdateNibble + 4;
					else
						lcdLocation = registerUpdateNibble + 20;
					
					case(registerUpdateNibble)
						0: currentHex = displayValue[activeValue][31:28];
						1: currentHex = displayValue[activeValue][27:24];
						2: currentHex = displayValue[activeValue][23:20];
						3: currentHex = displayValue[activeValue][19:16];
						4: currentHex = displayValue[activeValue][15:12];
						5: currentHex = displayValue[activeValue][11:8];
						6: currentHex = displayValue[activeValue][7:4];
						7: currentHex = displayValue[activeValue][3:0];
						default: currentHex = 4'hx;
					endcase
					if(currentHex <= 9)
						writeCharacter = 8'h30 + currentHex;
					else if(currentHex >= 10)
						writeCharacter = 8'h30 + currentHex + 7;
					
					lcdWriteEnable = 1;
					
					registerUpdateNibble <= registerUpdateNibble + 1;
					if(registerUpdateNibble == 3'b111)
						registerUpdate <= 0;
				end
			end
			
			if(previousRight == 0 & right == 1) begin
				displayValue[activeValue] <= displayValue[activeValue] + 1;
				registerUpdate <= 1;
			end
			if(previousLeft == 0 & left == 1) begin
				displayValue[activeValue] <= displayValue[activeValue] - 1;
				registerUpdate <= 1;
			end
			if(previousDown == 0 & down == 1) begin
				activeValue <= ~activeValue;
				writeDisplayName <= 1;
				registerUpdate <= 1;
			end
			
			previousRight <= right;
			previousLeft <= left;
			previousDown <= down;
		end
	end

endmodule
