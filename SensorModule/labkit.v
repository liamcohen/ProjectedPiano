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
	
	//Buttons for initiating i2c communications -- for testing (plus overall system reset)
	wire reset_button;
	wire clean_button1;
	wire clean_button2;
	
	//sel for i2c_write, i2c_read, or i2c_write_multi 
	//2'b00: none
	//2'b01: read
	//2'b10: write
	//2'b11: write_multi
	wire [1:0] fnc_sel;
	
	//debouncers to clean up button presses
	debounce db_button0 (
		.clock(clock_27mhz),
		.reset(switch[0]),
		.bouncey(~button0),
		.steady(reset_button)
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
	
	//pulse signals of varying lengths
	wire clk_1000Hz;
	wire clk_200Hz;
	
	//signals for connecting to timer module
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
	
	//muxes to timer module
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
	
	//declaration of timer module -- only one per i2c_xxx module to minimize hardware
	Timer timer (
		.clk(clock_27mhz),
		.reset(timer_reset),
		.startTimer(timer_start),
		.value(timer_param),
		.enable(clk_1000Hz),
		.time_expired(timer_exp)
	);
	
	//divider modules for producing single clock high pulses of varying frequency
	divider div (
		.clk(clock_27mhz),
		.reset(timer_start), //synchronized with timer_start signal
		.clk_1000Hz(clk_1000Hz)
	);
	
	divider #(130000) div2 (
		.clk(clock_27mhz),
		.reset(reset_button), //always on
		.clk_1000Hz(clk_200Hz)
	);
	
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	//
	// Signals for i2c_write, i2c_read, and i2c_write_multi modules
	// Way to read signal names:
	// lowercase --> signal type (or signal name)
	// uppercase --> signal origin (i.e., i2c_read, i2c_write, i2c_write_multi modules)
	// i2c_ prefix --> signal is between i2c_write, i2c_write, or i2c_write_multi, and the i2c master
	// 
	/////////////////////////////////////////////////////////////////////////////////////////////
	
	//signals essential to i2c module communication
	wire [6:0] dev_address;
	wire [7:0] reg_address;
   wire [7:0] data;
	wire [3:0] n_bytes;

	//FSM output status signals
	wire i2c_done_WRITE;
	wire i2c_done_READ;
	wire i2c_done_WRITEMULTI;
	
	wire message_failure_READ;
	wire message_failure_WRITE;
	wire message_failure_WRITEMULTI;
	wire message_failure; //system failure -- or of all three modules
	
	//FSM input signals
	wire i2c_data_out_ready;
	wire i2c_cmd_ready;
	wire i2c_bus_busy;
	wire i2c_bus_control;
	wire i2c_bus_active;
	wire i2c_missed_ack;
	
	//single byte parallel outputs to i2c master module
	wire [7:0] i2c_data_out_READ;
	wire [7:0] i2c_data_out_WRITE;
	wire [7:0] i2c_data_out_WRITEMULTI;
	
	//single byte parallel input to i2c_read module from i2c master
	wire [7:0] i2c_data_in;
	
	//output of device address to i2c master from i2c_xxxx modules
	//haven't decided yet if device addresses are going to be static
	//so I don't know if these signals are superfluous yet or not
	wire [6:0] i2c_dev_address_WRITE;
	wire [6:0] i2c_dev_address_READ;
	wire [6:0] i2c_dev_address_WRITEMULTI;
	
	//controls to access i2c_read FIFO
	wire [7:0] read_data_out;
	wire read_data_en;
	wire read_data_empty;
	wire read_data_valid;
	wire read_data_underflow;
	
	//controls for access to i2c_write_multi FIFO
	wire [7:0] data_in_WRITEMULTI;
	wire write_en_WRITEMULTI;
	wire ext_reset_WRITEMULTI;
	wire full_WRITEMULTI;
	wire write_ack_WRITEMULTI;
	wire overflow_WRITEMULTI;
	wire test_write_WRITEMULTI;
	
	//FSM input/output for i2c_read
	wire i2c_data_in_valid;
	wire i2c_data_in_ready;
	wire i2c_data_in_last;
	
	//cmd control for i2c_master
	wire i2c_cmd_start_READ;
	wire i2c_cmd_start_WRITE;
	wire i2c_cmd_start_WRITEMULTI;
	
	wire i2c_cmd_write_multiple_WRITE;
	wire i2c_cmd_write_multiple_WRITEMULTI;
	
	wire i2c_cmd_write_READ;
	
	wire i2c_cmd_read_READ;
	
	wire i2c_cmd_stop_READ;
	wire i2c_cmd_stop_WRITE;
	wire i2c_cmd_stop_WRITEMULTI;
	
	wire i2c_cmd_valid_READ;
	wire i2c_cmd_valid_WRITE;
	wire i2c_cmd_valid_WRITEMULTI;
	
	//FSM output to i2c_master for controlling byte-wide data output
	wire i2c_data_out_valid_READ;
	wire i2c_data_out_valid_WRITE;
	wire i2c_data_out_valid_WRITEMULTI;
	
	wire i2c_data_out_last_WRITE;
	wire i2c_data_out_last_WRITEMULTI;
	
	wire [3:0] state_out_READ;
	wire [3:0] state_out_WRITE;
	wire [3:0] state_out_WRITEMULTI;
	
	//FSM inputs controled by VL53L0x Module that control start of I2C FSMs
	wire write_start;
   wire write_done;
	
   wire write_multi_start;
   wire write_multi_done;
   
	wire read_start;
   wire read_done;
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	//
	// DECLARATION OF MAIN FSMs: read, write, and write_multi
	//
	// These modules have the main task of controlling the i2c master and providing it data
	// at the correct time such that one can read or write some number of bytes from the slave
	// device. 
	//
	// i2c_write: writes one byte of data to the slave at a specified byte register
	// i2c_read: incrementally reads bytes into a FIFO from slave starting at a specified register - 
	// 			 resets FIFO upon start of transmission
	// i2c_write_multi: incrementally writes multiple bytes from a FIFO to the slave starting at 
	//						  a specified register - resets FIFO at the end of transmission
	// 
	/////////////////////////////////////////////////////////////////////////////////////////////
	
	i2c_read_reg read (
		.dev_address(dev_address),
		.reg_address(reg_address),
		.byte_width(n_bytes),
		
		.clk(clock_27mhz),
		.reset(reset_button),
		.start(read_start),
		.done(read_done),
		
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
		.i2c_data_in_ready(i2c_data_in_ready),
		.i2c_data_in_last(i2c_data_in_last),
		
		.i2c_data_out(i2c_data_out_READ),
		.i2c_data_in(i2c_data_in),
		.i2c_dev_address(i2c_dev_address_READ),
		
		.i2c_cmd_start(i2c_cmd_start_READ),
		.i2c_cmd_write(i2c_cmd_write_READ),
		.i2c_cmd_read(i2c_cmd_read_READ),
		.i2c_cmd_stop(i2c_cmd_stop_READ),
		.i2c_cmd_valid(i2c_cmd_valid_READ),
		.i2c_data_out_valid(i2c_data_out_valid_READ),
		
		.data_out(read_data_out),
		.fifo_read_en(read_data_en),
		.fifo_empty(read_data_empty),
		.fifo_read_valid(read_data_valid),
		.fifo_underflow(read_data_underflow),
		
		.message_failure(message_failure_READ)
	);
	
	i2c_write_reg write (
		.dev_address(dev_address),
		.reg_address(reg_address),
		.data(data),
		
		.clk(clock_27mhz),
		.reset(reset_button),
		.start(write_start),
		.done(write_done),
		
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
		
		.i2c_data_out(i2c_data_out_WRITE),
		.i2c_dev_address(i2c_dev_address_WRITE),
		
		.i2c_cmd_start(i2c_cmd_start_WRITE),
		.i2c_cmd_write_multiple(i2c_cmd_write_multiple_WRITE),
		.i2c_cmd_stop(i2c_cmd_stop_WRITE),
		.i2c_cmd_valid(i2c_cmd_valid_WRITE),
		
		.i2c_data_out_valid(i2c_data_out_valid_WRITE),
		.i2c_data_out_last(i2c_data_out_last_WRITE),
		.state_out(state_out_WRITE),
		
		.message_failure(message_failure_WRITE)
	);
	
	i2c_write_reg_multi write_multi (
		.dev_address(dev_address),
		.reg_address(reg_address),
		
		.clk(clock_27mhz),
		.reset(reset_button),
		.start(write_multi_start),
		.done(write_multi_done),
		.byte_width(n_bytes),
		
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
		
		.i2c_data_out(i2c_data_out_WRITEMULTI),
		.i2c_dev_address(i2c_dev_address_WRITEMULTI),
		
		.i2c_cmd_start(i2c_cmd_start_WRITEMULTI),
		.i2c_cmd_write_multiple(i2c_cmd_write_multiple_WRITEMULTI),
		.i2c_cmd_stop(i2c_cmd_stop_WRITEMULTI),
		.i2c_cmd_valid(i2c_cmd_valid_WRITEMULTI),
		
		.i2c_data_out_valid(i2c_data_out_valid_WRITEMULTI),
		.i2c_data_out_last(i2c_data_out_last_WRITEMULTI),
		.state_out(state_out_WRITEMULTI),
		
		.data(data_in_WRITEMULTI),
		.fifo_wr_en(write_en_WRITEMULTI),
		.fifo_ext_reset(ext_reset_WRITEMULTI),
		.fifo_full(full_WRITEMULTI),
		.fifo_write_ack(write_ack_WRITEMULTI),
		.fifo_overflow(overflow_WRITEMULTI),
		
		.message_failure(message_failure_WRITEMULTI)
	);
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	//
	// DECLARATION OF SIGNALS AND SIGNAL MUXES FOR I2C MASTER MODULE
	//
	// One will notice that as defined, signals come out of the FSMs
	// meaning that signals going into the i2c master should have opposite parity i.e., out/in
	// not out/out or in/in.
	// 
	/////////////////////////////////////////////////////////////////////////////////////////////
	
	wire [6:0] i2c_dev_address;
	wire i2c_cmd_start;
	wire i2c_cmd_read;
	wire i2c_cmd_write;
	wire i2c_cmd_write_multiple;
	wire i2c_cmd_stop;
	wire i2c_cmd_valid;
	
	wire [7:0] i2c_data_out;
	wire i2c_data_out_valid;
	wire i2c_data_out_last;
	
	mux4 #(.SIGNAL_WIDTH(7)) m_i2c_dev_address (
		.sel(fnc_sel),
		.signal0(7'b0000000),
		.signal1(i2c_dev_address_READ),
		.signal2(i2c_dev_address_WRITE),
		.signal3(i2c_dev_address_WRITEMULTI),
		.out(i2c_dev_address)
	);
	
	mux4 m_i2c_cmd_start (
		.sel(fnc_sel),
		.signal0(1'b0),
		.signal1(i2c_cmd_start_READ),
		.signal2(i2c_cmd_start_WRITE),
		.signal3(i2c_cmd_start_WRITEMULTI),
		.out(i2c_cmd_start)
	);
	
	mux4 m_i2c_cmd_read (
		.sel(fnc_sel),
		.signal0(1'b0),
		.signal1(i2c_cmd_read_READ),
		.signal2(1'b0),
		.signal3(1'b0),
		.out(i2c_cmd_read)
	);
	
	mux4 m_i2c_cmd_write (
		.sel(fnc_sel),
		.signal0(1'b0),
		.signal1(i2c_cmd_write_READ),
		.signal2(1'b0),
		.signal3(1'b0),
		.out(i2c_cmd_write)
	);
	
	mux4 m_i2c_cmd_write_multiple (
		.sel(fnc_sel),
		.signal0(1'b0),
		.signal1(1'b0),
		.signal2(i2c_cmd_write_multiple_WRITE),
		.signal3(i2c_cmd_write_multiple_WRITEMULTI),
		.out(i2c_cmd_write_multiple)
	);
	
	mux4 m_i2c_cmd_stop (
		.sel(fnc_sel),
		.signal0(1'b0),
		.signal1(i2c_cmd_stop_READ),
		.signal2(i2c_cmd_stop_WRITE),
		.signal3(i2c_cmd_stop_WRITEMULTI),
		.out(i2c_cmd_stop)
	);
	
	mux4 m_i2c_cmd_valid (
		.sel(fnc_sel),
		.signal0(1'b0),
		.signal1(i2c_cmd_valid_READ),
		.signal2(i2c_cmd_valid_WRITE),
		.signal3(i2c_cmd_valid_WRITEMULTI),
		.out(i2c_cmd_valid)
	);
	
	
	mux4 #(.SIGNAL_WIDTH(8)) m_i2c_data_out (
		.sel(fnc_sel),
		.signal0(8'h00),
		.signal1(i2c_data_out_READ),
		.signal2(i2c_data_out_WRITE),
		.signal3(i2c_data_out_WRITEMULTI),
		.out(i2c_data_out)
	);
	
	mux4 m_i2c_data_out_valid (
		.sel(fnc_sel),
		.signal0(1'b0),
		.signal1(i2c_data_out_valid_READ),
		.signal2(i2c_data_out_valid_WRITE),
		.signal3(i2c_data_out_valid_WRITEMULTI),
		.out(i2c_data_out_valid)
	);
	
	mux4 m_i2c_data_out_last (
		.sel(fnc_sel),
		.signal0(1'b0),
		.signal1(1'b0),
		.signal2(i2c_data_out_last_WRITE),
		.signal3(i2c_data_out_last_WRITEMULTI),
		.out(i2c_data_out_last)
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
		.rst(reset_button),
		.cmd_address(i2c_dev_address),
		.cmd_start(i2c_cmd_start),		            
		.cmd_read(i2c_cmd_read),		            
		.cmd_write(i2c_cmd_write),	          
      .cmd_write_multiple(i2c_cmd_write_multiple), 
		.cmd_stop(i2c_cmd_stop),		          	
      .cmd_valid(i2c_cmd_valid),		  
		.cmd_ready(i2c_cmd_ready),

		//for writing
      .data_in(i2c_data_out),
		.data_in_valid(i2c_data_out_valid),
      .data_in_ready(i2c_data_out_ready),
      .data_in_last(i2c_data_out_last),

		//for reading
      .data_out(i2c_data_in),
		.data_out_valid(i2c_data_in_valid),
		.data_out_ready(i2c_data_in_ready),
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
	
	//declaration of total failure logic
	assign message_failure = message_failure_WRITE | message_failure_READ | message_failure_WRITEMULTI;
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	//
	// Signals for initialization for VL53L0X
	// 
	/////////////////////////////////////////////////////////////////////////////////////////////
	
	wire clk_10Hz;
	
	wire timer_exp_init;
	wire timer_start_init;
	wire [3:0] timer_param_init;
	wire timer_reset_init;
	
	//declaration of timer module -- 100ms timer for counting VL53L0x timeout
	Timer timer2 (
		.clk(clock_27mhz),
		.reset(timer_reset_init),
		.startTimer(timer_start_init),
		.value(timer_param_init),
		.enable(clk_10Hz),
		.time_expired(timer_exp_init)
	);
	
	//divider modules for producing single clock high pulses of varying frequency
	
	divider #(2700000) div3 ( //pulse every 100ms
		.clk(clock_27mhz),
		.reset(timer_start_init),
		.clk_1000Hz(clk_10Hz)
	);
	
	wire init_done;
	
	wire [7:0] ram_addr;
	wire [7:0] ram_data_out;
	wire [7:0] ram_data_in;
	wire ram_wr_en;
	
	wire init_error;
	
	wire [3:0] instruction_count_debug;
	
	VL53L0X_INIT sensor_init(
		.reset(reset_button),
		.clk(clock_27mhz),
		.start(clk_10Hz),
		.done(init_done),
		.comm_error(message_failure),
		
		.write_start(write_start),
		.write_done(write_done),
		.write_multi_start(write_multi_start),
		.write_multi_done(write_multi_done),
		.read_start(read_start),
		.read_done(read_done),
		
		.timer_exp(timer_exp_init),
		.timer_start(timer_start_init),
		.timer_param(timer_param_init),
		.timer_reset(timer_reset_init),
		
		.reg_address_out(reg_address),
		.data_out(data),
		.n_bytes(n_bytes),
		
		.fnc_sel(fnc_sel),
		
		.fifo_data_out(data_in_WRITEMULTI),
		.fifo_wr_en(write_en_WRITEMULTI),
	   .fifo_ext_reset(ext_reset_WRITEMULTI),
	   .fifo_full(full_WRITEMULTI),
	   .fifo_write_ack(write_ack_WRITEMULTI),
	   .fifo_overflow(test_write_WRITEMULTI),
		
		.fifo_data_in(read_data_out),
	   .fifo_read_en(read_data_en),
	   .fifo_empty(read_data_empty),
	   .fifo_read_valid(read_data_valid),
	   .fifo_underflow(read_data_underflow),
		
		.ram_addr(ram_addr),
	   .ram_data_out(ram_data_out),
	   .ram_data_in(ram_data_in),
	   .ram_wr_en(ram_wr_en),
		
		.init_error(init_error), 
		
		.instruction_count_debug(instruction_count_debug)
	);
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	//
	// Gobal Ram for data storage
	// 
	/////////////////////////////////////////////////////////////////////////////////////////////
	
	RAM ram(
		.addra(ram_addr),
		.dina(ram_data_out),
		.douta(ram_data_in),
		.wea(ram_wr_en),
		.clka(clock_27mhz)
	);
	
	//assigned constants for testing modules
	//assign reg_address = 8'hC0; // 8'b1111_1111
	assign dev_address = 7'h29; // 8'b0101_0010
	//assign data = 8'hFF; //8'b0111_0011
	//assign n_bytes = 4'b0001;
	
	assign prescale = 16'h80;
	assign stop_on_idle = 1'b1;
	
	//logic analyzer outputs for debugging
	assign user3[4] = read_data_empty;
	assign analyzer3_clock = clock_27mhz;
	assign analyzer3_data = 16'b0;
	//assign analyzer3_data = {fifo_out_debug, user3[1], user3[0], fifo_underflow_debug, state_out_WRITEMULTI, test_done_WRITEMULTI};
	//assign analyzer3_data = {i2c_data_out_WRITE, user3[1], user3[0], 1'b0, state_out_WRITE, clk_200Hz};
	assign led = {4'hF, ~instruction_count_debug};
	
	//physical pin delegation for i2c communication to slave
	assign scl_i = user3[0];
	assign user3[0] = scl_t ? 1'bz : scl_o;
	assign sda_i = user3[1];
	assign user3[1] = sda_t ? 1'bz : sda_o;
			    
endmodule
