`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:49:38 11/21/2017 
// Design Name: 
// Module Name:    piano 
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
////////////////////////////////////////////////////////////////////////////////
//
// generate piano
//
////////////////////////////////////////////////////////////////////////////////

module piano (
   input vclock,  // 65MHz clock
   input reset,      // 1 to initialize module
   input [10:0] hcount, // horizontal index of current pixel (0..1023)
   input [9:0]    vcount, // vertical index of current pixel (0..767)
   input hsync,      // XVGA horizontal sync signal (active low)
   input vsync,      // XVGA vertical sync signal (active low)
   input blank,      // XVGA blanking (1 means output black pixel)
	input [16:0] key_num,	// keys pressed on piano
	input note_ready,		// key_num valid note(s) on piano
   
   output phsync, // piano's horizontal sync
   output pvsync, // piano's vertical sync
   output pblank, // piano's blanking
   output [23:0] pixel  // piano's pixel  // r=23:16, g=15:8, b=7:0 
   );

   parameter PRESSED = 24'hFF_00_00;
   parameter WHITE = 24'hFF_FF_FF;
   parameter BLACK = 24'h00_00_00;
   parameter BOARD_WIDTH = 11'd1024;
   parameter BOARD_HEIGHT = 10'd768;
   parameter WHITE_KEY_HEIGHT = BOARD_HEIGHT >> 1;
   parameter WHITE_KEY_WIDTH = 90;
   parameter WHITE_KEY_START_HORIZONTAL = 11'd20;
   parameter KEY_START_VERTICAL = BOARD_HEIGHT >> 2;
   parameter BLACK_KEY_HEIGHT = WHITE_KEY_HEIGHT >> 1;
   parameter BLACK_KEY_WIDTH = 51;
   parameter BLACK_KEY_START_HORIZONTAL = 11'd85;
   parameter SPACING = 95;
   
   wire [23:0] c_pixel, db_pixel, d_pixel, eb_pixel, e_pixel, f_pixel, gb_pixel,
					g_pixel, ab_pixel, a_pixel, bb_pixel, b_pixel, high_c_pixel,
					high_db_pixel, high_d_pixel, high_eb_pixel, high_e_pixel;
	
	wire [23:0] c_color, db_color, d_color, eb_color, e_color, f_color, gb_color,
					g_color, ab_color, a_color, bb_color, b_color, high_c_color,
					high_db_color, high_d_color, high_eb_color, high_e_color;
	
	key_colors kc(.reset(reset), .clk(vclock), .note_ready(note_ready), .key_num(key_num),
			.c_color(c_color), .db_color(db_color), .d_color(d_color), .eb_color(eb_color),
			.e_color(e_color), .f_color(f_color), .gb_color(gb_color), .g_color(g_color),
			.ab_color(ab_color), .a_color(a_color), .bb_color(bb_color), .b_color(b_color),
			.high_c_color(high_c_color), .high_db_color(high_db_color), .high_d_color(high_d_color),
			.high_eb_color(high_eb_color), .high_e_color(high_e_color));
   
   assign phsync = hsync;
   assign pvsync = vsync;
   assign pblank = blank;
   
   // C key
   left_key #(.WIDTH(WHITE_KEY_WIDTH), .HEIGHT(WHITE_KEY_HEIGHT),
               .BLACK_KEY_HEIGHT(BLACK_KEY_HEIGHT), .BLACK_KEY_WIDTH(25))
      C(.x(WHITE_KEY_START_HORIZONTAL + (0 * SPACING)), .y(KEY_START_VERTICAL),
      .hcount(hcount), .vcount(vcount), .color(c_color), .pixel(c_pixel));
   
   // Db key
   blob #(.WIDTH(BLACK_KEY_WIDTH), .HEIGHT(BLACK_KEY_HEIGHT - 2))
      Db(.x(BLACK_KEY_START_HORIZONTAL + (0 * SPACING + 2)), .y(KEY_START_VERTICAL),
      .hcount(hcount), .vcount(vcount), .color(db_color), .pixel(db_pixel));
   
   // D key
   middle_key #(.WIDTH(WHITE_KEY_WIDTH), .HEIGHT(WHITE_KEY_HEIGHT),
                  .BLACK_KEY_HEIGHT(BLACK_KEY_HEIGHT), .BLACK_KEY_WIDTH(25))
      D(.x(WHITE_KEY_START_HORIZONTAL + (1 * SPACING)), .y(KEY_START_VERTICAL),
      .hcount(hcount), .vcount(vcount), .color(d_color), .pixel(d_pixel));
   
   // Eb key
   blob #(.WIDTH(BLACK_KEY_WIDTH), .HEIGHT(BLACK_KEY_HEIGHT - 2))
      Eb(.x(BLACK_KEY_START_HORIZONTAL + (1 * SPACING + 2)), .y(KEY_START_VERTICAL),
      .hcount(hcount), .vcount(vcount), .color(eb_color), .pixel(eb_pixel));
   
   // E key
   right_key #(.WIDTH(WHITE_KEY_WIDTH), .HEIGHT(WHITE_KEY_HEIGHT),
               .BLACK_KEY_HEIGHT(BLACK_KEY_HEIGHT), .BLACK_KEY_WIDTH(25))
      E(.x(WHITE_KEY_START_HORIZONTAL + (2 * SPACING)), .y(KEY_START_VERTICAL),
      .hcount(hcount), .vcount(vcount), .color(e_color), .pixel(e_pixel));
      
   // F key
   left_key #(.WIDTH(WHITE_KEY_WIDTH), .HEIGHT(WHITE_KEY_HEIGHT),
               .BLACK_KEY_HEIGHT(BLACK_KEY_HEIGHT), .BLACK_KEY_WIDTH(25))
      F(.x(WHITE_KEY_START_HORIZONTAL + (3 * SPACING)), .y(KEY_START_VERTICAL),
      .hcount(hcount), .vcount(vcount), .color(f_color), .pixel(f_pixel));
   
   // Gb key
   blob #(.WIDTH(BLACK_KEY_WIDTH), .HEIGHT(BLACK_KEY_HEIGHT - 2))
      Gb(.x(BLACK_KEY_START_HORIZONTAL + (3 * SPACING + 2)), .y(KEY_START_VERTICAL),
      .hcount(hcount), .vcount(vcount), .color(gb_color), .pixel(gb_pixel));
   
   // G key
   middle_key #(.WIDTH(WHITE_KEY_WIDTH), .HEIGHT(WHITE_KEY_HEIGHT),
                  .BLACK_KEY_HEIGHT(BLACK_KEY_HEIGHT), .BLACK_KEY_WIDTH(25))
      G(.x(WHITE_KEY_START_HORIZONTAL + (4 * SPACING)), .y(KEY_START_VERTICAL),
      .hcount(hcount), .vcount(vcount), .color(g_color), .pixel(g_pixel));
   
   // Ab key
   blob #(.WIDTH(BLACK_KEY_WIDTH), .HEIGHT(BLACK_KEY_HEIGHT - 2))
      Ab(.x(BLACK_KEY_START_HORIZONTAL + (4 * SPACING + 2)), .y(KEY_START_VERTICAL),
      .hcount(hcount), .vcount(vcount), .color(ab_color), .pixel(ab_pixel));
   
   // A key
   middle_key #(.WIDTH(WHITE_KEY_WIDTH), .HEIGHT(WHITE_KEY_HEIGHT),
                  .BLACK_KEY_HEIGHT(BLACK_KEY_HEIGHT), .BLACK_KEY_WIDTH(25))
      A(.x(WHITE_KEY_START_HORIZONTAL + (5 * SPACING)), .y(KEY_START_VERTICAL),
      .hcount(hcount), .vcount(vcount), .color(a_color), .pixel(a_pixel));
   
   // Bb key
   blob #(.WIDTH(BLACK_KEY_WIDTH), .HEIGHT(BLACK_KEY_HEIGHT - 2))
      Bb(.x(BLACK_KEY_START_HORIZONTAL + (5 * SPACING + 2)), .y(KEY_START_VERTICAL),
      .hcount(hcount), .vcount(vcount), .color(bb_color), .pixel(bb_pixel));
   
   // B key
   right_key #(.WIDTH(WHITE_KEY_WIDTH), .HEIGHT(WHITE_KEY_HEIGHT),
               .BLACK_KEY_HEIGHT(BLACK_KEY_HEIGHT), .BLACK_KEY_WIDTH(25))
      B(.x(WHITE_KEY_START_HORIZONTAL + (6 * SPACING)), .y(KEY_START_VERTICAL),
      .hcount(hcount), .vcount(vcount), .color(b_color), .pixel(b_pixel));
   
   // high C key
   left_key #(.WIDTH(WHITE_KEY_WIDTH), .HEIGHT(WHITE_KEY_HEIGHT),
               .BLACK_KEY_HEIGHT(BLACK_KEY_HEIGHT), .BLACK_KEY_WIDTH(25))
      high_C(.x(WHITE_KEY_START_HORIZONTAL + (7 * SPACING)), .y(KEY_START_VERTICAL),
      .hcount(hcount), .vcount(vcount), .color(high_c_color), .pixel(high_c_pixel));
   
   // high Db key
   blob #(.WIDTH(BLACK_KEY_WIDTH), .HEIGHT(BLACK_KEY_HEIGHT - 2))
      high_Db(.x(BLACK_KEY_START_HORIZONTAL + (7 * SPACING + 2)), .y(KEY_START_VERTICAL),
      .hcount(hcount), .vcount(vcount), .color(high_db_color), .pixel(high_db_pixel));
   
   // high D key
   middle_key #(.WIDTH(WHITE_KEY_WIDTH), .HEIGHT(WHITE_KEY_HEIGHT),
                  .BLACK_KEY_HEIGHT(BLACK_KEY_HEIGHT), .BLACK_KEY_WIDTH(25))
      high_D(.x(WHITE_KEY_START_HORIZONTAL + (8 * SPACING)), .y(KEY_START_VERTICAL),
      .hcount(hcount), .vcount(vcount), .color(high_d_color), .pixel(high_d_pixel));
   
   // high Eb key
   blob #(.WIDTH(BLACK_KEY_WIDTH), .HEIGHT(BLACK_KEY_HEIGHT - 2))
      high_Eb(.x(BLACK_KEY_START_HORIZONTAL + (8 * SPACING + 2)), .y(KEY_START_VERTICAL),
      .hcount(hcount), .vcount(vcount), .color(high_eb_color), .pixel(high_eb_pixel));
   
   // high E key
   right_key #(.WIDTH(WHITE_KEY_WIDTH), .HEIGHT(WHITE_KEY_HEIGHT),
               .BLACK_KEY_HEIGHT(BLACK_KEY_HEIGHT), .BLACK_KEY_WIDTH(25))
      high_E(.x(WHITE_KEY_START_HORIZONTAL + (9 * SPACING)), .y(KEY_START_VERTICAL),
      .hcount(hcount), .vcount(vcount), .color(high_e_color), .pixel(high_e_pixel));
   
   assign pixel = c_pixel | db_pixel | d_pixel | eb_pixel | e_pixel | f_pixel
                  | gb_pixel | g_pixel | ab_pixel | a_pixel | bb_pixel | b_pixel
                  | high_c_pixel | high_db_pixel | high_d_pixel | high_eb_pixel | high_e_pixel;
     
endmodule

