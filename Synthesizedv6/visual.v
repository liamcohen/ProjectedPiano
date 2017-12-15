`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:17:57 12/05/2017 
// Design Name: 
// Module Name:    visual 
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
module visual(
	input clock_54mhz,
	input [16:0] key_num,
	input [1:0] state,
	input note_ready, reset,
	input [7:0] switch,
	
	output [7:0] vga_out_red, vga_out_green, vga_out_blue,
	output vga_out_sync_b, vga_out_blank_b, vga_out_pixel_clock,
			vga_out_hsync, vga_out_vsync
   );

	////////////////////////////////////////////////////////////////////////////
   //
   // visual module
   //
   ////////////////////////////////////////////////////////////////////////////

//   // use FPGA's digital clock manager to produce a
//   // 65MHz clock (actually 64.8MHz)
//   wire clock_65mhz_unbuf,clock_65mhz;
//   DCM vclk1(.CLKIN(clock_27mhz),.CLKFX(clock_65mhz_unbuf));
//   // synthesis attribute CLKFX_DIVIDE of vclk1 is 10
//   // synthesis attribute CLKFX_MULTIPLY of vclk1 is 20
//   // synthesis attribute CLK_FEEDBACK of vclk1 is NONE
//   // synthesis attribute CLKIN_PERIOD of vclk1 is 37
//   BUFG vclk2(.O(clock_65mhz),.I(clock_65mhz_unbuf));

   // power-on reset generation
//   wire power_on_reset;    // remain high for first 16 clocks
//   SRL16 reset_sr (.D(1'b0), .CLK(clock_65mhz), .Q(power_on_reset),
//         .A0(1'b1), .A1(1'b1), .A2(1'b1), .A3(1'b1));
//   defparam reset_sr.INIT = 16'hFFFF;
//
//   // RESET button is user reset
//   wire reset = power_on_reset;

   // generate basic XVGA video signals
   wire [10:0] hcount;
   wire [9:0]  vcount;
   wire hsync,vsync,blank;
   xvga xvga1(.vclock(clock_54mhz),.hcount(hcount),.vcount(vcount),
              .hsync(hsync),.vsync(vsync),.blank(blank));
	
	// debounce all buttons
//	wire b0, b1, b2, b3, enter, right, left, down, up;
//	debounce db0(.reset(reset), .clock(clock_65mhz), .noisy(~button0), .clean(b0));
//	debounce db1(.reset(reset), .clock(clock_65mhz), .noisy(~button1), .clean(b1));
//	debounce db2(.reset(reset), .clock(clock_65mhz), .noisy(~button2), .clean(b2));
//	debounce db3(.reset(reset), .clock(clock_65mhz), .noisy(~button3), .clean(b3));
//	debounce db_enter(.reset(reset), .clock(clock_65mhz), .noisy(~button_enter), .clean(enter));
//	debounce db_right(.reset(reset), .clock(clock_65mhz), .noisy(~button_right), .clean(right));
//	debounce db_left(.reset(reset), .clock(clock_65mhz), .noisy(~button_left), .clean(left));
//	debounce db_down(.reset(reset), .clock(clock_65mhz), .noisy(~button_down), .clean(down));
//	debounce db_up(.reset(reset), .clock(clock_65mhz), .noisy(~button_up), .clean(up));

   // feed XVGA signals to piano
   wire [23:0] pixel;
   wire phsync,pvsync,pblank;
//	wire [16:0] key_num = {left, up, down, right, enter, b3, b2, b1, b0, switch};
//	wire note_ready = 1;
   keystoning ks(.clk(clock_54mhz),.reset(reset),
                 .hcount(hcount),.vcount(vcount),
                 .hsync(hsync),.vsync(vsync),.blank(blank),
		.key_num(key_num), .note_ready(note_ready), .state(state),
                .phsync(phsync),.pvsync(pvsync),.pblank(pblank),.keystoned_pixel(pixel));

   // switch[1:0] selects which video generator to use:
   //  00: piano
   //  01: 1 pixel outline of active video area (adjust screen controls)
   //  10: color bars
	//  11: piano
   reg [23:0] rgb;
   wire border = (hcount==0 | hcount==1023 | vcount==0 | vcount==767);
   
   reg b,hs,vs;
   always @(posedge clock_54mhz) begin
//      if (switch[1:0] == 2'b01) begin
//    // 1 pixel outline of visible area (white)
//    hs <= hsync;
//    vs <= vsync;
//    b <= blank;
//    rgb <= {24{border}};
//      end else if (switch[1:0] == 2'b10) begin
//    // color bars
//    hs <= hsync;
//    vs <= vsync;
//    b <= blank;
//    rgb <= {{8{hcount[8]}}, {8{hcount[7]}}, {8{hcount[6]}}} ;
//      end else begin
         // default: piano
    hs <= phsync;
    vs <= pvsync;
    b <= pblank;
    rgb <= pixel;
//      end
   end
	
   assign vga_out_red = rgb[23:16];
   assign vga_out_green = rgb[15:8];
   assign vga_out_blue = rgb[7:0];
   assign vga_out_sync_b = 1'b1;    // not used
   assign vga_out_blank_b = ~b;
   assign vga_out_pixel_clock = ~clock_54mhz;
   assign vga_out_hsync = hs;
   assign vga_out_vsync = vs;

endmodule
