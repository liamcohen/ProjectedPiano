`default_nettype none
///////////////////////////////////////////////////////////////////////////////
//
// 6.111 FPGA Labkit -- Template Toplevel Module
//
// For Labkit Revision 004
//
//
// Created: October 31, 2004, from revision 003 file
// Author: Nathan Ickes
//
///////////////////////////////////////////////////////////////////////////////
//
// CHANGES FOR BOARD REVISION 004
//
// 1) Added signals for logic analyzer pods 2-4.
// 2) Expanded "tv_in_ycrcb" to 20 bits.
// 3) Renamed "tv_out_data" to "tv_out_i2c_data" and "tv_out_sclk" to
//    "tv_out_i2c_clock".
// 4) Reversed disp_data_in and disp_data_out signals, so that "out" is an
//    output of the FPGA, and "in" is an input.
//
// CHANGES FOR BOARD REVISION 003
//
// 1) Combined flash chip enables into a single signal, flash_ce_b.
//
// CHANGES FOR BOARD REVISION 002
//
// 1) Added SRAM clock feedback path input and output
// 2) Renamed "mousedata" to "mouse_data"
// 3) Renamed some ZBT memory signals. Parity bits are now incorporated into 
//    the data bus, and the byte write enables have been combined into the
//    4-bit ram#_bwe_b bus.
// 4) Removed the "systemace_clock" net, since the SystemACE clock is now
//    hardwired on the PCB to the oscillator.
//
///////////////////////////////////////////////////////////////////////////////
//
// Complete change history (including bug fixes)
//
// 2006-Mar-08: Corrected default assignments to "vga_out_red", "vga_out_green"
//              and "vga_out_blue". (Was 10'h0, now 8'h0.)
//
// 2005-Sep-09: Added missing default assignments to "ac97_sdata_out",
//              "disp_data_out", "analyzer[2-3]_clock" and
//              "analyzer[2-3]_data".
//
// 2005-Jan-23: Reduced flash address bus to 24 bits, to match 128Mb devices
//              actually populated on the boards. (The boards support up to
//              256Mb devices, with 25 address lines.)
//
// 2004-Oct-31: Adapted to new revision 004 board.
//
// 2004-May-01: Changed "disp_data_in" to be an output, and gave it a default
//              value. (Previous versions of this file declared this port to
//              be an input.)
//
// 2004-Apr-29: Reduced SRAM address busses to 19 bits, to match 18Mb devices
//              actually populated on the boards. (The boards support up to
//              72Mb devices, with 21 address lines.)
//
// 2004-Apr-29: Change history started
//
///////////////////////////////////////////////////////////////////////////////

module labkit (beep, audio_reset_b, ac97_sdata_out, ac97_sdata_in, ac97_synch,
	       ac97_bit_clock,
	       
	       vga_out_red, vga_out_green, vga_out_blue, vga_out_sync_b,
	       vga_out_blank_b, vga_out_pixel_clock, vga_out_hsync,
	       vga_out_vsync,

	       tv_out_ycrcb, tv_out_reset_b, tv_out_clock, tv_out_i2c_clock,
	       tv_out_i2c_data, tv_out_pal_ntsc, tv_out_hsync_b,
	       tv_out_vsync_b, tv_out_blank_b, tv_out_subcar_reset,

	       tv_in_ycrcb, tv_in_data_valid, tv_in_line_clock1,
	       tv_in_line_clock2, tv_in_aef, tv_in_hff, tv_in_aff,
	       tv_in_i2c_clock, tv_in_i2c_data, tv_in_fifo_read,
	       tv_in_fifo_clock, tv_in_iso, tv_in_reset_b, tv_in_clock,

	       ram0_data, ram0_address, ram0_adv_ld, ram0_clk, ram0_cen_b,
	       ram0_ce_b, ram0_oe_b, ram0_we_b, ram0_bwe_b, 

	       ram1_data, ram1_address, ram1_adv_ld, ram1_clk, ram1_cen_b,
	       ram1_ce_b, ram1_oe_b, ram1_we_b, ram1_bwe_b,

	       clock_feedback_out, clock_feedback_in,

	       flash_data, flash_address, flash_ce_b, flash_oe_b, flash_we_b,
	       flash_reset_b, flash_sts, flash_byte_b,

	       rs232_txd, rs232_rxd, rs232_rts, rs232_cts,

	       mouse_clock, mouse_data, keyboard_clock, keyboard_data,

	       clock_27mhz, clock1, clock2,

	       disp_blank, disp_data_out, disp_clock, disp_rs, disp_ce_b,
	       disp_reset_b, disp_data_in,

	       button0, button1, button2, button3, button_enter, button_right,
	       button_left, button_down, button_up,

	       switch,

	       led,
	       
	       user1, user2, user3, user4,
	       
	       daughtercard,

	       systemace_data, systemace_address, systemace_ce_b,
	       systemace_we_b, systemace_oe_b, systemace_irq, systemace_mpbrdy,
	       
	       analyzer1_data, analyzer1_clock,
 	       analyzer2_data, analyzer2_clock,
 	       analyzer3_data, analyzer3_clock,
 	       analyzer4_data, analyzer4_clock);

   output beep, audio_reset_b, ac97_synch, ac97_sdata_out;
   input  ac97_bit_clock, ac97_sdata_in;
   
   output [7:0] vga_out_red, vga_out_green, vga_out_blue;
   output vga_out_sync_b, vga_out_blank_b, vga_out_pixel_clock,
	  vga_out_hsync, vga_out_vsync;

   output [9:0] tv_out_ycrcb;
   output tv_out_reset_b, tv_out_clock, tv_out_i2c_clock, tv_out_i2c_data,
	  tv_out_pal_ntsc, tv_out_hsync_b, tv_out_vsync_b, tv_out_blank_b,
	  tv_out_subcar_reset;
   
   input  [19:0] tv_in_ycrcb;
   input  tv_in_data_valid, tv_in_line_clock1, tv_in_line_clock2, tv_in_aef,
	  tv_in_hff, tv_in_aff;
   output tv_in_i2c_clock, tv_in_fifo_read, tv_in_fifo_clock, tv_in_iso,
	  tv_in_reset_b, tv_in_clock;
   inout  tv_in_i2c_data;
        
   inout  [35:0] ram0_data;
   output [18:0] ram0_address;
   output ram0_adv_ld, ram0_clk, ram0_cen_b, ram0_ce_b, ram0_oe_b, ram0_we_b;
   output [3:0] ram0_bwe_b;
   
   inout  [35:0] ram1_data;
   output [18:0] ram1_address;
   output ram1_adv_ld, ram1_clk, ram1_cen_b, ram1_ce_b, ram1_oe_b, ram1_we_b;
   output [3:0] ram1_bwe_b;

   input  clock_feedback_in;
   output clock_feedback_out;
   
   inout  [15:0] flash_data;
   output [23:0] flash_address;
   output flash_ce_b, flash_oe_b, flash_we_b, flash_reset_b, flash_byte_b;
   input  flash_sts;
   
   output rs232_txd, rs232_rts;
   input  rs232_rxd, rs232_cts;

   input  mouse_clock, mouse_data, keyboard_clock, keyboard_data;

   input  clock_27mhz, clock1, clock2;

   output disp_blank, disp_clock, disp_rs, disp_ce_b, disp_reset_b;  
   input  disp_data_in;
   output  disp_data_out;
   
   input  button0, button1, button2, button3, button_enter, button_right,
	  button_left, button_down, button_up;
   input  [7:0] switch;
   output [7:0] led;

   inout [31:0] user1, user2, user3, user4;
   
   inout [43:0] daughtercard;

   inout  [15:0] systemace_data;
   output [6:0]  systemace_address;
   output systemace_ce_b, systemace_we_b, systemace_oe_b;
   input  systemace_irq, systemace_mpbrdy;

   output [15:0] analyzer1_data, analyzer2_data, analyzer3_data, 
		 analyzer4_data;
   output analyzer1_clock, analyzer2_clock, analyzer3_clock, analyzer4_clock;

   ////////////////////////////////////////////////////////////////////////////
   //
   // I/O Assignments
   //
   ////////////////////////////////////////////////////////////////////////////
   
   // Audio Input and Output
   assign beep= 1'b0;
   assign audio_reset_b = 1'b0;
   assign ac97_synch = 1'b0;
   assign ac97_sdata_out = 1'b0;
   // ac97_sdata_in is an input

   // VGA Output
   assign vga_out_red = 8'h0;
   assign vga_out_green = 8'h0;
   assign vga_out_blue = 8'h0;
   assign vga_out_sync_b = 1'b1;
   assign vga_out_blank_b = 1'b1;
   assign vga_out_pixel_clock = 1'b0;
   assign vga_out_hsync = 1'b0;
   assign vga_out_vsync = 1'b0;

   // Video Output
   assign tv_out_ycrcb = 10'h0;
   assign tv_out_reset_b = 1'b0;
   assign tv_out_clock = 1'b0;
   assign tv_out_i2c_clock = 1'b0;
   assign tv_out_i2c_data = 1'b0;
   assign tv_out_pal_ntsc = 1'b0;
   assign tv_out_hsync_b = 1'b1;
   assign tv_out_vsync_b = 1'b1;
   assign tv_out_blank_b = 1'b1;
   assign tv_out_subcar_reset = 1'b0;
   
   // Video Input
   assign tv_in_i2c_clock = 1'b0;
   assign tv_in_fifo_read = 1'b0;
   assign tv_in_fifo_clock = 1'b0;
   assign tv_in_iso = 1'b0;
   assign tv_in_reset_b = 1'b0;
   assign tv_in_clock = 1'b0;
   assign tv_in_i2c_data = 1'bZ;
   // tv_in_ycrcb, tv_in_data_valid, tv_in_line_clock1, tv_in_line_clock2, 
   // tv_in_aef, tv_in_hff, and tv_in_aff are inputs
   
   // SRAMs
   assign ram0_data = 36'hZ;
   assign ram0_address = 19'h0;
   assign ram0_adv_ld = 1'b0;
   assign ram0_clk = 1'b0;
   assign ram0_cen_b = 1'b1;
   assign ram0_ce_b = 1'b1;
   assign ram0_oe_b = 1'b1;
   assign ram0_we_b = 1'b1;
   assign ram0_bwe_b = 4'hF;
   assign ram1_data = 36'hZ; 
   assign ram1_address = 19'h0;
   assign ram1_adv_ld = 1'b0;
   assign ram1_clk = 1'b0;
   assign ram1_cen_b = 1'b1;
   assign ram1_ce_b = 1'b1;
   assign ram1_oe_b = 1'b1;
   assign ram1_we_b = 1'b1;
   assign ram1_bwe_b = 4'hF;
   assign clock_feedback_out = 1'b0;
   // clock_feedback_in is an input
   
   // Flash ROM
   assign flash_data = 16'hZ;
   assign flash_address = 24'h0;
   assign flash_ce_b = 1'b1;
   assign flash_oe_b = 1'b1;
   assign flash_we_b = 1'b1;
   assign flash_reset_b = 1'b0;
   assign flash_byte_b = 1'b1;
   // flash_sts is an input

   // RS-232 Interface
   assign rs232_txd = 1'b1;
   assign rs232_rts = 1'b1;
   // rs232_rxd and rs232_cts are inputs

   // PS/2 Ports
   // mouse_clock, mouse_data, keyboard_clock, and keyboard_data are inputs

   // LED Displays
   assign disp_blank = 1'b1;
   assign disp_clock = 1'b0;
   assign disp_rs = 1'b0;
   assign disp_ce_b = 1'b1;
   assign disp_reset_b = 1'b0;
   assign disp_data_out = 1'b0;
   // disp_data_in is an input

   // Buttons, Switches, and Individual LEDs
   //assign led = 8'hFF;
   // button0, button1, button2, button3, button_enter, button_right,
   // button_left, button_down, button_up, and switches are inputs

   // User I/Os
   assign user1 = 32'hZ;
   assign user2 = 32'hZ;
   assign user3 = 32'hZ;
   assign user4 = 32'hZ;

   // Daughtercard Connectors
   assign daughtercard = 44'hZ;

   // SystemACE Microprocessor Port
   assign systemace_data = 16'hZ;
   assign systemace_address = 7'h0;
   assign systemace_ce_b = 1'b1;
   assign systemace_we_b = 1'b1;
   assign systemace_oe_b = 1'b1;
   // systemace_irq and systemace_mpbrdy are inputs

   // Logic Analyzer
   assign analyzer1_data = 16'h0;
   assign analyzer1_clock = 1'b1;
   assign analyzer2_data = 16'h0;
   assign analyzer2_clock = 1'b1;
   //assign analyzer3_data = 16'h0;
   //assign analyzer3_clock = 1'b1;
   assign analyzer4_data = 16'h0;
   assign analyzer4_clock = 1'b1;
	
	//Testing I2C master
	wire clean_button0;
	wire clean_button1;
	wire clean_button2;
	
	//assign led = {7'b1111111, ~button1 ? 1'b0 : 1'b1};
	
	wire [1:0] fnc_sel;
	
	debounce db_button0 (
		.clock(clock_27mhz),
		.reset(switch[0]),
		.bouncey(~button0),
		.steady(clean_button0)
	);
	
	debounce db_button1 (
		.clock(clock_27mhz),
		.reset(switch[0]),
		.bouncey(~button1),
		.steady(clean_button1)
	);
	
	debounce db_button2 (
		.clock(clock_27mhz),
		.reset(switch[0]),
		.bouncey(~button2),
		.steady(clean_button2)
	);
	
	wire clk_1000Hz;
	wire clk_200Hz;
	assign fnc_sel = {1'b1, 1'b1};
	
	wire timer_start_read;
	wire timer_start_write;
	wire timer_start_write_multi;
	wire timer_start;
	
	wire [3:0] timer_param_read;
	wire [3:0] timer_param_write;
	wire [3:0] timer_param_write_multi;
	wire [3:0] timer_param;
	
	wire timer_exp;
	
	wire timer_reset_read;
	wire timer_reset_write;
	wire timer_reset_write_multi;
	wire timer_reset;
	
	mux4 m_timer_start (
		.sel(fnc_sel),
		.signal0(1'b0),
		.signal1(timer_start_read),
		.signal2(timer_start_write),
		.signal3(timer_start_write_multi),
		.out(timer_start)
	);
	
	mux4 #(.SIGNAL_WIDTH(4)) m_timer_param (
		.sel(fnc_sel),
		.signal0(4'b0000),
		.signal1(timer_param_read),
		.signal2(timer_param_write),
		.signal3(timer_param_write_multi),
		.out(timer_param)
	);
	
	mux4 m_timer_reset (
		.sel(fnc_sel),
		.signal0(1'b1),
		.signal1(timer_reset_read),
		.signal2(timer_reset_write),
		.signal3(timer_reset_write_multi),
		.out(timer_reset)
	);
	
	Timer timer (
		.clk(clock_27mhz),
		.reset(timer_reset),
		.startTimer(timer_start),
		.value(timer_param),
		.enable(clk_1000Hz),
		.time_expired(timer_exp)
	);
	
	divider div (
		.clk(clock_27mhz),
		.reset(timer_start),
		.clk_1000Hz(clk_1000Hz)
	);
	
	divider #(130000) div2 (
		.clk(clock_27mhz),
		.reset(clean_button0),
		.clk_1000Hz(clk_200Hz)
	);
	
	wire [6:0] dev_address;
	wire [7:0] reg_address;
   wire [7:0] data;
	wire [3:0] byte_width;

	wire i2c_write_done;
	wire i2c_read_done;
	wire i2c_write_multi_done;
	wire i2c_data_out_ready;
	wire i2c_cmd_ready;
	wire i2c_bus_busy;
	wire i2c_bus_control;
	wire i2c_bus_active;
	wire i2c_missed_ack;
	
	wire [7:0] i2c_data_out_read;
	wire [7:0] i2c_data_out_write;
	wire [7:0] i2c_data_out_write_multi;
	
	wire [7:0] i2c_data_in;
	
	wire [6:0] i2c_dev_address_write;
	wire [6:0] i2c_dev_address_read;
	wire [6:0] i2c_dev_address_write_multi;
	
	wire [7:0] read_data_out;
	wire read_data_en;
	wire read_data_empty;
	wire read_data_valid;
	wire read_data_underflow;
	
	wire i2c_data_in_valid;
	wire i2c_data_in_ready_read;
	
	wire i2c_data_in_last;
	 
	wire i2c_cmd_start_read;
	wire i2c_cmd_start_write;
	wire i2c_cmd_start_write_multi;
	
	wire i2c_cmd_write_multiple_write;
	wire i2c_cmd_write_multiple_write_multi;
	
	wire i2c_cmd_write_read;
	wire i2c_cmd_read_read;
	
	wire i2c_cmd_stop_read;
	wire i2c_cmd_stop_write;
	wire i2c_cmd_stop_write_multi;
	
	wire i2c_cmd_valid_read;
	wire i2c_cmd_valid_write;
	wire i2c_cmd_valid_write_multi;
	
	wire i2c_data_out_valid_read;
	wire i2c_data_out_valid_write;
	wire i2c_data_out_valid_write_multi;
	
	wire i2c_data_out_last_write;
	wire i2c_data_out_last_write_multi;
	
	wire [3:0] state_out_read;
	wire [3:0] state_out_write;
	wire [3:0] state_out_write_multi;
	 
	wire message_failure_read;
	wire message_failure_write;
	wire message_failure_write_multi;
	wire message_failure;
	wire i2c_control_read;
	wire i2c_control_write;
	wire i2c_control_default;
	
	//need to write i2c default such that when no modules are running
	//i2c master is fed valid inputs.
	
	i2c_read_reg read (
		.dev_address(dev_address),
		.reg_address(reg_address),
		.byte_width(byte_width),
		
		.clk(clock_27mhz),
		.reset(clean_button0),
		.start(1'b0),
		.done(i2c_read_done),
		
		.timer_exp(timer_exp),
		.timer_param(timer_param_read),
		.timer_start(timer_start_read),
		.timer_reset(timer_reset_read),
		
		.i2c_data_out_ready(i2c_data_out_ready),
		.i2c_cmd_ready(i2c_cmd_ready),
		.i2c_bus_busy(i2c_bus_busy),
		.i2c_bus_control(i2c_bus_control),
	   .i2c_bus_active(i2c_bus_active),
	   .i2c_missed_ack(i2c_missed_ack),
		
		.i2c_data_in_valid(i2c_data_in_valid),
		.i2c_data_in_ready(i2c_data_in_ready_read),
		.i2c_data_in_last(i2c_data_in_last),
		
		.i2c_data_out(i2c_data_out_read),
		.i2c_data_in(i2c_data_in),
		.i2c_dev_address(i2c_dev_address_read),
		
		.i2c_cmd_start(i2c_cmd_start_read),
		.i2c_cmd_write(i2c_cmd_write_read),
		.i2c_cmd_read(i2c_cmd_read_read),
		.i2c_cmd_stop(i2c_cmd_stop_read),
		.i2c_cmd_valid(i2c_cmd_valid_read),
		.i2c_data_out_valid(i2c_data_out_valid_read),
		.state_out(state_out_read),
		
		.data_out(read_data_out),
		.fifo_read_en(read_data_en),
		.fifo_empty(read_data_empty),
		.fifo_read_valid(read_data_valid),
		.fifo_underflow(read_data_underflow),
		
		.message_failure(message_failure_read)
	);
	
	i2c_write_reg write (
		.dev_address(dev_address),
		.reg_address(reg_address),
		.data(data),
		
		.clk(clock_27mhz),
		.reset(clean_button0),
		.start(1'b0),
		.done(i2c_write_done),
		
		.timer_exp(timer_exp),
		.timer_param(timer_param_write),
		.timer_start(timer_start_write),
		.timer_reset(timer_reset_write),
		
		.i2c_data_out_ready(i2c_data_out_ready),
		.i2c_cmd_ready(i2c_cmd_ready),
		.i2c_bus_busy(i2c_bus_busy),
		.i2c_bus_control(i2c_bus_control),
	   .i2c_bus_active(i2c_bus_active),
	   .i2c_missed_ack(i2c_missed_ack),
		
		.i2c_data_out(i2c_data_out_write),
		.i2c_dev_address(i2c_dev_address_write),
		
		.i2c_cmd_start(i2c_cmd_start_write),
		.i2c_cmd_write_multiple(i2c_cmd_write_multiple_write),
		.i2c_cmd_stop(i2c_cmd_stop_write),
		.i2c_cmd_valid(i2c_cmd_valid_write),
		
		.i2c_data_out_valid(i2c_data_out_valid_write),
		.i2c_data_out_last(i2c_data_out_last_write),
		.state_out(state_out_write),
		
		.message_failure(message_failure_write)
	);
	
	wire [7:0] data_in_write_multi;
	wire write_en_write_multi;
	wire full_write_multi;
	wire write_ack_write_multi;
	wire overflow_write_multi;
	wire test_write_multi_done;
	
	i2c_write_reg_multi write_multi (
		.dev_address(dev_address),
		.reg_address(reg_address),
		
		.clk(clock_27mhz),
		.reset(clean_button0),
		.start(test_write_multi_done),
		.done(i2c_write_multi_done),
		.byte_width(4'b0010),
		
		.timer_exp(timer_exp),
		.timer_param(timer_param_write_multi),
		.timer_start(timer_start_write_multi),
		.timer_reset(timer_reset_write_multi),
		
		.i2c_data_out_ready(i2c_data_out_ready),
		.i2c_cmd_ready(i2c_cmd_ready),
		.i2c_bus_busy(i2c_bus_busy),
		.i2c_bus_control(i2c_bus_control),
	   .i2c_bus_active(i2c_bus_active),
	   .i2c_missed_ack(i2c_missed_ack),
		
		.i2c_data_out(i2c_data_out_write_multi),
		.i2c_dev_address(i2c_dev_address_write_multi),
		
		.i2c_cmd_start(i2c_cmd_start_write_multi),
		.i2c_cmd_write_multiple(i2c_cmd_write_multiple_write_multi),
		.i2c_cmd_stop(i2c_cmd_stop_write_multi),
		.i2c_cmd_valid(i2c_cmd_valid_write_multi),
		
		.i2c_data_out_valid(i2c_data_out_valid_write_multi),
		.i2c_data_out_last(i2c_data_out_last_write_multi),
		.state_out(state_out_write_multi),
		
		.data(data_in_write_multi),
		.fifo_wr_en(write_en_write_multi),
		.fifo_full(full_write_multi),
		.fifo_write_ack(write_ack_write_multi),
		.fifo_overflow(overflow_write_multi),
		
		.message_failure(message_failure_write_multi)
	);
	
	test_write_multi test (
		.clk(clock_27mhz),
      .reset(clean_button0),
      .start(clk_200Hz),
      .done(test_write_multi_done),
	 
      .data_out(data_in_write_multi),
	   .write_en(write_en_write_multi),
	   .full(full_write_multi),
	   .write_ack(write_ack_write_multi),
	   .overflow(overflow_write_multi)
	);
	
	wire [6:0] cmd_address;
	wire cmd_start;
	wire cmd_read;
	wire cmd_write;
	wire cmd_write_multiple;
	wire cmd_stop;
	wire cmd_valid;
	
	wire [7:0] data_in;
	wire data_in_valid;
	wire data_in_last;
	wire data_out_ready;
	
	mux4 #(.SIGNAL_WIDTH(7)) m_cmd_address (
		.sel(fnc_sel),
		.signal0(7'b0000000),
		.signal1(i2c_dev_address_read),
		.signal2(i2c_dev_address_write),
		.signal3(i2c_dev_address_write_multi),
		.out(cmd_address)
	);
	
	mux4 m_cmd_start (
		.sel(fnc_sel),
		.signal0(1'b0),
		.signal1(i2c_cmd_start_read),
		.signal2(i2c_cmd_start_write),
		.signal3(i2c_cmd_start_write_multi),
		.out(cmd_start)
	);
	
	mux4 m_cmd_read (
		.sel(fnc_sel),
		.signal0(1'b0),
		.signal1(i2c_cmd_read_read),
		.signal2(1'b0),
		.signal3(1'b0),
		.out(cmd_read)
	);
	
	mux4 m_cmd_write (
		.sel(fnc_sel),
		.signal0(1'b0),
		.signal1(i2c_cmd_write_read),
		.signal2(1'b0),
		.signal3(1'b0),
		.out(cmd_write)
	);
	
	mux4 m_cmd_write_multiple (
		.sel(fnc_sel),
		.signal0(1'b0),
		.signal1(1'b0),
		.signal2(i2c_cmd_write_multiple_write),
		.signal3(i2c_cmd_write_multiple_write_multi),
		.out(cmd_write_multiple)
	);
	
	mux4 m_cmd_stop (
		.sel(fnc_sel),
		.signal0(1'b0),
		.signal1(i2c_cmd_stop_read),
		.signal2(i2c_cmd_stop_write),
		.signal3(i2c_cmd_stop_write_multi),
		.out(cmd_stop)
	);
	
	mux4 m_cmd_valid (
		.sel(fnc_sel),
		.signal0(1'b0),
		.signal1(i2c_cmd_valid_read),
		.signal2(i2c_cmd_valid_write),
		.signal3(i2c_cmd_valid_write_multi),
		.out(cmd_valid)
	);
	
	
	mux4 #(.SIGNAL_WIDTH(8)) m_data_in (
		.sel(fnc_sel),
		.signal0(8'h00),
		.signal1(i2c_data_out_read),
		.signal2(i2c_data_out_write),
		.signal3(i2c_data_out_write_multi),
		.out(data_in)
	);
	
	mux4 m_data_in_valid (
		.sel(fnc_sel),
		.signal0(1'b0),
		.signal1(i2c_data_out_valid_read),
		.signal2(i2c_data_out_valid_write),
		.signal3(i2c_data_out_valid_write_multi),
		.out(data_in_valid)
	);
	
	mux4 m_data_in_last (
		.sel(fnc_sel),
		.signal0(1'b0),
		.signal1(1'b0),
		.signal2(i2c_data_out_last_write),
		.signal3(i2c_data_out_last_write_multi),
		.out(data_in_last)
	);
	
	mux4 m_data_out_ready (
		.sel(fnc_sel),
		.signal0(1'b0),
		.signal1(i2c_data_in_ready_read),
		.signal2(1'b0),
		.signal3(1'b0),
		.out(data_out_ready)
	);
	
	wire cmd_ready;
	wire [15:0] prescale;
	wire stop_on_idle;
	
	wire sda_i;
	wire sda_o;
	wire scl_i;
	wire scl_o;
	wire sda_t;
	wire scl_t;
	
	i2c_master master (
		.clk(clock_27mhz),
		.rst(clean_button0),
		.cmd_address(cmd_address),
		.cmd_start(cmd_start),		            
		.cmd_read(cmd_read),		            
		.cmd_write(cmd_write),	          
      .cmd_write_multiple(cmd_write_multiple), 
		.cmd_stop(cmd_stop),		          	
      .cmd_valid(cmd_valid),		  
		.cmd_ready(cmd_ready),

		//for writing
      .data_in(data_in),
		.data_in_valid(data_in_valid),
      .data_in_ready(i2c_data_out_ready),
      .data_in_last(data_in_last),

		//for reading
      .data_out(i2c_data_in),
		.data_out_valid(i2c_data_in_valid),
		.data_out_ready(data_out_ready),
		.data_out_last(i2c_data_in_last),

      .scl_i(scl_i),
      .scl_o(scl_o),
      .scl_t(scl_t),
      .sda_i(sda_i),
	   .sda_o(sda_o),
      .sda_t(sda_t),

      .busy(i2c_bus_busy),
      .bus_control(i2c_bus_control),
      .bus_active(i2c_bus_active),
      .missed_ack(i2c_missed_ack), 

      .prescale(prescale),
      .stop_on_idle(stop_on_idle)
	);
	
	assign reg_address = 8'hC0; // 8'b1111_1111
	assign dev_address = 7'h29; // 8'b0101_0010
	assign data = 8'hFF; //8'b0111_0011
	assign byte_width = 4'b0001;
	
	assign prescale = 16'h80;
	assign stop_on_idle = 1'b1;
	
	assign user3[4] = cmd_stop;
	assign analyzer3_clock = clock_27mhz;
	assign analyzer3_data = {9'd0, state_out_read, user3[1], user3[0]};
	assign led = {4'hF, ~state_out_read};
	
	assign scl_i = user3[0];
	assign user3[0] = scl_t ? 1'bz : scl_o;
	assign sda_i = user3[1];
	assign user3[1] = sda_t ? 1'bz : sda_o;
	
	assign message_failure = message_failure_write | message_failure_read | message_failure_write_multi;
			    
endmodule
