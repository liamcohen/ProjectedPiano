`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Zoe Klawans
// 
// Create Date:    15:24:29 11/28/2017 
// Design Name: 
// Module Name:    keystoning 
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
module keystoning(
    input clk,
    input reset,
	 input [10:0] hcount,
	 input [9:0] vcount,
	 input hsync,
	 input vsync,
	 input blank,
	 input [16:0] key_num,
	 input note_ready,
	 
	 output phsync,
	 output pvsync,
	 output pblank,
    output [23:0] keystoned_pixel
    );
	
	parameter WHITE_KEY_WIDTH = 99;
	parameter SPACE = 4;
	parameter PIANO_MIDDLE = (5 * WHITE_KEY_WIDTH) + (4 * SPACE) + 2;
	parameter BOARD_HEIGHT = 10'd768;
	parameter KEY_START_VERTICAL = BOARD_HEIGHT >> 2;
   parameter WHITE_KEY_HEIGHT = BOARD_HEIGHT >> 2;
	parameter PIANO_LENGTH = (10 * WHITE_KEY_WIDTH) + (9 * SPACE);
	parameter PIANO_HALF = PIANO_LENGTH >> 1;
	
	reg [3:0] angle = 12;
	reg angle_up;
	reg angle_down;
	reg old_angle_up;
	reg old_angle_down;
	reg [10:0] phcount;
	reg [9:0] pvcount;
	reg signed [10:0] x;
	wire tan_angle;
	reg [4:0] counter = 0;
	
	always @(posedge clk)
	begin
//		if (angle_up && (angle_up != old_angle_up)) angle <= angle + 1;
//		if (angle_down && (angle_down != old_angle_down)) angle <= angle - 1;
//		
//		old_angle_up <= angle_up;
//		old_angle_down <= angle_down;
//		angle_up <= key_num[15];
//		angle_down <= key_num[14];
		
//		if (counter == 40)
//		begin
//		end
//		else
//		begin
//		end
		
		x <= hcount - PIANO_MIDDLE;
//		if (x < 0) phcount <= hcount - (((vcount - KEY_START_VERTICAL) * (x * -1)) >> 9);
//		else phcount <= hcount - (((vcount - KEY_START_VERTICAL) * (x * -1)) >> 9);
		phcount <= hcount - (((vcount - KEY_START_VERTICAL) * (x * -1)) >> 10);
	end
	
	piano p(.vclock(clk), .reset(reset), .hcount(phcount), .vcount(vcount),
			.hsync(hsync), .vsync(vsync), .blank(blank), .key_num(key_num),
			.note_ready(note_ready), .phsync(phsync), .pvsync(pvsync),
			.pblank(pblank), .pixel(keystoned_pixel));
	
endmodule
