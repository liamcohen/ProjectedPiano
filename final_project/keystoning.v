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
module keystoning
	#(parameter WHITE_KEY_WIDTH = 99,
					SPACE = 4,
					PIANO_MIDDLE = (5 * WHITE_KEY_WIDTH) + (4 * SPACE) + 2,
					BOARD_HEIGHT = 10'd768,
					KEY_START_VERTICAL = BOARD_HEIGHT >> 2)
    (input clk,
    input reset,
	 input [10:0] hcount,
	 input [9:0] vcount,
	 input hsync,
	 input vsync,
	 input blank,
	 input [16:0] key_num,
	 input note_ready,
	 input [1:0] state,
	 
	 output phsync,
	 output pvsync,
	 output pblank,
    output [23:0] keystoned_pixel
    );
	 
	parameter BLACK = 24'h00_00_00;
	parameter RED = 24'hFF_00_00;
	parameter GREEN = 24'h00_FF_00;
	
	reg [10:0] phcount;
	reg [9:0] pvcount;
	reg signed [10:0] x;
	wire [23:0] temp_pixel;
	
	always @(posedge clk)
	begin
		
		x <= hcount - PIANO_MIDDLE;
		phcount <= hcount - (((vcount - KEY_START_VERTICAL) * (x * -1)) >> 10);
		
	end
	
	piano #(.BOARD_WIDTH(11'd1024), .BOARD_HEIGHT(BOARD_HEIGHT),
			.WHITE_KEY_HEIGHT(BOARD_HEIGHT >> 2), .WHITE_KEY_WIDTH(WHITE_KEY_WIDTH),
			.WHITE_KEY_START_HORIZONTAL(0), .KEY_START_VERTICAL(KEY_START_VERTICAL),
			.BLACK_KEY_HEIGHT(BOARD_HEIGHT >> 3), .BLACK_KEY_WIDTH(60),
			.BLACK_KEY_START_HORIZONTAL(69), .SPACING(SPACE + WHITE_KEY_WIDTH))
		p(.vclock(clk), .reset(reset), .hcount(phcount), .vcount(vcount),
			.hsync(hsync), .vsync(vsync), .blank(blank), .key_num(key_num),
			.note_ready(note_ready), .state(state), .phsync(phsync), .pvsync(pvsync),
			.pblank(pblank), .pixel(temp_pixel));
	
	assign keystoned_pixel = (hcount < 2) ? BLACK : temp_pixel;
		
endmodule
