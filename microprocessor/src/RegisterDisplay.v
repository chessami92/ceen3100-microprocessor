`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:10:49 11/01/2012 
// Design Name: 
// Module Name:    registerDisplay 
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
module RegisterDisplay(
    input [63:0] displayNameBus,
    input [63:0] displayValueBus,
	 input left, 
	 input right,
	 input clk,
	 output wire [11:8] SF_D, 
    output wire LCD_E,
    output wire LCD_RS,
    output wire LCD_RW
    );
	
	wire [31:0] displayName [1:0];
	wire [31:0] displayValue [1:0];
	reg displayFirst; //Which register to display on line 1
	
	assign {displayName[0], displayName[1]} = displayNameBus;
	assign {displayValue[0], displayValue[1]} = displayValueBus;
	
	wire [7:0] hexAsciiMap[15:0];
	assign {hexAsciiMap[0], hexAsciiMap[1], hexAsciiMap[2], hexAsciiMap[3],
		hexAsciiMap[4], hexAsciiMap[5], hexAsciiMap[6], hexAsciiMap[7],
		hexAsciiMap[8], hexAsciiMap[9], hexAsciiMap[10], hexAsciiMap[11],
		hexAsciiMap[12], hexAsciiMap[13], hexAsciiMap[14], hexAsciiMap[15]} = 128'h30313233343536373839414243444546;
	
	reg [7:0] updateScreen;
	reg lcdWriteEnable;
	reg [4:0] lcdLocation;
	reg [7:0] writeCharacter;
	
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
	
	initial begin
		updateScreen = 0;
		displayFirst = 0;
		
		lcdLocation = 0;
		writeCharacter = 0;
		lcdWriteEnable = 0;
	end
	
	always @(posedge clk) begin
		if(updateScreen == 8'hFF) begin
			lcdLocation = lcdLocation + 1;
			if(lcdLocation == 11)
				lcdLocation = 16;
			else if(lcdLocation == 27) begin
				updateScreen <= 0;
				lcdLocation = 0;
			end
			
			case(lcdLocation)
				//First Row
				0: writeCharacter <= displayName[displayFirst][31:24];
				1: writeCharacter <= displayName[displayFirst][23:16];
				2: writeCharacter <= displayName[displayFirst][15:8];
				3: writeCharacter <= displayName[displayFirst][7:0];
				4: writeCharacter <= hexAsciiMap[displayValue[displayFirst][31:28]];
				5: writeCharacter <= hexAsciiMap[displayValue[displayFirst][27:24]];
				6: writeCharacter <= hexAsciiMap[displayValue[displayFirst][23:20]];
				7: writeCharacter <= hexAsciiMap[displayValue[displayFirst][19:16]];
				8: writeCharacter <= hexAsciiMap[displayValue[displayFirst][15:12]];
				9: writeCharacter <= hexAsciiMap[displayValue[displayFirst][11:8]];
				10: writeCharacter <= hexAsciiMap[displayValue[displayFirst][7:4]];
				11: writeCharacter <= hexAsciiMap[displayValue[displayFirst][3:0]];
				//Second Row
				16: writeCharacter <= displayName[displayFirst + 1][31:24];
				17: writeCharacter <= displayName[displayFirst + 1][23:16];
				18: writeCharacter <= displayName[displayFirst + 1][15:8];
				19: writeCharacter <= displayName[displayFirst + 1][7:0];
				20: writeCharacter <= hexAsciiMap[displayValue[displayFirst + 1][31:28]];
				21: writeCharacter <= hexAsciiMap[displayValue[displayFirst + 1][27:24]];
				22: writeCharacter <= hexAsciiMap[displayValue[displayFirst + 1][23:20]];
				23: writeCharacter <= hexAsciiMap[displayValue[displayFirst + 1][19:16]];
				24: writeCharacter <= hexAsciiMap[displayValue[displayFirst + 1][15:12]];
				25: writeCharacter <= hexAsciiMap[displayValue[displayFirst + 1][11:8]];
				26: writeCharacter <= hexAsciiMap[displayValue[displayFirst + 1][7:4]];
				27: writeCharacter <= hexAsciiMap[displayValue[displayFirst + 1][3:0]];
				default: writeCharacter <= 8'hxx;
			endcase
			lcdWriteEnable <= 1;
		end
		else
			updateScreen <= updateScreen + 1;
			
		if(right == 1) begin
			displayFirst <= displayFirst + 1;
		end
		if(left == 1) begin
			displayFirst <= displayFirst - 1;
		end
	end

endmodule
