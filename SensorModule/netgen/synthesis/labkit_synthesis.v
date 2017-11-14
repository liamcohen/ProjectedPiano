////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2008 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: K.39
//  \   \         Application: netgen
//  /   /         Filename: labkit_synthesis.v
// /___/   /\     Timestamp: Tue Nov 14 17:07:51 2017
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -intstyle ise -insert_glbl true -w -dir netgen/synthesis -ofmt verilog -sim labkit.ngc labkit_synthesis.v 
// Device	: xc2v6000-4-bf957
// Input file	: labkit.ngc
// Output file	: /afs/athena.mit.edu/user/l/c/lc2017/Desktop/6.111_Final_Project/ProjectedPiano/SensorModule/netgen/synthesis/labkit_synthesis.v
// # of Modules	: 1
// Design Name	: labkit
// Xilinx        : /afs/csail.mit.edu/proj/redsocs/Xilinx10.1/ISE
//             
// Purpose:    
//     This verilog netlist is a verification model and uses simulation 
//     primitives which may not represent the true implementation of the 
//     device, however the netlist is functionally correct and should not 
//     be modified. This file cannot be synthesized and should only be used 
//     with supported simulation tools.
//             
// Reference:  
//     Development System Reference Guide, Chapter 23 and Synthesis and Simulation Design Guide, Chapter 6
//             
////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns/1 ps

module labkit (
  tv_in_i2c_data, ram0_cen_b, tv_in_clock, button0, button1, button2, button3, tv_out_subcar_reset, tv_out_pal_ntsc, ram1_adv_ld, ram0_clk, 
vga_out_hsync, clock1, clock2, flash_ce_b, tv_in_aef, ram0_oe_b, tv_in_aff, analyzer1_clock, ram1_cen_b, ram1_oe_b, systemace_irq, clock_feedback_in, 
disp_data_in, ram0_adv_ld, disp_rs, ram0_ce_b, clock_27mhz, button_enter, ac97_sdata_out, analyzer2_clock, keyboard_clock, ram1_ce_b, disp_clock, 
systemace_oe_b, tv_out_blank_b, rs232_rts, flash_sts, rs232_rxd, mouse_data, rs232_cts, tv_out_reset_b, flash_byte_b, audio_reset_b, tv_in_fifo_read, 
tv_out_clock, tv_in_reset_b, analyzer3_clock, systemace_ce_b, rs232_txd, flash_reset_b, ac97_synch, button_left, flash_we_b, disp_ce_b, 
tv_in_fifo_clock, vga_out_vsync, tv_in_i2c_clock, tv_in_data_valid, tv_in_hff, tv_out_i2c_clock, tv_out_hsync_b, analyzer4_clock, ram1_clk, 
vga_out_sync_b, disp_data_out, tv_in_line_clock1, tv_in_line_clock2, vga_out_pixel_clock, keyboard_data, beep, ram0_we_b, ac97_sdata_in, ram1_we_b, 
clock_feedback_out, systemace_mpbrdy, button_right, button_down, mouse_clock, tv_in_iso, ac97_bit_clock, disp_reset_b, systemace_we_b, vga_out_blank_b
, button_up, tv_out_i2c_data, disp_blank, flash_oe_b, tv_out_vsync_b, user3, daughtercard, flash_data, user2, user4, user1, ram0_data, ram1_data, 
systemace_data, systemace_address, vga_out_red, tv_out_ycrcb, vga_out_blue, ram1_address, analyzer1_data, analyzer2_data, analyzer3_data, 
analyzer4_data, ram0_bwe_b, flash_address, ram1_bwe_b, vga_out_green, led, ram0_address, switch, tv_in_ycrcb
);
  inout tv_in_i2c_data;
  output ram0_cen_b;
  output tv_in_clock;
  input button0;
  input button1;
  input button2;
  input button3;
  output tv_out_subcar_reset;
  output tv_out_pal_ntsc;
  output ram1_adv_ld;
  output ram0_clk;
  output vga_out_hsync;
  input clock1;
  input clock2;
  output flash_ce_b;
  input tv_in_aef;
  output ram0_oe_b;
  input tv_in_aff;
  output analyzer1_clock;
  output ram1_cen_b;
  output ram1_oe_b;
  input systemace_irq;
  input clock_feedback_in;
  input disp_data_in;
  output ram0_adv_ld;
  output disp_rs;
  output ram0_ce_b;
  input clock_27mhz;
  input button_enter;
  output ac97_sdata_out;
  output analyzer2_clock;
  input keyboard_clock;
  output ram1_ce_b;
  output disp_clock;
  output systemace_oe_b;
  output tv_out_blank_b;
  output rs232_rts;
  input flash_sts;
  input rs232_rxd;
  input mouse_data;
  input rs232_cts;
  output tv_out_reset_b;
  output flash_byte_b;
  output audio_reset_b;
  output tv_in_fifo_read;
  output tv_out_clock;
  output tv_in_reset_b;
  output analyzer3_clock;
  output systemace_ce_b;
  output rs232_txd;
  output flash_reset_b;
  output ac97_synch;
  input button_left;
  output flash_we_b;
  output disp_ce_b;
  output tv_in_fifo_clock;
  output vga_out_vsync;
  output tv_in_i2c_clock;
  input tv_in_data_valid;
  input tv_in_hff;
  output tv_out_i2c_clock;
  output tv_out_hsync_b;
  output analyzer4_clock;
  output ram1_clk;
  output vga_out_sync_b;
  output disp_data_out;
  input tv_in_line_clock1;
  input tv_in_line_clock2;
  output vga_out_pixel_clock;
  input keyboard_data;
  output beep;
  output ram0_we_b;
  input ac97_sdata_in;
  output ram1_we_b;
  output clock_feedback_out;
  input systemace_mpbrdy;
  input button_right;
  input button_down;
  input mouse_clock;
  output tv_in_iso;
  input ac97_bit_clock;
  output disp_reset_b;
  output systemace_we_b;
  output vga_out_blank_b;
  input button_up;
  output tv_out_i2c_data;
  output disp_blank;
  output flash_oe_b;
  output tv_out_vsync_b;
  inout [31 : 0] user3;
  inout [43 : 0] daughtercard;
  inout [15 : 0] flash_data;
  inout [31 : 0] user2;
  inout [31 : 0] user4;
  inout [31 : 0] user1;
  inout [35 : 0] ram0_data;
  inout [35 : 0] ram1_data;
  inout [15 : 0] systemace_data;
  output [6 : 0] systemace_address;
  output [7 : 0] vga_out_red;
  output [9 : 0] tv_out_ycrcb;
  output [7 : 0] vga_out_blue;
  output [18 : 0] ram1_address;
  output [15 : 0] analyzer1_data;
  output [15 : 0] analyzer2_data;
  output [15 : 0] analyzer3_data;
  output [15 : 0] analyzer4_data;
  output [3 : 0] ram0_bwe_b;
  output [23 : 0] flash_address;
  output [3 : 0] ram1_bwe_b;
  output [7 : 0] vga_out_green;
  output [7 : 0] led;
  output [18 : 0] ram0_address;
  input [7 : 0] switch;
  input [19 : 0] tv_in_ycrcb;
  wire N0;
  wire N11;
  wire N13;
  wire N15;
  wire N17;
  wire N18;
  wire N2;
  wire N22;
  wire N26;
  wire N27;
  wire N30;
  wire N32;
  wire N36;
  wire N40;
  wire N41;
  wire N43;
  wire N45;
  wire N49;
  wire N51;
  wire N53;
  wire N57;
  wire N58;
  wire N60;
  wire N62;
  wire N63;
  wire N64;
  wire N66;
  wire N68;
  wire N69;
  wire N70;
  wire N71;
  wire N72;
  wire N73;
  wire N74;
  wire N75;
  wire N76;
  wire N77;
  wire N78;
  wire N79;
  wire N80;
  wire N81;
  wire analyzer1_data_0_OBUF_79;
  wire analyzer4_clock_OBUF_115;
  wire button0_IBUF_135;
  wire button1_IBUF_137;
  wire clock_27mhz_BUFGP_139;
  wire \db_button0/Mcount_count_cy<10>_rt_143 ;
  wire \db_button0/Mcount_count_cy<11>_rt_145 ;
  wire \db_button0/Mcount_count_cy<12>_rt_147 ;
  wire \db_button0/Mcount_count_cy<13>_rt_149 ;
  wire \db_button0/Mcount_count_cy<14>_rt_151 ;
  wire \db_button0/Mcount_count_cy<15>_rt_153 ;
  wire \db_button0/Mcount_count_cy<16>_rt_155 ;
  wire \db_button0/Mcount_count_cy<17>_rt_157 ;
  wire \db_button0/Mcount_count_cy<1>_rt_159 ;
  wire \db_button0/Mcount_count_cy<2>_rt_161 ;
  wire \db_button0/Mcount_count_cy<3>_rt_163 ;
  wire \db_button0/Mcount_count_cy<4>_rt_165 ;
  wire \db_button0/Mcount_count_cy<5>_rt_167 ;
  wire \db_button0/Mcount_count_cy<6>_rt_169 ;
  wire \db_button0/Mcount_count_cy<7>_rt_171 ;
  wire \db_button0/Mcount_count_cy<8>_rt_173 ;
  wire \db_button0/Mcount_count_cy<9>_rt_175 ;
  wire \db_button0/Mcount_count_xor<18>_rt_177 ;
  wire \db_button0/count_cmp_eq0000 ;
  wire \db_button0/count_not0001 ;
  wire \db_button0/count_or0000 ;
  wire \db_button0/old_209 ;
  wire \db_button0/steady_reg_210 ;
  wire \db_button0/steady_reg_mux0000 ;
  wire \db_button0/steady_reg_not0001 ;
  wire db_button0_not0000;
  wire \master/Mcompar_bus_control_next_cmp_gt0000_lut<4>1 ;
  wire \master/Msub_delay_next_addsub0000_cy<0>_rt_270 ;
  wire \master/N0 ;
  wire \master/N14 ;
  wire \master/N15 ;
  wire \master/N23 ;
  wire \master/N25 ;
  wire \master/N3 ;
  wire \master/N4 ;
  wire \master/N9 ;
  wire \master/addr_reg[0] ;
  wire \master/addr_reg[3] ;
  wire \master/addr_reg[5] ;
  wire \master/addr_reg_mux0000[0] ;
  wire \master/addr_reg_mux0000[3] ;
  wire \master/addr_reg_mux0000[5] ;
  wire \master/bit_count_reg_mux0000<0>110_320 ;
  wire \master/bit_count_reg_mux0000<0>126_321 ;
  wire \master/bit_count_reg_mux0000<0>135_322 ;
  wire \master/bit_count_reg_mux0000<0>15_323 ;
  wire \master/bit_count_reg_mux0000<3>11_327 ;
  wire \master/bit_count_reg_mux0000<3>21_328 ;
  wire \master/bit_count_reg_mux0000<3>3_329 ;
  wire \master/bit_count_reg_mux0000<3>34_330 ;
  wire \master/bus_active_reg_331 ;
  wire \master/cmd_ready_next ;
  wire \master/cmd_ready_next_and0000 ;
  wire \master/cmd_ready_reg_334 ;
  wire \master/data_in_ready_next ;
  wire \master/data_in_ready_reg_336 ;
  wire \master/delay_next[0] ;
  wire \master/delay_next[10] ;
  wire \master/delay_next[11] ;
  wire \master/delay_next[12] ;
  wire \master/delay_next[13] ;
  wire \master/delay_next[14] ;
  wire \master/delay_next[15] ;
  wire \master/delay_next[16] ;
  wire \master/delay_next[1] ;
  wire \master/delay_next[2] ;
  wire \master/delay_next[3] ;
  wire \master/delay_next[4] ;
  wire \master/delay_next[5] ;
  wire \master/delay_next[6] ;
  wire \master/delay_next<7>11_367 ;
  wire \master/delay_next<7>114_368 ;
  wire \master/delay_next<7>118_369 ;
  wire \master/delay_next<7>21_370 ;
  wire \master/delay_next<7>24_371 ;
  wire \master/delay_next<7>25_372 ;
  wire \master/delay_next<7>33_373 ;
  wire \master/delay_next<7>80 ;
  wire \master/delay_next[8] ;
  wire \master/delay_next<8>1_376 ;
  wire \master/delay_next<8>125_377 ;
  wire \master/delay_next<8>130 ;
  wire \master/delay_next<8>16_379 ;
  wire \master/delay_next<8>2_380 ;
  wire \master/delay_next[9] ;
  wire \master/delay_scl_next15_416 ;
  wire \master/delay_scl_next19 ;
  wire \master/delay_scl_reg_418 ;
  wire \master/last_sda_i_reg_419 ;
  wire \master/mode_stop_reg_420 ;
  wire \master/mode_stop_reg_mux0000 ;
  wire \master/phy_read_bit ;
  wire \master/phy_read_bit_or0000 ;
  wire \master/phy_start_bit ;
  wire \master/phy_state_next<0>11_425 ;
  wire \master/phy_state_next<10>11 ;
  wire \master/phy_state_next<11>11 ;
  wire \master/phy_state_next<12>11 ;
  wire \master/phy_state_next<13>1_429 ;
  wire \master/phy_state_next<14>11 ;
  wire \master/phy_state_next<15>11 ;
  wire \master/phy_state_next<1>13111 ;
  wire \master/phy_state_next<1>18_433 ;
  wire \master/phy_state_next<2>11_434 ;
  wire \master/phy_state_next<3>11 ;
  wire \master/phy_state_next<4>11_436 ;
  wire \master/phy_state_next<5>11 ;
  wire \master/phy_state_next<6>11_438 ;
  wire \master/phy_state_next<7>11 ;
  wire \master/phy_state_next<8>11 ;
  wire \master/phy_state_next<9>11_441 ;
  wire \master/phy_stop_bit_458 ;
  wire \master/phy_write_bit_459 ;
  wire \master/scl_i_reg_460 ;
  wire \master/scl_o_next ;
  wire \master/scl_o_next21_462 ;
  wire \master/scl_o_next26_463 ;
  wire \master/scl_o_next8_464 ;
  wire \master/scl_o_reg_465 ;
  wire \master/sda_i_reg_466 ;
  wire \master/sda_o_next ;
  wire \master/sda_o_next15_468 ;
  wire \master/sda_o_next155_469 ;
  wire \master/sda_o_next169_470 ;
  wire \master/sda_o_next2_471 ;
  wire \master/sda_o_next203_472 ;
  wire \master/sda_o_next219_473 ;
  wire \master/sda_o_next263_474 ;
  wire \master/sda_o_next267_475 ;
  wire \master/sda_o_next27_476 ;
  wire \master/sda_o_next40_477 ;
  wire \master/sda_o_next58_478 ;
  wire \master/sda_o_reg_479 ;
  wire \master/start_bit ;
  wire \master/state_reg_FSM_ClkEn_inv ;
  wire \master/state_reg_FSM_FFd1_482 ;
  wire \master/state_reg_FSM_FFd1-In_483 ;
  wire \master/state_reg_FSM_FFd10_484 ;
  wire \master/state_reg_FSM_FFd10-In ;
  wire \master/state_reg_FSM_FFd11_486 ;
  wire \master/state_reg_FSM_FFd11-In ;
  wire \master/state_reg_FSM_FFd12_488 ;
  wire \master/state_reg_FSM_FFd12-In ;
  wire \master/state_reg_FSM_FFd2_490 ;
  wire \master/state_reg_FSM_FFd2-In ;
  wire \master/state_reg_FSM_FFd3_492 ;
  wire \master/state_reg_FSM_FFd3-In_493 ;
  wire \master/state_reg_FSM_FFd4_494 ;
  wire \master/state_reg_FSM_FFd4-In ;
  wire \master/state_reg_FSM_FFd8_496 ;
  wire \master/state_reg_FSM_FFd8-In ;
  wire \master/state_reg_and0000 ;
  wire \master/state_reg_cmp_gt0000 ;
  wire \master/stop_bit ;
  wire switch_0_IBUF_563;
  wire switch_1_IBUF_564;
  wire [18 : 0] Result;
  wire [17 : 0] \db_button0/Mcount_count_cy ;
  wire [0 : 0] \db_button0/Mcount_count_lut ;
  wire [18 : 0] \db_button0/count ;
  wire [3 : 0] \db_button0/count_cmp_eq0000_wg_cy ;
  wire [4 : 0] \db_button0/count_cmp_eq0000_wg_lut ;
  wire [4 : 0] \master/Mcompar_bus_control_next_cmp_gt0000_cy ;
  wire [4 : 0] \master/Mcompar_bus_control_next_cmp_gt0000_lut ;
  wire [2 : 2] \master/Msub_bit_count_reg_addsub0000_cy ;
  wire [15 : 0] \master/Msub_delay_next_addsub0000_cy ;
  wire [15 : 1] \master/Msub_delay_next_addsub0000_lut ;
  wire [3 : 0] \master/bit_count_reg ;
  wire [3 : 0] \master/bit_count_reg_mux0000 ;
  wire [7 : 0] \master/data_reg ;
  wire [7 : 0] \master/data_reg_mux0000 ;
  wire [16 : 0] \master/delay_next_addsub0000 ;
  wire [16 : 0] \master/delay_reg ;
  wire [15 : 0] \master/phy_state_reg ;
  GND   XST_GND (
    .G(analyzer1_data_0_OBUF_79)
  );
  VCC   XST_VCC (
    .P(analyzer4_clock_OBUF_115)
  );
  FDE   \db_button0/steady_reg  (
    .C(clock_27mhz_BUFGP_139),
    .CE(\db_button0/steady_reg_not0001 ),
    .D(\db_button0/steady_reg_mux0000 ),
    .Q(\db_button0/steady_reg_210 )
  );
  FDE   \db_button0/old  (
    .C(clock_27mhz_BUFGP_139),
    .CE(\db_button0/count_or0000 ),
    .D(db_button0_not0000),
    .Q(\db_button0/old_209 )
  );
  FDRE   \db_button0/count_0  (
    .C(clock_27mhz_BUFGP_139),
    .CE(\db_button0/count_not0001 ),
    .D(Result[0]),
    .R(\db_button0/count_or0000 ),
    .Q(\db_button0/count [0])
  );
  FDRE   \db_button0/count_1  (
    .C(clock_27mhz_BUFGP_139),
    .CE(\db_button0/count_not0001 ),
    .D(Result[1]),
    .R(\db_button0/count_or0000 ),
    .Q(\db_button0/count [1])
  );
  FDRE   \db_button0/count_2  (
    .C(clock_27mhz_BUFGP_139),
    .CE(\db_button0/count_not0001 ),
    .D(Result[2]),
    .R(\db_button0/count_or0000 ),
    .Q(\db_button0/count [2])
  );
  FDRE   \db_button0/count_3  (
    .C(clock_27mhz_BUFGP_139),
    .CE(\db_button0/count_not0001 ),
    .D(Result[3]),
    .R(\db_button0/count_or0000 ),
    .Q(\db_button0/count [3])
  );
  FDRE   \db_button0/count_4  (
    .C(clock_27mhz_BUFGP_139),
    .CE(\db_button0/count_not0001 ),
    .D(Result[4]),
    .R(\db_button0/count_or0000 ),
    .Q(\db_button0/count [4])
  );
  FDRE   \db_button0/count_5  (
    .C(clock_27mhz_BUFGP_139),
    .CE(\db_button0/count_not0001 ),
    .D(Result[5]),
    .R(\db_button0/count_or0000 ),
    .Q(\db_button0/count [5])
  );
  FDRE   \db_button0/count_6  (
    .C(clock_27mhz_BUFGP_139),
    .CE(\db_button0/count_not0001 ),
    .D(Result[6]),
    .R(\db_button0/count_or0000 ),
    .Q(\db_button0/count [6])
  );
  FDRE   \db_button0/count_7  (
    .C(clock_27mhz_BUFGP_139),
    .CE(\db_button0/count_not0001 ),
    .D(Result[7]),
    .R(\db_button0/count_or0000 ),
    .Q(\db_button0/count [7])
  );
  FDRE   \db_button0/count_8  (
    .C(clock_27mhz_BUFGP_139),
    .CE(\db_button0/count_not0001 ),
    .D(Result[8]),
    .R(\db_button0/count_or0000 ),
    .Q(\db_button0/count [8])
  );
  FDRE   \db_button0/count_9  (
    .C(clock_27mhz_BUFGP_139),
    .CE(\db_button0/count_not0001 ),
    .D(Result[9]),
    .R(\db_button0/count_or0000 ),
    .Q(\db_button0/count [9])
  );
  FDRE   \db_button0/count_10  (
    .C(clock_27mhz_BUFGP_139),
    .CE(\db_button0/count_not0001 ),
    .D(Result[10]),
    .R(\db_button0/count_or0000 ),
    .Q(\db_button0/count [10])
  );
  FDRE   \db_button0/count_11  (
    .C(clock_27mhz_BUFGP_139),
    .CE(\db_button0/count_not0001 ),
    .D(Result[11]),
    .R(\db_button0/count_or0000 ),
    .Q(\db_button0/count [11])
  );
  FDRE   \db_button0/count_12  (
    .C(clock_27mhz_BUFGP_139),
    .CE(\db_button0/count_not0001 ),
    .D(Result[12]),
    .R(\db_button0/count_or0000 ),
    .Q(\db_button0/count [12])
  );
  FDRE   \db_button0/count_13  (
    .C(clock_27mhz_BUFGP_139),
    .CE(\db_button0/count_not0001 ),
    .D(Result[13]),
    .R(\db_button0/count_or0000 ),
    .Q(\db_button0/count [13])
  );
  FDRE   \db_button0/count_14  (
    .C(clock_27mhz_BUFGP_139),
    .CE(\db_button0/count_not0001 ),
    .D(Result[14]),
    .R(\db_button0/count_or0000 ),
    .Q(\db_button0/count [14])
  );
  FDRE   \db_button0/count_15  (
    .C(clock_27mhz_BUFGP_139),
    .CE(\db_button0/count_not0001 ),
    .D(Result[15]),
    .R(\db_button0/count_or0000 ),
    .Q(\db_button0/count [15])
  );
  FDRE   \db_button0/count_16  (
    .C(clock_27mhz_BUFGP_139),
    .CE(\db_button0/count_not0001 ),
    .D(Result[16]),
    .R(\db_button0/count_or0000 ),
    .Q(\db_button0/count [16])
  );
  FDRE   \db_button0/count_17  (
    .C(clock_27mhz_BUFGP_139),
    .CE(\db_button0/count_not0001 ),
    .D(Result[17]),
    .R(\db_button0/count_or0000 ),
    .Q(\db_button0/count [17])
  );
  FDRE   \db_button0/count_18  (
    .C(clock_27mhz_BUFGP_139),
    .CE(\db_button0/count_not0001 ),
    .D(Result[18]),
    .R(\db_button0/count_or0000 ),
    .Q(\db_button0/count [18])
  );
  MUXCY   \db_button0/Mcount_count_cy<0>  (
    .CI(analyzer1_data_0_OBUF_79),
    .DI(analyzer4_clock_OBUF_115),
    .S(\db_button0/Mcount_count_lut [0]),
    .O(\db_button0/Mcount_count_cy [0])
  );
  XORCY   \db_button0/Mcount_count_xor<0>  (
    .CI(analyzer1_data_0_OBUF_79),
    .LI(\db_button0/Mcount_count_lut [0]),
    .O(Result[0])
  );
  MUXCY   \db_button0/Mcount_count_cy<1>  (
    .CI(\db_button0/Mcount_count_cy [0]),
    .DI(analyzer1_data_0_OBUF_79),
    .S(\db_button0/Mcount_count_cy<1>_rt_159 ),
    .O(\db_button0/Mcount_count_cy [1])
  );
  XORCY   \db_button0/Mcount_count_xor<1>  (
    .CI(\db_button0/Mcount_count_cy [0]),
    .LI(\db_button0/Mcount_count_cy<1>_rt_159 ),
    .O(Result[1])
  );
  MUXCY   \db_button0/Mcount_count_cy<2>  (
    .CI(\db_button0/Mcount_count_cy [1]),
    .DI(analyzer1_data_0_OBUF_79),
    .S(\db_button0/Mcount_count_cy<2>_rt_161 ),
    .O(\db_button0/Mcount_count_cy [2])
  );
  XORCY   \db_button0/Mcount_count_xor<2>  (
    .CI(\db_button0/Mcount_count_cy [1]),
    .LI(\db_button0/Mcount_count_cy<2>_rt_161 ),
    .O(Result[2])
  );
  MUXCY   \db_button0/Mcount_count_cy<3>  (
    .CI(\db_button0/Mcount_count_cy [2]),
    .DI(analyzer1_data_0_OBUF_79),
    .S(\db_button0/Mcount_count_cy<3>_rt_163 ),
    .O(\db_button0/Mcount_count_cy [3])
  );
  XORCY   \db_button0/Mcount_count_xor<3>  (
    .CI(\db_button0/Mcount_count_cy [2]),
    .LI(\db_button0/Mcount_count_cy<3>_rt_163 ),
    .O(Result[3])
  );
  MUXCY   \db_button0/Mcount_count_cy<4>  (
    .CI(\db_button0/Mcount_count_cy [3]),
    .DI(analyzer1_data_0_OBUF_79),
    .S(\db_button0/Mcount_count_cy<4>_rt_165 ),
    .O(\db_button0/Mcount_count_cy [4])
  );
  XORCY   \db_button0/Mcount_count_xor<4>  (
    .CI(\db_button0/Mcount_count_cy [3]),
    .LI(\db_button0/Mcount_count_cy<4>_rt_165 ),
    .O(Result[4])
  );
  MUXCY   \db_button0/Mcount_count_cy<5>  (
    .CI(\db_button0/Mcount_count_cy [4]),
    .DI(analyzer1_data_0_OBUF_79),
    .S(\db_button0/Mcount_count_cy<5>_rt_167 ),
    .O(\db_button0/Mcount_count_cy [5])
  );
  XORCY   \db_button0/Mcount_count_xor<5>  (
    .CI(\db_button0/Mcount_count_cy [4]),
    .LI(\db_button0/Mcount_count_cy<5>_rt_167 ),
    .O(Result[5])
  );
  MUXCY   \db_button0/Mcount_count_cy<6>  (
    .CI(\db_button0/Mcount_count_cy [5]),
    .DI(analyzer1_data_0_OBUF_79),
    .S(\db_button0/Mcount_count_cy<6>_rt_169 ),
    .O(\db_button0/Mcount_count_cy [6])
  );
  XORCY   \db_button0/Mcount_count_xor<6>  (
    .CI(\db_button0/Mcount_count_cy [5]),
    .LI(\db_button0/Mcount_count_cy<6>_rt_169 ),
    .O(Result[6])
  );
  MUXCY   \db_button0/Mcount_count_cy<7>  (
    .CI(\db_button0/Mcount_count_cy [6]),
    .DI(analyzer1_data_0_OBUF_79),
    .S(\db_button0/Mcount_count_cy<7>_rt_171 ),
    .O(\db_button0/Mcount_count_cy [7])
  );
  XORCY   \db_button0/Mcount_count_xor<7>  (
    .CI(\db_button0/Mcount_count_cy [6]),
    .LI(\db_button0/Mcount_count_cy<7>_rt_171 ),
    .O(Result[7])
  );
  MUXCY   \db_button0/Mcount_count_cy<8>  (
    .CI(\db_button0/Mcount_count_cy [7]),
    .DI(analyzer1_data_0_OBUF_79),
    .S(\db_button0/Mcount_count_cy<8>_rt_173 ),
    .O(\db_button0/Mcount_count_cy [8])
  );
  XORCY   \db_button0/Mcount_count_xor<8>  (
    .CI(\db_button0/Mcount_count_cy [7]),
    .LI(\db_button0/Mcount_count_cy<8>_rt_173 ),
    .O(Result[8])
  );
  MUXCY   \db_button0/Mcount_count_cy<9>  (
    .CI(\db_button0/Mcount_count_cy [8]),
    .DI(analyzer1_data_0_OBUF_79),
    .S(\db_button0/Mcount_count_cy<9>_rt_175 ),
    .O(\db_button0/Mcount_count_cy [9])
  );
  XORCY   \db_button0/Mcount_count_xor<9>  (
    .CI(\db_button0/Mcount_count_cy [8]),
    .LI(\db_button0/Mcount_count_cy<9>_rt_175 ),
    .O(Result[9])
  );
  MUXCY   \db_button0/Mcount_count_cy<10>  (
    .CI(\db_button0/Mcount_count_cy [9]),
    .DI(analyzer1_data_0_OBUF_79),
    .S(\db_button0/Mcount_count_cy<10>_rt_143 ),
    .O(\db_button0/Mcount_count_cy [10])
  );
  XORCY   \db_button0/Mcount_count_xor<10>  (
    .CI(\db_button0/Mcount_count_cy [9]),
    .LI(\db_button0/Mcount_count_cy<10>_rt_143 ),
    .O(Result[10])
  );
  MUXCY   \db_button0/Mcount_count_cy<11>  (
    .CI(\db_button0/Mcount_count_cy [10]),
    .DI(analyzer1_data_0_OBUF_79),
    .S(\db_button0/Mcount_count_cy<11>_rt_145 ),
    .O(\db_button0/Mcount_count_cy [11])
  );
  XORCY   \db_button0/Mcount_count_xor<11>  (
    .CI(\db_button0/Mcount_count_cy [10]),
    .LI(\db_button0/Mcount_count_cy<11>_rt_145 ),
    .O(Result[11])
  );
  MUXCY   \db_button0/Mcount_count_cy<12>  (
    .CI(\db_button0/Mcount_count_cy [11]),
    .DI(analyzer1_data_0_OBUF_79),
    .S(\db_button0/Mcount_count_cy<12>_rt_147 ),
    .O(\db_button0/Mcount_count_cy [12])
  );
  XORCY   \db_button0/Mcount_count_xor<12>  (
    .CI(\db_button0/Mcount_count_cy [11]),
    .LI(\db_button0/Mcount_count_cy<12>_rt_147 ),
    .O(Result[12])
  );
  MUXCY   \db_button0/Mcount_count_cy<13>  (
    .CI(\db_button0/Mcount_count_cy [12]),
    .DI(analyzer1_data_0_OBUF_79),
    .S(\db_button0/Mcount_count_cy<13>_rt_149 ),
    .O(\db_button0/Mcount_count_cy [13])
  );
  XORCY   \db_button0/Mcount_count_xor<13>  (
    .CI(\db_button0/Mcount_count_cy [12]),
    .LI(\db_button0/Mcount_count_cy<13>_rt_149 ),
    .O(Result[13])
  );
  MUXCY   \db_button0/Mcount_count_cy<14>  (
    .CI(\db_button0/Mcount_count_cy [13]),
    .DI(analyzer1_data_0_OBUF_79),
    .S(\db_button0/Mcount_count_cy<14>_rt_151 ),
    .O(\db_button0/Mcount_count_cy [14])
  );
  XORCY   \db_button0/Mcount_count_xor<14>  (
    .CI(\db_button0/Mcount_count_cy [13]),
    .LI(\db_button0/Mcount_count_cy<14>_rt_151 ),
    .O(Result[14])
  );
  MUXCY   \db_button0/Mcount_count_cy<15>  (
    .CI(\db_button0/Mcount_count_cy [14]),
    .DI(analyzer1_data_0_OBUF_79),
    .S(\db_button0/Mcount_count_cy<15>_rt_153 ),
    .O(\db_button0/Mcount_count_cy [15])
  );
  XORCY   \db_button0/Mcount_count_xor<15>  (
    .CI(\db_button0/Mcount_count_cy [14]),
    .LI(\db_button0/Mcount_count_cy<15>_rt_153 ),
    .O(Result[15])
  );
  MUXCY   \db_button0/Mcount_count_cy<16>  (
    .CI(\db_button0/Mcount_count_cy [15]),
    .DI(analyzer1_data_0_OBUF_79),
    .S(\db_button0/Mcount_count_cy<16>_rt_155 ),
    .O(\db_button0/Mcount_count_cy [16])
  );
  XORCY   \db_button0/Mcount_count_xor<16>  (
    .CI(\db_button0/Mcount_count_cy [15]),
    .LI(\db_button0/Mcount_count_cy<16>_rt_155 ),
    .O(Result[16])
  );
  MUXCY   \db_button0/Mcount_count_cy<17>  (
    .CI(\db_button0/Mcount_count_cy [16]),
    .DI(analyzer1_data_0_OBUF_79),
    .S(\db_button0/Mcount_count_cy<17>_rt_157 ),
    .O(\db_button0/Mcount_count_cy [17])
  );
  XORCY   \db_button0/Mcount_count_xor<17>  (
    .CI(\db_button0/Mcount_count_cy [16]),
    .LI(\db_button0/Mcount_count_cy<17>_rt_157 ),
    .O(Result[17])
  );
  XORCY   \db_button0/Mcount_count_xor<18>  (
    .CI(\db_button0/Mcount_count_cy [17]),
    .LI(\db_button0/Mcount_count_xor<18>_rt_177 ),
    .O(Result[18])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \master/state_reg_FSM_FFd11  (
    .C(clock_27mhz_BUFGP_139),
    .CE(\master/state_reg_FSM_ClkEn_inv ),
    .D(\master/state_reg_FSM_FFd11-In ),
    .R(\db_button0/steady_reg_210 ),
    .Q(\master/state_reg_FSM_FFd11_486 )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \master/state_reg_FSM_FFd10  (
    .C(clock_27mhz_BUFGP_139),
    .CE(\master/state_reg_FSM_ClkEn_inv ),
    .D(\master/state_reg_FSM_FFd10-In ),
    .R(\db_button0/steady_reg_210 ),
    .Q(\master/state_reg_FSM_FFd10_484 )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \master/state_reg_FSM_FFd12  (
    .C(clock_27mhz_BUFGP_139),
    .CE(\master/state_reg_FSM_ClkEn_inv ),
    .D(\master/state_reg_FSM_FFd12-In ),
    .R(\db_button0/steady_reg_210 ),
    .Q(\master/state_reg_FSM_FFd12_488 )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \master/state_reg_FSM_FFd8  (
    .C(clock_27mhz_BUFGP_139),
    .CE(\master/state_reg_FSM_ClkEn_inv ),
    .D(\master/state_reg_FSM_FFd8-In ),
    .R(\db_button0/steady_reg_210 ),
    .Q(\master/state_reg_FSM_FFd8_496 )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \master/state_reg_FSM_FFd4  (
    .C(clock_27mhz_BUFGP_139),
    .CE(\master/state_reg_FSM_ClkEn_inv ),
    .D(\master/state_reg_FSM_FFd4-In ),
    .R(\db_button0/steady_reg_210 ),
    .Q(\master/state_reg_FSM_FFd4_494 )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \master/state_reg_FSM_FFd2  (
    .C(clock_27mhz_BUFGP_139),
    .CE(\master/state_reg_FSM_ClkEn_inv ),
    .D(\master/state_reg_FSM_FFd2-In ),
    .R(\db_button0/steady_reg_210 ),
    .Q(\master/state_reg_FSM_FFd2_490 )
  );
  FDSE #(
    .INIT ( 1'b1 ))
  \master/state_reg_FSM_FFd1  (
    .C(clock_27mhz_BUFGP_139),
    .CE(\master/state_reg_FSM_ClkEn_inv ),
    .D(\master/state_reg_FSM_FFd1-In_483 ),
    .S(\db_button0/steady_reg_210 ),
    .Q(\master/state_reg_FSM_FFd1_482 )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \master/state_reg_FSM_FFd3  (
    .C(clock_27mhz_BUFGP_139),
    .CE(\master/state_reg_FSM_ClkEn_inv ),
    .D(\master/state_reg_FSM_FFd3-In_493 ),
    .R(\db_button0/steady_reg_210 ),
    .Q(\master/state_reg_FSM_FFd3_492 )
  );
  MUXCY   \master/Mcompar_bus_control_next_cmp_gt0000_cy<4>  (
    .CI(\master/Mcompar_bus_control_next_cmp_gt0000_cy [3]),
    .DI(analyzer1_data_0_OBUF_79),
    .S(\master/Mcompar_bus_control_next_cmp_gt0000_lut [4]),
    .O(\master/Mcompar_bus_control_next_cmp_gt0000_cy [4])
  );
  MUXCY   \master/Mcompar_bus_control_next_cmp_gt0000_cy<3>  (
    .CI(\master/Mcompar_bus_control_next_cmp_gt0000_cy [2]),
    .DI(analyzer1_data_0_OBUF_79),
    .S(\master/Mcompar_bus_control_next_cmp_gt0000_lut [3]),
    .O(\master/Mcompar_bus_control_next_cmp_gt0000_cy [3])
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  \master/Mcompar_bus_control_next_cmp_gt0000_lut<3>  (
    .I0(\master/delay_reg [12]),
    .I1(\master/delay_reg [13]),
    .I2(\master/delay_reg [14]),
    .I3(\master/delay_reg [15]),
    .O(\master/Mcompar_bus_control_next_cmp_gt0000_lut [3])
  );
  MUXCY   \master/Mcompar_bus_control_next_cmp_gt0000_cy<2>  (
    .CI(\master/Mcompar_bus_control_next_cmp_gt0000_cy [1]),
    .DI(analyzer1_data_0_OBUF_79),
    .S(\master/Mcompar_bus_control_next_cmp_gt0000_lut [2]),
    .O(\master/Mcompar_bus_control_next_cmp_gt0000_cy [2])
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  \master/Mcompar_bus_control_next_cmp_gt0000_lut<2>  (
    .I0(\master/delay_reg [8]),
    .I1(\master/delay_reg [9]),
    .I2(\master/delay_reg [10]),
    .I3(\master/delay_reg [11]),
    .O(\master/Mcompar_bus_control_next_cmp_gt0000_lut [2])
  );
  MUXCY   \master/Mcompar_bus_control_next_cmp_gt0000_cy<1>  (
    .CI(\master/Mcompar_bus_control_next_cmp_gt0000_cy [0]),
    .DI(analyzer1_data_0_OBUF_79),
    .S(\master/Mcompar_bus_control_next_cmp_gt0000_lut [1]),
    .O(\master/Mcompar_bus_control_next_cmp_gt0000_cy [1])
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  \master/Mcompar_bus_control_next_cmp_gt0000_lut<1>  (
    .I0(\master/delay_reg [4]),
    .I1(\master/delay_reg [5]),
    .I2(\master/delay_reg [6]),
    .I3(\master/delay_reg [7]),
    .O(\master/Mcompar_bus_control_next_cmp_gt0000_lut [1])
  );
  MUXCY   \master/Mcompar_bus_control_next_cmp_gt0000_cy<0>  (
    .CI(analyzer4_clock_OBUF_115),
    .DI(analyzer1_data_0_OBUF_79),
    .S(\master/Mcompar_bus_control_next_cmp_gt0000_lut [0]),
    .O(\master/Mcompar_bus_control_next_cmp_gt0000_cy [0])
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  \master/Mcompar_bus_control_next_cmp_gt0000_lut<0>  (
    .I0(\master/delay_reg [0]),
    .I1(\master/delay_reg [1]),
    .I2(\master/delay_reg [2]),
    .I3(\master/delay_reg [3]),
    .O(\master/Mcompar_bus_control_next_cmp_gt0000_lut [0])
  );
  XORCY   \master/Msub_delay_next_addsub0000_xor<16>  (
    .CI(\master/Msub_delay_next_addsub0000_cy [15]),
    .LI(\master/Mcompar_bus_control_next_cmp_gt0000_lut<4>1 ),
    .O(\master/delay_next_addsub0000 [16])
  );
  XORCY   \master/Msub_delay_next_addsub0000_xor<15>  (
    .CI(\master/Msub_delay_next_addsub0000_cy [14]),
    .LI(\master/Msub_delay_next_addsub0000_lut [15]),
    .O(\master/delay_next_addsub0000 [15])
  );
  MUXCY   \master/Msub_delay_next_addsub0000_cy<15>  (
    .CI(\master/Msub_delay_next_addsub0000_cy [14]),
    .DI(analyzer4_clock_OBUF_115),
    .S(\master/Msub_delay_next_addsub0000_lut [15]),
    .O(\master/Msub_delay_next_addsub0000_cy [15])
  );
  XORCY   \master/Msub_delay_next_addsub0000_xor<14>  (
    .CI(\master/Msub_delay_next_addsub0000_cy [13]),
    .LI(\master/Msub_delay_next_addsub0000_lut [14]),
    .O(\master/delay_next_addsub0000 [14])
  );
  MUXCY   \master/Msub_delay_next_addsub0000_cy<14>  (
    .CI(\master/Msub_delay_next_addsub0000_cy [13]),
    .DI(analyzer4_clock_OBUF_115),
    .S(\master/Msub_delay_next_addsub0000_lut [14]),
    .O(\master/Msub_delay_next_addsub0000_cy [14])
  );
  XORCY   \master/Msub_delay_next_addsub0000_xor<13>  (
    .CI(\master/Msub_delay_next_addsub0000_cy [12]),
    .LI(\master/Msub_delay_next_addsub0000_lut [13]),
    .O(\master/delay_next_addsub0000 [13])
  );
  MUXCY   \master/Msub_delay_next_addsub0000_cy<13>  (
    .CI(\master/Msub_delay_next_addsub0000_cy [12]),
    .DI(analyzer4_clock_OBUF_115),
    .S(\master/Msub_delay_next_addsub0000_lut [13]),
    .O(\master/Msub_delay_next_addsub0000_cy [13])
  );
  XORCY   \master/Msub_delay_next_addsub0000_xor<12>  (
    .CI(\master/Msub_delay_next_addsub0000_cy [11]),
    .LI(\master/Msub_delay_next_addsub0000_lut [12]),
    .O(\master/delay_next_addsub0000 [12])
  );
  MUXCY   \master/Msub_delay_next_addsub0000_cy<12>  (
    .CI(\master/Msub_delay_next_addsub0000_cy [11]),
    .DI(analyzer4_clock_OBUF_115),
    .S(\master/Msub_delay_next_addsub0000_lut [12]),
    .O(\master/Msub_delay_next_addsub0000_cy [12])
  );
  XORCY   \master/Msub_delay_next_addsub0000_xor<11>  (
    .CI(\master/Msub_delay_next_addsub0000_cy [10]),
    .LI(\master/Msub_delay_next_addsub0000_lut [11]),
    .O(\master/delay_next_addsub0000 [11])
  );
  MUXCY   \master/Msub_delay_next_addsub0000_cy<11>  (
    .CI(\master/Msub_delay_next_addsub0000_cy [10]),
    .DI(analyzer4_clock_OBUF_115),
    .S(\master/Msub_delay_next_addsub0000_lut [11]),
    .O(\master/Msub_delay_next_addsub0000_cy [11])
  );
  XORCY   \master/Msub_delay_next_addsub0000_xor<10>  (
    .CI(\master/Msub_delay_next_addsub0000_cy [9]),
    .LI(\master/Msub_delay_next_addsub0000_lut [10]),
    .O(\master/delay_next_addsub0000 [10])
  );
  MUXCY   \master/Msub_delay_next_addsub0000_cy<10>  (
    .CI(\master/Msub_delay_next_addsub0000_cy [9]),
    .DI(analyzer4_clock_OBUF_115),
    .S(\master/Msub_delay_next_addsub0000_lut [10]),
    .O(\master/Msub_delay_next_addsub0000_cy [10])
  );
  XORCY   \master/Msub_delay_next_addsub0000_xor<9>  (
    .CI(\master/Msub_delay_next_addsub0000_cy [8]),
    .LI(\master/Msub_delay_next_addsub0000_lut [9]),
    .O(\master/delay_next_addsub0000 [9])
  );
  MUXCY   \master/Msub_delay_next_addsub0000_cy<9>  (
    .CI(\master/Msub_delay_next_addsub0000_cy [8]),
    .DI(analyzer4_clock_OBUF_115),
    .S(\master/Msub_delay_next_addsub0000_lut [9]),
    .O(\master/Msub_delay_next_addsub0000_cy [9])
  );
  XORCY   \master/Msub_delay_next_addsub0000_xor<8>  (
    .CI(\master/Msub_delay_next_addsub0000_cy [7]),
    .LI(\master/Msub_delay_next_addsub0000_lut [8]),
    .O(\master/delay_next_addsub0000 [8])
  );
  MUXCY   \master/Msub_delay_next_addsub0000_cy<8>  (
    .CI(\master/Msub_delay_next_addsub0000_cy [7]),
    .DI(analyzer4_clock_OBUF_115),
    .S(\master/Msub_delay_next_addsub0000_lut [8]),
    .O(\master/Msub_delay_next_addsub0000_cy [8])
  );
  XORCY   \master/Msub_delay_next_addsub0000_xor<7>  (
    .CI(\master/Msub_delay_next_addsub0000_cy [6]),
    .LI(\master/Msub_delay_next_addsub0000_lut [7]),
    .O(\master/delay_next_addsub0000 [7])
  );
  MUXCY   \master/Msub_delay_next_addsub0000_cy<7>  (
    .CI(\master/Msub_delay_next_addsub0000_cy [6]),
    .DI(analyzer4_clock_OBUF_115),
    .S(\master/Msub_delay_next_addsub0000_lut [7]),
    .O(\master/Msub_delay_next_addsub0000_cy [7])
  );
  XORCY   \master/Msub_delay_next_addsub0000_xor<6>  (
    .CI(\master/Msub_delay_next_addsub0000_cy [5]),
    .LI(\master/Msub_delay_next_addsub0000_lut [6]),
    .O(\master/delay_next_addsub0000 [6])
  );
  MUXCY   \master/Msub_delay_next_addsub0000_cy<6>  (
    .CI(\master/Msub_delay_next_addsub0000_cy [5]),
    .DI(analyzer4_clock_OBUF_115),
    .S(\master/Msub_delay_next_addsub0000_lut [6]),
    .O(\master/Msub_delay_next_addsub0000_cy [6])
  );
  XORCY   \master/Msub_delay_next_addsub0000_xor<5>  (
    .CI(\master/Msub_delay_next_addsub0000_cy [4]),
    .LI(\master/Msub_delay_next_addsub0000_lut [5]),
    .O(\master/delay_next_addsub0000 [5])
  );
  MUXCY   \master/Msub_delay_next_addsub0000_cy<5>  (
    .CI(\master/Msub_delay_next_addsub0000_cy [4]),
    .DI(analyzer4_clock_OBUF_115),
    .S(\master/Msub_delay_next_addsub0000_lut [5]),
    .O(\master/Msub_delay_next_addsub0000_cy [5])
  );
  XORCY   \master/Msub_delay_next_addsub0000_xor<4>  (
    .CI(\master/Msub_delay_next_addsub0000_cy [3]),
    .LI(\master/Msub_delay_next_addsub0000_lut [4]),
    .O(\master/delay_next_addsub0000 [4])
  );
  MUXCY   \master/Msub_delay_next_addsub0000_cy<4>  (
    .CI(\master/Msub_delay_next_addsub0000_cy [3]),
    .DI(analyzer4_clock_OBUF_115),
    .S(\master/Msub_delay_next_addsub0000_lut [4]),
    .O(\master/Msub_delay_next_addsub0000_cy [4])
  );
  XORCY   \master/Msub_delay_next_addsub0000_xor<3>  (
    .CI(\master/Msub_delay_next_addsub0000_cy [2]),
    .LI(\master/Msub_delay_next_addsub0000_lut [3]),
    .O(\master/delay_next_addsub0000 [3])
  );
  MUXCY   \master/Msub_delay_next_addsub0000_cy<3>  (
    .CI(\master/Msub_delay_next_addsub0000_cy [2]),
    .DI(analyzer4_clock_OBUF_115),
    .S(\master/Msub_delay_next_addsub0000_lut [3]),
    .O(\master/Msub_delay_next_addsub0000_cy [3])
  );
  XORCY   \master/Msub_delay_next_addsub0000_xor<2>  (
    .CI(\master/Msub_delay_next_addsub0000_cy [1]),
    .LI(\master/Msub_delay_next_addsub0000_lut [2]),
    .O(\master/delay_next_addsub0000 [2])
  );
  MUXCY   \master/Msub_delay_next_addsub0000_cy<2>  (
    .CI(\master/Msub_delay_next_addsub0000_cy [1]),
    .DI(analyzer4_clock_OBUF_115),
    .S(\master/Msub_delay_next_addsub0000_lut [2]),
    .O(\master/Msub_delay_next_addsub0000_cy [2])
  );
  XORCY   \master/Msub_delay_next_addsub0000_xor<1>  (
    .CI(\master/Msub_delay_next_addsub0000_cy [0]),
    .LI(\master/Msub_delay_next_addsub0000_lut [1]),
    .O(\master/delay_next_addsub0000 [1])
  );
  MUXCY   \master/Msub_delay_next_addsub0000_cy<1>  (
    .CI(\master/Msub_delay_next_addsub0000_cy [0]),
    .DI(analyzer4_clock_OBUF_115),
    .S(\master/Msub_delay_next_addsub0000_lut [1]),
    .O(\master/Msub_delay_next_addsub0000_cy [1])
  );
  XORCY   \master/Msub_delay_next_addsub0000_xor<0>  (
    .CI(analyzer4_clock_OBUF_115),
    .LI(\master/Msub_delay_next_addsub0000_cy<0>_rt_270 ),
    .O(\master/delay_next_addsub0000 [0])
  );
  MUXCY   \master/Msub_delay_next_addsub0000_cy<0>  (
    .CI(analyzer4_clock_OBUF_115),
    .DI(analyzer1_data_0_OBUF_79),
    .S(\master/Msub_delay_next_addsub0000_cy<0>_rt_270 ),
    .O(\master/Msub_delay_next_addsub0000_cy [0])
  );
  FD #(
    .INIT ( 1'b1 ))
  \master/last_sda_i_reg  (
    .C(clock_27mhz_BUFGP_139),
    .D(\master/sda_i_reg_466 ),
    .Q(\master/last_sda_i_reg_419 )
  );
  FD #(
    .INIT ( 1'b1 ))
  \master/sda_i_reg  (
    .C(clock_27mhz_BUFGP_139),
    .D(N27),
    .Q(\master/sda_i_reg_466 )
  );
  FD #(
    .INIT ( 1'b1 ))
  \master/scl_i_reg  (
    .C(clock_27mhz_BUFGP_139),
    .D(N26),
    .Q(\master/scl_i_reg_460 )
  );
  FDE #(
    .INIT ( 1'b0 ))
  \master/bit_count_reg_3  (
    .C(clock_27mhz_BUFGP_139),
    .CE(\master/state_reg_FSM_ClkEn_inv ),
    .D(\master/bit_count_reg_mux0000 [3]),
    .Q(\master/bit_count_reg [3])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \master/bit_count_reg_2  (
    .C(clock_27mhz_BUFGP_139),
    .CE(\master/state_reg_FSM_ClkEn_inv ),
    .D(\master/bit_count_reg_mux0000 [2]),
    .Q(\master/bit_count_reg [2])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \master/bit_count_reg_1  (
    .C(clock_27mhz_BUFGP_139),
    .CE(\master/state_reg_FSM_ClkEn_inv ),
    .D(\master/bit_count_reg_mux0000 [1]),
    .Q(\master/bit_count_reg [1])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \master/bit_count_reg_0  (
    .C(clock_27mhz_BUFGP_139),
    .CE(\master/state_reg_FSM_ClkEn_inv ),
    .D(\master/bit_count_reg_mux0000 [0]),
    .Q(\master/bit_count_reg [0])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \master/mode_stop_reg  (
    .C(clock_27mhz_BUFGP_139),
    .CE(\master/state_reg_FSM_ClkEn_inv ),
    .D(\master/mode_stop_reg_mux0000 ),
    .Q(\master/mode_stop_reg_420 )
  );
  FDE #(
    .INIT ( 1'b0 ))
  \master/data_reg_7  (
    .C(clock_27mhz_BUFGP_139),
    .CE(\master/state_reg_FSM_ClkEn_inv ),
    .D(\master/data_reg_mux0000 [7]),
    .Q(\master/data_reg [7])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \master/data_reg_6  (
    .C(clock_27mhz_BUFGP_139),
    .CE(\master/state_reg_FSM_ClkEn_inv ),
    .D(\master/data_reg_mux0000 [6]),
    .Q(\master/data_reg [6])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \master/data_reg_5  (
    .C(clock_27mhz_BUFGP_139),
    .CE(\master/state_reg_FSM_ClkEn_inv ),
    .D(\master/data_reg_mux0000 [5]),
    .Q(\master/data_reg [5])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \master/data_reg_4  (
    .C(clock_27mhz_BUFGP_139),
    .CE(\master/state_reg_FSM_ClkEn_inv ),
    .D(\master/data_reg_mux0000 [4]),
    .Q(\master/data_reg [4])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \master/data_reg_3  (
    .C(clock_27mhz_BUFGP_139),
    .CE(\master/state_reg_FSM_ClkEn_inv ),
    .D(\master/data_reg_mux0000 [3]),
    .Q(\master/data_reg [3])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \master/data_reg_2  (
    .C(clock_27mhz_BUFGP_139),
    .CE(\master/state_reg_FSM_ClkEn_inv ),
    .D(\master/data_reg_mux0000 [2]),
    .Q(\master/data_reg [2])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \master/data_reg_1  (
    .C(clock_27mhz_BUFGP_139),
    .CE(\master/state_reg_FSM_ClkEn_inv ),
    .D(\master/data_reg_mux0000 [1]),
    .Q(\master/data_reg [1])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \master/data_reg_0  (
    .C(clock_27mhz_BUFGP_139),
    .CE(\master/state_reg_FSM_ClkEn_inv ),
    .D(\master/data_reg_mux0000 [0]),
    .Q(\master/data_reg [0])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \master/addr_reg_5  (
    .C(clock_27mhz_BUFGP_139),
    .CE(\master/state_reg_FSM_ClkEn_inv ),
    .D(\master/addr_reg_mux0000[5] ),
    .Q(\master/addr_reg[5] )
  );
  FDE #(
    .INIT ( 1'b0 ))
  \master/addr_reg_3  (
    .C(clock_27mhz_BUFGP_139),
    .CE(\master/state_reg_FSM_ClkEn_inv ),
    .D(\master/addr_reg_mux0000[3] ),
    .Q(\master/addr_reg[3] )
  );
  FDE #(
    .INIT ( 1'b0 ))
  \master/addr_reg_0  (
    .C(clock_27mhz_BUFGP_139),
    .CE(\master/state_reg_FSM_ClkEn_inv ),
    .D(\master/addr_reg_mux0000[0] ),
    .Q(\master/addr_reg[0] )
  );
  FDRSE #(
    .INIT ( 1'b0 ))
  \master/bus_active_reg  (
    .C(clock_27mhz_BUFGP_139),
    .CE(\master/stop_bit ),
    .D(analyzer1_data_0_OBUF_79),
    .R(\db_button0/steady_reg_210 ),
    .S(\master/start_bit ),
    .Q(\master/bus_active_reg_331 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \master/data_in_ready_reg  (
    .C(clock_27mhz_BUFGP_139),
    .D(\master/data_in_ready_next ),
    .R(\db_button0/steady_reg_210 ),
    .Q(\master/data_in_ready_reg_336 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \master/cmd_ready_reg  (
    .C(clock_27mhz_BUFGP_139),
    .D(\master/cmd_ready_next ),
    .R(\db_button0/steady_reg_210 ),
    .Q(\master/cmd_ready_reg_334 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \master/delay_reg_16  (
    .C(clock_27mhz_BUFGP_139),
    .D(\master/delay_next[16] ),
    .R(\db_button0/steady_reg_210 ),
    .Q(\master/delay_reg [16])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \master/delay_reg_15  (
    .C(clock_27mhz_BUFGP_139),
    .D(\master/delay_next[15] ),
    .R(\db_button0/steady_reg_210 ),
    .Q(\master/delay_reg [15])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \master/delay_reg_14  (
    .C(clock_27mhz_BUFGP_139),
    .D(\master/delay_next[14] ),
    .R(\db_button0/steady_reg_210 ),
    .Q(\master/delay_reg [14])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \master/delay_reg_13  (
    .C(clock_27mhz_BUFGP_139),
    .D(\master/delay_next[13] ),
    .R(\db_button0/steady_reg_210 ),
    .Q(\master/delay_reg [13])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \master/delay_reg_12  (
    .C(clock_27mhz_BUFGP_139),
    .D(\master/delay_next[12] ),
    .R(\db_button0/steady_reg_210 ),
    .Q(\master/delay_reg [12])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \master/delay_reg_11  (
    .C(clock_27mhz_BUFGP_139),
    .D(\master/delay_next[11] ),
    .R(\db_button0/steady_reg_210 ),
    .Q(\master/delay_reg [11])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \master/delay_reg_10  (
    .C(clock_27mhz_BUFGP_139),
    .D(\master/delay_next[10] ),
    .R(\db_button0/steady_reg_210 ),
    .Q(\master/delay_reg [10])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \master/delay_reg_9  (
    .C(clock_27mhz_BUFGP_139),
    .D(\master/delay_next[9] ),
    .R(\db_button0/steady_reg_210 ),
    .Q(\master/delay_reg [9])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \master/delay_reg_8  (
    .C(clock_27mhz_BUFGP_139),
    .D(\master/delay_next[8] ),
    .R(\db_button0/steady_reg_210 ),
    .Q(\master/delay_reg [8])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \master/delay_reg_6  (
    .C(clock_27mhz_BUFGP_139),
    .D(\master/delay_next[6] ),
    .R(\db_button0/steady_reg_210 ),
    .Q(\master/delay_reg [6])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \master/delay_reg_5  (
    .C(clock_27mhz_BUFGP_139),
    .D(\master/delay_next[5] ),
    .R(\db_button0/steady_reg_210 ),
    .Q(\master/delay_reg [5])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \master/delay_reg_4  (
    .C(clock_27mhz_BUFGP_139),
    .D(\master/delay_next[4] ),
    .R(\db_button0/steady_reg_210 ),
    .Q(\master/delay_reg [4])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \master/delay_reg_3  (
    .C(clock_27mhz_BUFGP_139),
    .D(\master/delay_next[3] ),
    .R(\db_button0/steady_reg_210 ),
    .Q(\master/delay_reg [3])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \master/delay_reg_2  (
    .C(clock_27mhz_BUFGP_139),
    .D(\master/delay_next[2] ),
    .R(\db_button0/steady_reg_210 ),
    .Q(\master/delay_reg [2])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \master/delay_reg_1  (
    .C(clock_27mhz_BUFGP_139),
    .D(\master/delay_next[1] ),
    .R(\db_button0/steady_reg_210 ),
    .Q(\master/delay_reg [1])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \master/delay_reg_0  (
    .C(clock_27mhz_BUFGP_139),
    .D(\master/delay_next[0] ),
    .R(\db_button0/steady_reg_210 ),
    .Q(\master/delay_reg [0])
  );
  FD #(
    .INIT ( 1'b0 ))
  \master/phy_state_reg_13  (
    .C(clock_27mhz_BUFGP_139),
    .D(\master/phy_state_next<13>1_429 ),
    .Q(\master/phy_state_reg [13])
  );
  LUT3 #(
    .INIT ( 8'h20 ))
  \db_button0/count_cmp_eq0000_wg_lut<0>  (
    .I0(\db_button0/count [7]),
    .I1(\db_button0/count [4]),
    .I2(\db_button0/count [5]),
    .O(\db_button0/count_cmp_eq0000_wg_lut [0])
  );
  MUXCY   \db_button0/count_cmp_eq0000_wg_cy<0>  (
    .CI(analyzer4_clock_OBUF_115),
    .DI(analyzer1_data_0_OBUF_79),
    .S(\db_button0/count_cmp_eq0000_wg_lut [0]),
    .O(\db_button0/count_cmp_eq0000_wg_cy [0])
  );
  LUT4 #(
    .INIT ( 16'h1000 ))
  \db_button0/count_cmp_eq0000_wg_lut<1>  (
    .I0(\db_button0/count [6]),
    .I1(\db_button0/count [8]),
    .I2(\db_button0/count [3]),
    .I3(\db_button0/count [9]),
    .O(\db_button0/count_cmp_eq0000_wg_lut [1])
  );
  MUXCY   \db_button0/count_cmp_eq0000_wg_cy<1>  (
    .CI(\db_button0/count_cmp_eq0000_wg_cy [0]),
    .DI(analyzer1_data_0_OBUF_79),
    .S(\db_button0/count_cmp_eq0000_wg_lut [1]),
    .O(\db_button0/count_cmp_eq0000_wg_cy [1])
  );
  LUT4 #(
    .INIT ( 16'h8000 ))
  \db_button0/count_cmp_eq0000_wg_lut<2>  (
    .I0(\db_button0/count [12]),
    .I1(\db_button0/count [10]),
    .I2(\db_button0/count [1]),
    .I3(\db_button0/count [11]),
    .O(\db_button0/count_cmp_eq0000_wg_lut [2])
  );
  MUXCY   \db_button0/count_cmp_eq0000_wg_cy<2>  (
    .CI(\db_button0/count_cmp_eq0000_wg_cy [1]),
    .DI(analyzer1_data_0_OBUF_79),
    .S(\db_button0/count_cmp_eq0000_wg_lut [2]),
    .O(\db_button0/count_cmp_eq0000_wg_cy [2])
  );
  LUT4 #(
    .INIT ( 16'h0010 ))
  \db_button0/count_cmp_eq0000_wg_lut<3>  (
    .I0(\db_button0/count [13]),
    .I1(\db_button0/count [14]),
    .I2(\db_button0/count [0]),
    .I3(\db_button0/count [15]),
    .O(\db_button0/count_cmp_eq0000_wg_lut [3])
  );
  MUXCY   \db_button0/count_cmp_eq0000_wg_cy<3>  (
    .CI(\db_button0/count_cmp_eq0000_wg_cy [2]),
    .DI(analyzer1_data_0_OBUF_79),
    .S(\db_button0/count_cmp_eq0000_wg_lut [3]),
    .O(\db_button0/count_cmp_eq0000_wg_cy [3])
  );
  LUT4 #(
    .INIT ( 16'h1000 ))
  \db_button0/count_cmp_eq0000_wg_lut<4>  (
    .I0(\db_button0/count [16]),
    .I1(\db_button0/count [17]),
    .I2(\db_button0/count [2]),
    .I3(\db_button0/count [18]),
    .O(\db_button0/count_cmp_eq0000_wg_lut [4])
  );
  MUXCY   \db_button0/count_cmp_eq0000_wg_cy<4>  (
    .CI(\db_button0/count_cmp_eq0000_wg_cy [3]),
    .DI(analyzer1_data_0_OBUF_79),
    .S(\db_button0/count_cmp_eq0000_wg_lut [4]),
    .O(\db_button0/count_cmp_eq0000 )
  );
  LUT3 #(
    .INIT ( 8'h20 ))
  \master/stop_bit1  (
    .I0(\master/sda_i_reg_466 ),
    .I1(\master/last_sda_i_reg_419 ),
    .I2(\master/scl_i_reg_460 ),
    .O(\master/stop_bit )
  );
  LUT3 #(
    .INIT ( 8'h20 ))
  \master/start_bit1  (
    .I0(\master/last_sda_i_reg_419 ),
    .I1(\master/sda_i_reg_466 ),
    .I2(\master/scl_i_reg_460 ),
    .O(\master/start_bit )
  );
  LUT3 #(
    .INIT ( 8'hF9 ))
  \db_button0/count_or00001  (
    .I0(\db_button0/old_209 ),
    .I1(button0_IBUF_135),
    .I2(switch_0_IBUF_563),
    .O(\db_button0/count_or0000 )
  );
  LUT3 #(
    .INIT ( 8'h4E ))
  \db_button0/steady_reg_mux00001  (
    .I0(switch_0_IBUF_563),
    .I1(\db_button0/old_209 ),
    .I2(button0_IBUF_135),
    .O(\db_button0/steady_reg_mux0000 )
  );
  LUT4 #(
    .INIT ( 16'h44F4 ))
  \master/state_reg_FSM_FFd4-In1  (
    .I0(\master/cmd_ready_reg_334 ),
    .I1(\master/state_reg_FSM_FFd4_494 ),
    .I2(\master/state_reg_FSM_FFd12_488 ),
    .I3(\master/mode_stop_reg_420 ),
    .O(\master/state_reg_FSM_FFd4-In )
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \master/bit_count_reg_mux0000<3>21  (
    .I0(\master/data_in_ready_reg_336 ),
    .I1(\master/state_reg_FSM_FFd10_484 ),
    .O(\master/N14 )
  );
  LUT3 #(
    .INIT ( 8'h04 ))
  \master/state_reg_FSM_FFd8-In1  (
    .I0(\master/bit_count_reg [0]),
    .I1(\master/state_reg_FSM_FFd3_492 ),
    .I2(\master/state_reg_cmp_gt0000 ),
    .O(\master/state_reg_FSM_FFd8-In )
  );
  LUT3 #(
    .INIT ( 8'h04 ))
  \master/state_reg_FSM_FFd12-In1  (
    .I0(N74),
    .I1(\master/state_reg_FSM_FFd11_486 ),
    .I2(\master/bit_count_reg [0]),
    .O(\master/state_reg_FSM_FFd12-In )
  );
  LUT4 #(
    .INIT ( 16'hAA80 ))
  \master/state_reg_FSM_FFd2-In1  (
    .I0(\master/bus_active_reg_331 ),
    .I1(\master/state_reg_FSM_FFd1_482 ),
    .I2(\master/cmd_ready_next_and0000 ),
    .I3(\master/state_reg_FSM_FFd2_490 ),
    .O(\master/state_reg_FSM_FFd2-In )
  );
  LUT4 #(
    .INIT ( 16'hFFA8 ))
  \master/state_reg_FSM_FFd11-In1  (
    .I0(\master/state_reg_FSM_FFd11_486 ),
    .I1(\master/bit_count_reg [0]),
    .I2(\master/state_reg_cmp_gt0000 ),
    .I3(\master/N14 ),
    .O(\master/state_reg_FSM_FFd11-In )
  );
  LUT4 #(
    .INIT ( 16'hFFA8 ))
  \master/mode_stop_reg_mux00001  (
    .I0(N73),
    .I1(\master/state_reg_FSM_FFd4_494 ),
    .I2(\master/state_reg_FSM_FFd1_482 ),
    .I3(\master/mode_stop_reg_420 ),
    .O(\master/mode_stop_reg_mux0000 )
  );
  LUT4 #(
    .INIT ( 16'h0302 ))
  \master/cmd_ready_next1  (
    .I0(\master/state_reg_FSM_FFd4_494 ),
    .I1(\master/state_reg_and0000 ),
    .I2(\master/cmd_ready_next_and0000 ),
    .I3(\master/state_reg_FSM_FFd1_482 ),
    .O(\master/cmd_ready_next )
  );
  LUT4 #(
    .INIT ( 16'hFFA8 ))
  \master/addr_reg_mux0000<5>1  (
    .I0(\master/cmd_ready_next_and0000 ),
    .I1(\master/state_reg_FSM_FFd4_494 ),
    .I2(\master/state_reg_FSM_FFd1_482 ),
    .I3(\master/addr_reg[5] ),
    .O(\master/addr_reg_mux0000[5] )
  );
  LUT4 #(
    .INIT ( 16'hFFA8 ))
  \master/addr_reg_mux0000<3>1  (
    .I0(\master/cmd_ready_next_and0000 ),
    .I1(\master/state_reg_FSM_FFd4_494 ),
    .I2(\master/state_reg_FSM_FFd1_482 ),
    .I3(\master/addr_reg[3] ),
    .O(\master/addr_reg_mux0000[3] )
  );
  LUT4 #(
    .INIT ( 16'hFFA8 ))
  \master/addr_reg_mux0000<0>1  (
    .I0(\master/cmd_ready_next_and0000 ),
    .I1(\master/state_reg_FSM_FFd4_494 ),
    .I2(\master/state_reg_FSM_FFd1_482 ),
    .I3(\master/addr_reg[0] ),
    .O(\master/addr_reg_mux0000[0] )
  );
  LUT4 #(
    .INIT ( 16'h2E2A ))
  \master/state_reg_FSM_FFd1-In_SW0  (
    .I0(\master/state_reg_FSM_FFd1_482 ),
    .I1(\master/cmd_ready_reg_334 ),
    .I2(switch_1_IBUF_564),
    .I3(\master/state_reg_FSM_FFd4_494 ),
    .O(N0)
  );
  LUT3 #(
    .INIT ( 8'hEA ))
  \master/state_reg_FSM_FFd1-In  (
    .I0(N0),
    .I1(\master/state_reg_FSM_FFd12_488 ),
    .I2(\master/mode_stop_reg_420 ),
    .O(\master/state_reg_FSM_FFd1-In_483 )
  );
  LUT4 #(
    .INIT ( 16'hFFA8 ))
  \master/state_reg_FSM_FFd3-In  (
    .I0(\master/state_reg_FSM_FFd3_492 ),
    .I1(\master/state_reg_cmp_gt0000 ),
    .I2(\master/bit_count_reg [0]),
    .I3(N2),
    .O(\master/state_reg_FSM_FFd3-In_493 )
  );
  LUT4 #(
    .INIT ( 16'hB9A0 ))
  \master/bit_count_reg_mux0000<1>1  (
    .I0(\master/bit_count_reg [1]),
    .I1(\master/bit_count_reg [0]),
    .I2(\master/N3 ),
    .I3(\master/phy_read_bit_or0000 ),
    .O(\master/bit_count_reg_mux0000 [1])
  );
  LUT3 #(
    .INIT ( 8'hFE ))
  \master/bit_count_reg_mux0000<3>3  (
    .I0(\master/state_reg_FSM_FFd2_490 ),
    .I1(\master/state_reg_FSM_FFd8_496 ),
    .I2(\master/state_reg_FSM_FFd4_494 ),
    .O(\master/bit_count_reg_mux0000<3>3_329 )
  );
  LUT4 #(
    .INIT ( 16'hAAA8 ))
  \master/bit_count_reg_mux0000<3>211  (
    .I0(\master/bit_count_reg [3]),
    .I1(\master/Msub_bit_count_reg_addsub0000_cy [2]),
    .I2(\master/bit_count_reg_mux0000<3>3_329 ),
    .I3(\master/bit_count_reg_mux0000<3>11_327 ),
    .O(\master/bit_count_reg_mux0000<3>21_328 )
  );
  LUT4 #(
    .INIT ( 16'hFFFE ))
  \master/bit_count_reg_mux0000<3>50  (
    .I0(N70),
    .I1(\master/N14 ),
    .I2(\master/bit_count_reg_mux0000<3>21_328 ),
    .I3(\master/bit_count_reg_mux0000<3>34_330 ),
    .O(\master/bit_count_reg_mux0000 [3])
  );
  LUT4 #(
    .INIT ( 16'hFF28 ))
  \db_button0/steady_reg_not00011  (
    .I0(\db_button0/count_cmp_eq0000 ),
    .I1(button0_IBUF_135),
    .I2(\db_button0/old_209 ),
    .I3(switch_0_IBUF_563),
    .O(\db_button0/steady_reg_not0001 )
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \master/phy_read_bit_or00001  (
    .I0(\master/state_reg_FSM_FFd11_486 ),
    .I1(\master/state_reg_FSM_FFd3_492 ),
    .O(\master/phy_read_bit_or0000 )
  );
  LUT3 #(
    .INIT ( 8'hBA ))
  \master/bit_count_reg_mux0000<0>111  (
    .I0(\master/state_reg_FSM_FFd8_496 ),
    .I1(\master/data_in_ready_reg_336 ),
    .I2(\master/state_reg_FSM_FFd10_484 ),
    .O(\master/state_reg_FSM_FFd10-In )
  );
  LUT3 #(
    .INIT ( 8'h01 ))
  \master/bit_count_reg_mux0000<0>126  (
    .I0(\master/state_reg_FSM_FFd4_494 ),
    .I1(\master/state_reg_FSM_FFd2_490 ),
    .I2(\master/state_reg_FSM_FFd1_482 ),
    .O(\master/bit_count_reg_mux0000<0>126_321 )
  );
  LUT4 #(
    .INIT ( 16'hFEFA ))
  \master/bit_count_reg_mux0000<0>147  (
    .I0(\master/bit_count_reg_mux0000<0>110_320 ),
    .I1(\master/bit_count_reg_mux0000<0>135_322 ),
    .I2(\master/bit_count_reg_mux0000<0>15_323 ),
    .I3(\master/bit_count_reg_mux0000<0>126_321 ),
    .O(\master/N3 )
  );
  LUT3 #(
    .INIT ( 8'h20 ))
  \master/delay_scl_next15  (
    .I0(\master/scl_o_reg_465 ),
    .I1(\master/scl_i_reg_460 ),
    .I2(\master/delay_scl_reg_418 ),
    .O(\master/delay_scl_next15_416 )
  );
  LUT3 #(
    .INIT ( 8'h01 ))
  \master/scl_o_next8  (
    .I0(\master/phy_state_reg [4]),
    .I1(\master/phy_state_reg [7]),
    .I2(\master/phy_state_reg [11]),
    .O(\master/scl_o_next8_464 )
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \master/scl_o_next21  (
    .I0(\master/phy_state_reg [9]),
    .I1(\master/phy_state_reg [0]),
    .O(\master/scl_o_next21_462 )
  );
  LUT4 #(
    .INIT ( 16'hFFFE ))
  \master/scl_o_next26  (
    .I0(\master/phy_state_reg [6]),
    .I1(\master/phy_state_reg [13]),
    .I2(\master/phy_state_reg [2]),
    .I3(\master/scl_o_next21_462 ),
    .O(\master/scl_o_next26_463 )
  );
  LUT4 #(
    .INIT ( 16'hAFA8 ))
  \master/scl_o_next39  (
    .I0(\master/scl_o_reg_465 ),
    .I1(\master/scl_o_next8_464 ),
    .I2(\master/N4 ),
    .I3(\master/scl_o_next26_463 ),
    .O(\master/scl_o_next )
  );
  LUT4 #(
    .INIT ( 16'hFFFE ))
  \master/delay_next<7>114  (
    .I0(\master/phy_state_reg [10]),
    .I1(\master/phy_state_reg [3]),
    .I2(\master/phy_state_reg [9]),
    .I3(\master/phy_state_reg [2]),
    .O(\master/delay_next<7>114_368 )
  );
  LUT3 #(
    .INIT ( 8'hFE ))
  \master/delay_next<7>118  (
    .I0(\master/phy_state_reg [7]),
    .I1(\master/phy_state_reg [4]),
    .I2(\master/phy_state_reg [13]),
    .O(\master/delay_next<7>118_369 )
  );
  LUT4 #(
    .INIT ( 16'h13B3 ))
  \master/phy_state_next<13>1  (
    .I0(\master/phy_stop_bit_458 ),
    .I1(N17),
    .I2(\master/N25 ),
    .I3(N18),
    .O(\master/phy_state_next<13>1_429 )
  );
  LUT4 #(
    .INIT ( 16'h0F0E ))
  \master/phy_state_next<1>18  (
    .I0(\master/phy_state_reg [8]),
    .I1(\master/phy_state_reg [5]),
    .I2(N81),
    .I3(\master/phy_state_reg [12]),
    .O(\master/phy_state_next<1>18_433 )
  );
  LUT4 #(
    .INIT ( 16'h080F ))
  \master/phy_stop_bit  (
    .I0(\master/state_reg_FSM_FFd12_488 ),
    .I1(\master/mode_stop_reg_420 ),
    .I2(\master/state_reg_and0000 ),
    .I3(N22),
    .O(\master/phy_stop_bit_458 )
  );
  LUT3 #(
    .INIT ( 8'hF4 ))
  \master/bit_count_reg_mux0000<3>11  (
    .I0(\master/bus_active_reg_331 ),
    .I1(\master/state_reg_FSM_FFd1_482 ),
    .I2(\master/state_reg_FSM_FFd4_494 ),
    .O(\master/N9 )
  );
  LUT4 #(
    .INIT ( 16'hECA0 ))
  \master/delay_next<9>1  (
    .I0(\master/delay_reg [9]),
    .I1(\master/delay_next_addsub0000 [9]),
    .I2(\master/N0 ),
    .I3(N80),
    .O(\master/delay_next[9] )
  );
  LUT4 #(
    .INIT ( 16'hECA0 ))
  \master/delay_next<6>1  (
    .I0(\master/delay_reg [6]),
    .I1(\master/delay_next_addsub0000 [6]),
    .I2(\master/N0 ),
    .I3(\master/N23 ),
    .O(\master/delay_next[6] )
  );
  LUT4 #(
    .INIT ( 16'hECA0 ))
  \master/delay_next<5>1  (
    .I0(\master/delay_reg [5]),
    .I1(\master/delay_next_addsub0000 [5]),
    .I2(\master/N0 ),
    .I3(\master/N23 ),
    .O(\master/delay_next[5] )
  );
  LUT4 #(
    .INIT ( 16'hECA0 ))
  \master/delay_next<4>1  (
    .I0(\master/delay_reg [4]),
    .I1(\master/delay_next_addsub0000 [4]),
    .I2(\master/N0 ),
    .I3(\master/N23 ),
    .O(\master/delay_next[4] )
  );
  LUT4 #(
    .INIT ( 16'hECA0 ))
  \master/delay_next<3>1  (
    .I0(\master/delay_reg [3]),
    .I1(\master/delay_next_addsub0000 [3]),
    .I2(\master/N0 ),
    .I3(\master/N23 ),
    .O(\master/delay_next[3] )
  );
  LUT4 #(
    .INIT ( 16'hECA0 ))
  \master/delay_next<2>1  (
    .I0(\master/delay_reg [2]),
    .I1(\master/delay_next_addsub0000 [2]),
    .I2(\master/N0 ),
    .I3(\master/N23 ),
    .O(\master/delay_next[2] )
  );
  LUT4 #(
    .INIT ( 16'hECA0 ))
  \master/delay_next<1>1  (
    .I0(\master/delay_reg [1]),
    .I1(\master/delay_next_addsub0000 [1]),
    .I2(\master/N0 ),
    .I3(\master/N23 ),
    .O(\master/delay_next[1] )
  );
  LUT4 #(
    .INIT ( 16'hECA0 ))
  \master/delay_next<16>1  (
    .I0(\master/delay_reg [16]),
    .I1(\master/delay_next_addsub0000 [16]),
    .I2(\master/N0 ),
    .I3(\master/N23 ),
    .O(\master/delay_next[16] )
  );
  LUT4 #(
    .INIT ( 16'hECA0 ))
  \master/delay_next<15>1  (
    .I0(\master/delay_reg [15]),
    .I1(\master/delay_next_addsub0000 [15]),
    .I2(\master/N0 ),
    .I3(\master/N23 ),
    .O(\master/delay_next[15] )
  );
  LUT4 #(
    .INIT ( 16'hECA0 ))
  \master/delay_next<14>1  (
    .I0(\master/delay_reg [14]),
    .I1(\master/delay_next_addsub0000 [14]),
    .I2(\master/N0 ),
    .I3(\master/N23 ),
    .O(\master/delay_next[14] )
  );
  LUT4 #(
    .INIT ( 16'hECA0 ))
  \master/delay_next<13>1  (
    .I0(\master/delay_reg [13]),
    .I1(\master/delay_next_addsub0000 [13]),
    .I2(\master/N0 ),
    .I3(\master/N23 ),
    .O(\master/delay_next[13] )
  );
  LUT4 #(
    .INIT ( 16'hECA0 ))
  \master/delay_next<12>1  (
    .I0(\master/delay_reg [12]),
    .I1(\master/delay_next_addsub0000 [12]),
    .I2(\master/N0 ),
    .I3(\master/N23 ),
    .O(\master/delay_next[12] )
  );
  LUT4 #(
    .INIT ( 16'hECA0 ))
  \master/delay_next<11>1  (
    .I0(\master/delay_reg [11]),
    .I1(\master/delay_next_addsub0000 [11]),
    .I2(\master/N0 ),
    .I3(\master/N23 ),
    .O(\master/delay_next[11] )
  );
  LUT4 #(
    .INIT ( 16'hECA0 ))
  \master/delay_next<10>1  (
    .I0(\master/delay_reg [10]),
    .I1(\master/delay_next_addsub0000 [10]),
    .I2(\master/N0 ),
    .I3(\master/N23 ),
    .O(\master/delay_next[10] )
  );
  LUT4 #(
    .INIT ( 16'hECA0 ))
  \master/delay_next<0>1  (
    .I0(\master/delay_reg [0]),
    .I1(\master/delay_next_addsub0000 [0]),
    .I2(\master/N0 ),
    .I3(\master/N23 ),
    .O(\master/delay_next[0] )
  );
  LUT2 #(
    .INIT ( 4'h1 ))
  \master/delay_next<8>16  (
    .I0(\master/phy_state_reg [6]),
    .I1(\master/phy_state_reg [1]),
    .O(\master/delay_next<8>16_379 )
  );
  LUT4 #(
    .INIT ( 16'h04AE ))
  \master/delay_next<8>125  (
    .I0(\master/phy_state_reg [0]),
    .I1(\master/delay_next<8>16_379 ),
    .I2(N79),
    .I3(\master/phy_start_bit ),
    .O(\master/delay_next<8>125_377 )
  );
  LUT3 #(
    .INIT ( 8'hEC ))
  \master/delay_next<7>24  (
    .I0(\master/phy_state_reg [0]),
    .I1(\master/N15 ),
    .I2(\master/phy_start_bit ),
    .O(\master/delay_next<7>24_371 )
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \master/delay_next<7>25  (
    .I0(\master/phy_stop_bit_458 ),
    .I1(N78),
    .O(\master/delay_next<7>25_372 )
  );
  LUT3 #(
    .INIT ( 8'hAE ))
  \master/sda_o_next40  (
    .I0(\master/phy_state_reg [14]),
    .I1(\master/phy_state_reg [0]),
    .I2(\master/phy_start_bit ),
    .O(\master/sda_o_next40_477 )
  );
  LUT4 #(
    .INIT ( 16'h0080 ))
  \master/sda_o_next203  (
    .I0(\master/bit_count_reg [0]),
    .I1(\master/state_reg_FSM_FFd11_486 ),
    .I2(\master/data_reg [0]),
    .I3(\master/bit_count_reg [2]),
    .O(\master/sda_o_next203_472 )
  );
  LUT4 #(
    .INIT ( 16'h0080 ))
  \master/sda_o_next263  (
    .I0(\master/bit_count_reg [3]),
    .I1(\master/data_reg [7]),
    .I2(\master/state_reg_FSM_FFd11_486 ),
    .I3(N71),
    .O(\master/sda_o_next263_474 )
  );
  LUT4 #(
    .INIT ( 16'hDDDC ))
  \master/sda_o_next267  (
    .I0(\master/bit_count_reg [3]),
    .I1(\master/sda_o_next263_474 ),
    .I2(\master/sda_o_next219_473 ),
    .I3(\master/sda_o_next155_469 ),
    .O(\master/sda_o_next267_475 )
  );
  IBUF   button0_IBUF (
    .I(button0),
    .O(button0_IBUF_135)
  );
  IBUF   button1_IBUF (
    .I(button1),
    .O(button1_IBUF_137)
  );
  IBUF   switch_1_IBUF (
    .I(switch[1]),
    .O(switch_1_IBUF_564)
  );
  IBUF   switch_0_IBUF (
    .I(switch[0]),
    .O(switch_0_IBUF_563)
  );
  OBUF   ram0_cen_b_OBUF (
    .I(analyzer4_clock_OBUF_115),
    .O(ram0_cen_b)
  );
  OBUF   tv_in_clock_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(tv_in_clock)
  );
  OBUF   tv_out_subcar_reset_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(tv_out_subcar_reset)
  );
  OBUF   tv_out_pal_ntsc_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(tv_out_pal_ntsc)
  );
  OBUF   ram1_adv_ld_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(ram1_adv_ld)
  );
  OBUF   ram0_clk_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(ram0_clk)
  );
  OBUF   vga_out_hsync_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(vga_out_hsync)
  );
  OBUF   flash_ce_b_OBUF (
    .I(analyzer4_clock_OBUF_115),
    .O(flash_ce_b)
  );
  OBUF   ram0_oe_b_OBUF (
    .I(analyzer4_clock_OBUF_115),
    .O(ram0_oe_b)
  );
  OBUF   analyzer1_clock_OBUF (
    .I(analyzer4_clock_OBUF_115),
    .O(analyzer1_clock)
  );
  OBUF   ram1_cen_b_OBUF (
    .I(analyzer4_clock_OBUF_115),
    .O(ram1_cen_b)
  );
  OBUF   ram1_oe_b_OBUF (
    .I(analyzer4_clock_OBUF_115),
    .O(ram1_oe_b)
  );
  OBUF   ram0_adv_ld_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(ram0_adv_ld)
  );
  OBUF   disp_rs_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(disp_rs)
  );
  OBUF   ram0_ce_b_OBUF (
    .I(analyzer4_clock_OBUF_115),
    .O(ram0_ce_b)
  );
  OBUF   ac97_sdata_out_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(ac97_sdata_out)
  );
  OBUF   analyzer2_clock_OBUF (
    .I(analyzer4_clock_OBUF_115),
    .O(analyzer2_clock)
  );
  OBUF   ram1_ce_b_OBUF (
    .I(analyzer4_clock_OBUF_115),
    .O(ram1_ce_b)
  );
  OBUF   disp_clock_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(disp_clock)
  );
  OBUF   systemace_oe_b_OBUF (
    .I(analyzer4_clock_OBUF_115),
    .O(systemace_oe_b)
  );
  OBUF   tv_out_blank_b_OBUF (
    .I(analyzer4_clock_OBUF_115),
    .O(tv_out_blank_b)
  );
  OBUF   rs232_rts_OBUF (
    .I(analyzer4_clock_OBUF_115),
    .O(rs232_rts)
  );
  OBUF   tv_out_reset_b_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(tv_out_reset_b)
  );
  OBUF   flash_byte_b_OBUF (
    .I(analyzer4_clock_OBUF_115),
    .O(flash_byte_b)
  );
  OBUF   audio_reset_b_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(audio_reset_b)
  );
  OBUF   tv_in_fifo_read_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(tv_in_fifo_read)
  );
  OBUF   tv_out_clock_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(tv_out_clock)
  );
  OBUF   tv_in_reset_b_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(tv_in_reset_b)
  );
  OBUF   analyzer3_clock_OBUF (
    .I(analyzer4_clock_OBUF_115),
    .O(analyzer3_clock)
  );
  OBUF   systemace_ce_b_OBUF (
    .I(analyzer4_clock_OBUF_115),
    .O(systemace_ce_b)
  );
  OBUF   rs232_txd_OBUF (
    .I(analyzer4_clock_OBUF_115),
    .O(rs232_txd)
  );
  OBUF   flash_reset_b_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(flash_reset_b)
  );
  OBUF   ac97_synch_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(ac97_synch)
  );
  OBUF   flash_we_b_OBUF (
    .I(analyzer4_clock_OBUF_115),
    .O(flash_we_b)
  );
  OBUF   disp_ce_b_OBUF (
    .I(analyzer4_clock_OBUF_115),
    .O(disp_ce_b)
  );
  OBUF   tv_in_fifo_clock_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(tv_in_fifo_clock)
  );
  OBUF   vga_out_vsync_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(vga_out_vsync)
  );
  OBUF   tv_in_i2c_clock_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(tv_in_i2c_clock)
  );
  OBUF   tv_out_i2c_clock_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(tv_out_i2c_clock)
  );
  OBUF   tv_out_hsync_b_OBUF (
    .I(analyzer4_clock_OBUF_115),
    .O(tv_out_hsync_b)
  );
  OBUF   analyzer4_clock_OBUF (
    .I(analyzer4_clock_OBUF_115),
    .O(analyzer4_clock)
  );
  OBUF   ram1_clk_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(ram1_clk)
  );
  OBUF   vga_out_sync_b_OBUF (
    .I(analyzer4_clock_OBUF_115),
    .O(vga_out_sync_b)
  );
  OBUF   disp_data_out_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(disp_data_out)
  );
  OBUF   vga_out_pixel_clock_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(vga_out_pixel_clock)
  );
  OBUF   beep_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(beep)
  );
  OBUF   ram0_we_b_OBUF (
    .I(analyzer4_clock_OBUF_115),
    .O(ram0_we_b)
  );
  OBUF   ram1_we_b_OBUF (
    .I(analyzer4_clock_OBUF_115),
    .O(ram1_we_b)
  );
  OBUF   clock_feedback_out_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(clock_feedback_out)
  );
  OBUF   tv_in_iso_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(tv_in_iso)
  );
  OBUF   disp_reset_b_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(disp_reset_b)
  );
  OBUF   systemace_we_b_OBUF (
    .I(analyzer4_clock_OBUF_115),
    .O(systemace_we_b)
  );
  OBUF   vga_out_blank_b_OBUF (
    .I(analyzer4_clock_OBUF_115),
    .O(vga_out_blank_b)
  );
  OBUF   tv_out_i2c_data_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(tv_out_i2c_data)
  );
  OBUF   disp_blank_OBUF (
    .I(analyzer4_clock_OBUF_115),
    .O(disp_blank)
  );
  OBUF   flash_oe_b_OBUF (
    .I(analyzer4_clock_OBUF_115),
    .O(flash_oe_b)
  );
  OBUF   tv_out_vsync_b_OBUF (
    .I(analyzer4_clock_OBUF_115),
    .O(tv_out_vsync_b)
  );
  OBUF   systemace_address_6_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(systemace_address[6])
  );
  OBUF   systemace_address_5_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(systemace_address[5])
  );
  OBUF   systemace_address_4_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(systemace_address[4])
  );
  OBUF   systemace_address_3_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(systemace_address[3])
  );
  OBUF   systemace_address_2_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(systemace_address[2])
  );
  OBUF   systemace_address_1_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(systemace_address[1])
  );
  OBUF   systemace_address_0_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(systemace_address[0])
  );
  OBUF   vga_out_red_7_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(vga_out_red[7])
  );
  OBUF   vga_out_red_6_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(vga_out_red[6])
  );
  OBUF   vga_out_red_5_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(vga_out_red[5])
  );
  OBUF   vga_out_red_4_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(vga_out_red[4])
  );
  OBUF   vga_out_red_3_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(vga_out_red[3])
  );
  OBUF   vga_out_red_2_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(vga_out_red[2])
  );
  OBUF   vga_out_red_1_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(vga_out_red[1])
  );
  OBUF   vga_out_red_0_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(vga_out_red[0])
  );
  OBUF   tv_out_ycrcb_9_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(tv_out_ycrcb[9])
  );
  OBUF   tv_out_ycrcb_8_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(tv_out_ycrcb[8])
  );
  OBUF   tv_out_ycrcb_7_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(tv_out_ycrcb[7])
  );
  OBUF   tv_out_ycrcb_6_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(tv_out_ycrcb[6])
  );
  OBUF   tv_out_ycrcb_5_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(tv_out_ycrcb[5])
  );
  OBUF   tv_out_ycrcb_4_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(tv_out_ycrcb[4])
  );
  OBUF   tv_out_ycrcb_3_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(tv_out_ycrcb[3])
  );
  OBUF   tv_out_ycrcb_2_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(tv_out_ycrcb[2])
  );
  OBUF   tv_out_ycrcb_1_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(tv_out_ycrcb[1])
  );
  OBUF   tv_out_ycrcb_0_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(tv_out_ycrcb[0])
  );
  OBUF   vga_out_blue_7_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(vga_out_blue[7])
  );
  OBUF   vga_out_blue_6_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(vga_out_blue[6])
  );
  OBUF   vga_out_blue_5_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(vga_out_blue[5])
  );
  OBUF   vga_out_blue_4_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(vga_out_blue[4])
  );
  OBUF   vga_out_blue_3_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(vga_out_blue[3])
  );
  OBUF   vga_out_blue_2_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(vga_out_blue[2])
  );
  OBUF   vga_out_blue_1_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(vga_out_blue[1])
  );
  OBUF   vga_out_blue_0_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(vga_out_blue[0])
  );
  OBUF   ram1_address_18_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(ram1_address[18])
  );
  OBUF   ram1_address_17_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(ram1_address[17])
  );
  OBUF   ram1_address_16_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(ram1_address[16])
  );
  OBUF   ram1_address_15_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(ram1_address[15])
  );
  OBUF   ram1_address_14_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(ram1_address[14])
  );
  OBUF   ram1_address_13_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(ram1_address[13])
  );
  OBUF   ram1_address_12_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(ram1_address[12])
  );
  OBUF   ram1_address_11_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(ram1_address[11])
  );
  OBUF   ram1_address_10_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(ram1_address[10])
  );
  OBUF   ram1_address_9_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(ram1_address[9])
  );
  OBUF   ram1_address_8_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(ram1_address[8])
  );
  OBUF   ram1_address_7_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(ram1_address[7])
  );
  OBUF   ram1_address_6_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(ram1_address[6])
  );
  OBUF   ram1_address_5_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(ram1_address[5])
  );
  OBUF   ram1_address_4_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(ram1_address[4])
  );
  OBUF   ram1_address_3_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(ram1_address[3])
  );
  OBUF   ram1_address_2_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(ram1_address[2])
  );
  OBUF   ram1_address_1_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(ram1_address[1])
  );
  OBUF   ram1_address_0_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(ram1_address[0])
  );
  OBUF   analyzer1_data_15_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer1_data[15])
  );
  OBUF   analyzer1_data_14_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer1_data[14])
  );
  OBUF   analyzer1_data_13_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer1_data[13])
  );
  OBUF   analyzer1_data_12_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer1_data[12])
  );
  OBUF   analyzer1_data_11_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer1_data[11])
  );
  OBUF   analyzer1_data_10_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer1_data[10])
  );
  OBUF   analyzer1_data_9_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer1_data[9])
  );
  OBUF   analyzer1_data_8_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer1_data[8])
  );
  OBUF   analyzer1_data_7_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer1_data[7])
  );
  OBUF   analyzer1_data_6_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer1_data[6])
  );
  OBUF   analyzer1_data_5_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer1_data[5])
  );
  OBUF   analyzer1_data_4_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer1_data[4])
  );
  OBUF   analyzer1_data_3_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer1_data[3])
  );
  OBUF   analyzer1_data_2_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer1_data[2])
  );
  OBUF   analyzer1_data_1_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer1_data[1])
  );
  OBUF   analyzer1_data_0_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer1_data[0])
  );
  OBUF   analyzer2_data_15_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer2_data[15])
  );
  OBUF   analyzer2_data_14_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer2_data[14])
  );
  OBUF   analyzer2_data_13_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer2_data[13])
  );
  OBUF   analyzer2_data_12_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer2_data[12])
  );
  OBUF   analyzer2_data_11_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer2_data[11])
  );
  OBUF   analyzer2_data_10_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer2_data[10])
  );
  OBUF   analyzer2_data_9_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer2_data[9])
  );
  OBUF   analyzer2_data_8_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer2_data[8])
  );
  OBUF   analyzer2_data_7_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer2_data[7])
  );
  OBUF   analyzer2_data_6_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer2_data[6])
  );
  OBUF   analyzer2_data_5_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer2_data[5])
  );
  OBUF   analyzer2_data_4_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer2_data[4])
  );
  OBUF   analyzer2_data_3_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer2_data[3])
  );
  OBUF   analyzer2_data_2_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer2_data[2])
  );
  OBUF   analyzer2_data_1_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer2_data[1])
  );
  OBUF   analyzer2_data_0_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer2_data[0])
  );
  OBUF   analyzer3_data_15_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer3_data[15])
  );
  OBUF   analyzer3_data_14_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer3_data[14])
  );
  OBUF   analyzer3_data_13_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer3_data[13])
  );
  OBUF   analyzer3_data_12_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer3_data[12])
  );
  OBUF   analyzer3_data_11_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer3_data[11])
  );
  OBUF   analyzer3_data_10_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer3_data[10])
  );
  OBUF   analyzer3_data_9_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer3_data[9])
  );
  OBUF   analyzer3_data_8_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer3_data[8])
  );
  OBUF   analyzer3_data_7_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer3_data[7])
  );
  OBUF   analyzer3_data_6_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer3_data[6])
  );
  OBUF   analyzer3_data_5_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer3_data[5])
  );
  OBUF   analyzer3_data_4_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer3_data[4])
  );
  OBUF   analyzer3_data_3_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer3_data[3])
  );
  OBUF   analyzer3_data_2_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer3_data[2])
  );
  OBUF   analyzer3_data_1_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer3_data[1])
  );
  OBUF   analyzer3_data_0_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer3_data[0])
  );
  OBUF   analyzer4_data_15_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer4_data[15])
  );
  OBUF   analyzer4_data_14_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer4_data[14])
  );
  OBUF   analyzer4_data_13_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer4_data[13])
  );
  OBUF   analyzer4_data_12_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer4_data[12])
  );
  OBUF   analyzer4_data_11_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer4_data[11])
  );
  OBUF   analyzer4_data_10_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer4_data[10])
  );
  OBUF   analyzer4_data_9_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer4_data[9])
  );
  OBUF   analyzer4_data_8_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer4_data[8])
  );
  OBUF   analyzer4_data_7_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer4_data[7])
  );
  OBUF   analyzer4_data_6_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer4_data[6])
  );
  OBUF   analyzer4_data_5_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer4_data[5])
  );
  OBUF   analyzer4_data_4_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer4_data[4])
  );
  OBUF   analyzer4_data_3_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer4_data[3])
  );
  OBUF   analyzer4_data_2_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer4_data[2])
  );
  OBUF   analyzer4_data_1_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer4_data[1])
  );
  OBUF   analyzer4_data_0_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(analyzer4_data[0])
  );
  OBUF   ram0_bwe_b_3_OBUF (
    .I(analyzer4_clock_OBUF_115),
    .O(ram0_bwe_b[3])
  );
  OBUF   ram0_bwe_b_2_OBUF (
    .I(analyzer4_clock_OBUF_115),
    .O(ram0_bwe_b[2])
  );
  OBUF   ram0_bwe_b_1_OBUF (
    .I(analyzer4_clock_OBUF_115),
    .O(ram0_bwe_b[1])
  );
  OBUF   ram0_bwe_b_0_OBUF (
    .I(analyzer4_clock_OBUF_115),
    .O(ram0_bwe_b[0])
  );
  OBUF   flash_address_23_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(flash_address[23])
  );
  OBUF   flash_address_22_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(flash_address[22])
  );
  OBUF   flash_address_21_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(flash_address[21])
  );
  OBUF   flash_address_20_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(flash_address[20])
  );
  OBUF   flash_address_19_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(flash_address[19])
  );
  OBUF   flash_address_18_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(flash_address[18])
  );
  OBUF   flash_address_17_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(flash_address[17])
  );
  OBUF   flash_address_16_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(flash_address[16])
  );
  OBUF   flash_address_15_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(flash_address[15])
  );
  OBUF   flash_address_14_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(flash_address[14])
  );
  OBUF   flash_address_13_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(flash_address[13])
  );
  OBUF   flash_address_12_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(flash_address[12])
  );
  OBUF   flash_address_11_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(flash_address[11])
  );
  OBUF   flash_address_10_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(flash_address[10])
  );
  OBUF   flash_address_9_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(flash_address[9])
  );
  OBUF   flash_address_8_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(flash_address[8])
  );
  OBUF   flash_address_7_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(flash_address[7])
  );
  OBUF   flash_address_6_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(flash_address[6])
  );
  OBUF   flash_address_5_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(flash_address[5])
  );
  OBUF   flash_address_4_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(flash_address[4])
  );
  OBUF   flash_address_3_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(flash_address[3])
  );
  OBUF   flash_address_2_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(flash_address[2])
  );
  OBUF   flash_address_1_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(flash_address[1])
  );
  OBUF   flash_address_0_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(flash_address[0])
  );
  OBUF   ram1_bwe_b_3_OBUF (
    .I(analyzer4_clock_OBUF_115),
    .O(ram1_bwe_b[3])
  );
  OBUF   ram1_bwe_b_2_OBUF (
    .I(analyzer4_clock_OBUF_115),
    .O(ram1_bwe_b[2])
  );
  OBUF   ram1_bwe_b_1_OBUF (
    .I(analyzer4_clock_OBUF_115),
    .O(ram1_bwe_b[1])
  );
  OBUF   ram1_bwe_b_0_OBUF (
    .I(analyzer4_clock_OBUF_115),
    .O(ram1_bwe_b[0])
  );
  OBUF   vga_out_green_7_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(vga_out_green[7])
  );
  OBUF   vga_out_green_6_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(vga_out_green[6])
  );
  OBUF   vga_out_green_5_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(vga_out_green[5])
  );
  OBUF   vga_out_green_4_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(vga_out_green[4])
  );
  OBUF   vga_out_green_3_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(vga_out_green[3])
  );
  OBUF   vga_out_green_2_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(vga_out_green[2])
  );
  OBUF   vga_out_green_1_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(vga_out_green[1])
  );
  OBUF   vga_out_green_0_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(vga_out_green[0])
  );
  OBUF   led_7_OBUF (
    .I(analyzer4_clock_OBUF_115),
    .O(led[7])
  );
  OBUF   led_6_OBUF (
    .I(analyzer4_clock_OBUF_115),
    .O(led[6])
  );
  OBUF   led_5_OBUF (
    .I(analyzer4_clock_OBUF_115),
    .O(led[5])
  );
  OBUF   led_4_OBUF (
    .I(analyzer4_clock_OBUF_115),
    .O(led[4])
  );
  OBUF   led_3_OBUF (
    .I(analyzer4_clock_OBUF_115),
    .O(led[3])
  );
  OBUF   led_2_OBUF (
    .I(analyzer4_clock_OBUF_115),
    .O(led[2])
  );
  OBUF   led_1_OBUF (
    .I(analyzer4_clock_OBUF_115),
    .O(led[1])
  );
  OBUF   led_0_OBUF (
    .I(button1_IBUF_137),
    .O(led[0])
  );
  OBUF   ram0_address_18_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(ram0_address[18])
  );
  OBUF   ram0_address_17_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(ram0_address[17])
  );
  OBUF   ram0_address_16_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(ram0_address[16])
  );
  OBUF   ram0_address_15_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(ram0_address[15])
  );
  OBUF   ram0_address_14_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(ram0_address[14])
  );
  OBUF   ram0_address_13_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(ram0_address[13])
  );
  OBUF   ram0_address_12_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(ram0_address[12])
  );
  OBUF   ram0_address_11_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(ram0_address[11])
  );
  OBUF   ram0_address_10_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(ram0_address[10])
  );
  OBUF   ram0_address_9_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(ram0_address[9])
  );
  OBUF   ram0_address_8_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(ram0_address[8])
  );
  OBUF   ram0_address_7_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(ram0_address[7])
  );
  OBUF   ram0_address_6_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(ram0_address[6])
  );
  OBUF   ram0_address_5_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(ram0_address[5])
  );
  OBUF   ram0_address_4_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(ram0_address[4])
  );
  OBUF   ram0_address_3_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(ram0_address[3])
  );
  OBUF   ram0_address_2_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(ram0_address[2])
  );
  OBUF   ram0_address_1_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(ram0_address[1])
  );
  OBUF   ram0_address_0_OBUF (
    .I(analyzer1_data_0_OBUF_79),
    .O(ram0_address[0])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \master/phy_state_reg_15  (
    .C(clock_27mhz_BUFGP_139),
    .D(\master/phy_state_next<15>11 ),
    .R(\db_button0/steady_reg_210 ),
    .Q(\master/phy_state_reg [15])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \master/phy_state_reg_14  (
    .C(clock_27mhz_BUFGP_139),
    .D(\master/phy_state_next<14>11 ),
    .R(\db_button0/steady_reg_210 ),
    .Q(\master/phy_state_reg [14])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \master/phy_state_reg_12  (
    .C(clock_27mhz_BUFGP_139),
    .D(\master/phy_state_next<12>11 ),
    .R(\db_button0/steady_reg_210 ),
    .Q(\master/phy_state_reg [12])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \master/phy_state_reg_11  (
    .C(clock_27mhz_BUFGP_139),
    .D(\master/phy_state_next<11>11 ),
    .R(\db_button0/steady_reg_210 ),
    .Q(\master/phy_state_reg [11])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \master/phy_state_reg_10  (
    .C(clock_27mhz_BUFGP_139),
    .D(\master/phy_state_next<10>11 ),
    .R(\db_button0/steady_reg_210 ),
    .Q(\master/phy_state_reg [10])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \master/phy_state_reg_9  (
    .C(clock_27mhz_BUFGP_139),
    .D(\master/phy_state_next<9>11_441 ),
    .R(\db_button0/steady_reg_210 ),
    .Q(\master/phy_state_reg [9])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \master/phy_state_reg_8  (
    .C(clock_27mhz_BUFGP_139),
    .D(\master/phy_state_next<8>11 ),
    .R(\db_button0/steady_reg_210 ),
    .Q(\master/phy_state_reg [8])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \master/phy_state_reg_7  (
    .C(clock_27mhz_BUFGP_139),
    .D(\master/phy_state_next<7>11 ),
    .R(\db_button0/steady_reg_210 ),
    .Q(\master/phy_state_reg [7])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \master/phy_state_reg_6  (
    .C(clock_27mhz_BUFGP_139),
    .D(\master/phy_state_next<6>11_438 ),
    .R(\db_button0/steady_reg_210 ),
    .Q(\master/phy_state_reg [6])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \master/phy_state_reg_5  (
    .C(clock_27mhz_BUFGP_139),
    .D(\master/phy_state_next<5>11 ),
    .R(\db_button0/steady_reg_210 ),
    .Q(\master/phy_state_reg [5])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \master/phy_state_reg_4  (
    .C(clock_27mhz_BUFGP_139),
    .D(\master/phy_state_next<4>11_436 ),
    .R(\db_button0/steady_reg_210 ),
    .Q(\master/phy_state_reg [4])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \master/phy_state_reg_3  (
    .C(clock_27mhz_BUFGP_139),
    .D(\master/phy_state_next<3>11 ),
    .R(\db_button0/steady_reg_210 ),
    .Q(\master/phy_state_reg [3])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \master/phy_state_reg_2  (
    .C(clock_27mhz_BUFGP_139),
    .D(\master/phy_state_next<2>11_434 ),
    .R(\db_button0/steady_reg_210 ),
    .Q(\master/phy_state_reg [2])
  );
  FDS #(
    .INIT ( 1'b1 ))
  \master/phy_state_reg_0  (
    .C(clock_27mhz_BUFGP_139),
    .D(\master/phy_state_next<0>11_425 ),
    .S(\db_button0/steady_reg_210 ),
    .Q(\master/phy_state_reg [0])
  );
  FDRS #(
    .INIT ( 1'b0 ))
  \master/delay_scl_reg  (
    .C(clock_27mhz_BUFGP_139),
    .D(\master/delay_scl_next19 ),
    .R(\db_button0/steady_reg_210 ),
    .S(\master/delay_scl_next15_416 ),
    .Q(\master/delay_scl_reg_418 )
  );
  FDRS #(
    .INIT ( 1'b0 ))
  \master/delay_reg_7  (
    .C(clock_27mhz_BUFGP_139),
    .D(\master/delay_next<7>80 ),
    .R(\db_button0/steady_reg_210 ),
    .S(\master/delay_next<7>11_367 ),
    .Q(\master/delay_reg [7])
  );
  FDRS #(
    .INIT ( 1'b0 ))
  \master/phy_state_reg_1  (
    .C(clock_27mhz_BUFGP_139),
    .D(\master/phy_state_next<1>13111 ),
    .R(\db_button0/steady_reg_210 ),
    .S(\master/phy_state_next<1>18_433 ),
    .Q(\master/phy_state_reg [1])
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \db_button0/Mcount_count_cy<1>_rt  (
    .I0(\db_button0/count [1]),
    .O(\db_button0/Mcount_count_cy<1>_rt_159 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \db_button0/Mcount_count_cy<2>_rt  (
    .I0(\db_button0/count [2]),
    .O(\db_button0/Mcount_count_cy<2>_rt_161 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \db_button0/Mcount_count_cy<3>_rt  (
    .I0(\db_button0/count [3]),
    .O(\db_button0/Mcount_count_cy<3>_rt_163 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \db_button0/Mcount_count_cy<4>_rt  (
    .I0(\db_button0/count [4]),
    .O(\db_button0/Mcount_count_cy<4>_rt_165 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \db_button0/Mcount_count_cy<5>_rt  (
    .I0(\db_button0/count [5]),
    .O(\db_button0/Mcount_count_cy<5>_rt_167 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \db_button0/Mcount_count_cy<6>_rt  (
    .I0(\db_button0/count [6]),
    .O(\db_button0/Mcount_count_cy<6>_rt_169 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \db_button0/Mcount_count_cy<7>_rt  (
    .I0(\db_button0/count [7]),
    .O(\db_button0/Mcount_count_cy<7>_rt_171 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \db_button0/Mcount_count_cy<8>_rt  (
    .I0(\db_button0/count [8]),
    .O(\db_button0/Mcount_count_cy<8>_rt_173 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \db_button0/Mcount_count_cy<9>_rt  (
    .I0(\db_button0/count [9]),
    .O(\db_button0/Mcount_count_cy<9>_rt_175 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \db_button0/Mcount_count_cy<10>_rt  (
    .I0(\db_button0/count [10]),
    .O(\db_button0/Mcount_count_cy<10>_rt_143 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \db_button0/Mcount_count_cy<11>_rt  (
    .I0(\db_button0/count [11]),
    .O(\db_button0/Mcount_count_cy<11>_rt_145 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \db_button0/Mcount_count_cy<12>_rt  (
    .I0(\db_button0/count [12]),
    .O(\db_button0/Mcount_count_cy<12>_rt_147 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \db_button0/Mcount_count_cy<13>_rt  (
    .I0(\db_button0/count [13]),
    .O(\db_button0/Mcount_count_cy<13>_rt_149 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \db_button0/Mcount_count_cy<14>_rt  (
    .I0(\db_button0/count [14]),
    .O(\db_button0/Mcount_count_cy<14>_rt_151 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \db_button0/Mcount_count_cy<15>_rt  (
    .I0(\db_button0/count [15]),
    .O(\db_button0/Mcount_count_cy<15>_rt_153 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \db_button0/Mcount_count_cy<16>_rt  (
    .I0(\db_button0/count [16]),
    .O(\db_button0/Mcount_count_cy<16>_rt_155 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \db_button0/Mcount_count_cy<17>_rt  (
    .I0(\db_button0/count [17]),
    .O(\db_button0/Mcount_count_cy<17>_rt_157 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \master/Msub_delay_next_addsub0000_cy<0>_rt  (
    .I0(\master/delay_reg [0]),
    .O(\master/Msub_delay_next_addsub0000_cy<0>_rt_270 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \db_button0/Mcount_count_xor<18>_rt  (
    .I0(\db_button0/count [18]),
    .O(\db_button0/Mcount_count_xor<18>_rt_177 )
  );
  LUT2 #(
    .INIT ( 4'hD ))
  \master/state_reg_FSM_FFd3-In_SW0_SW0  (
    .I0(\master/state_reg_FSM_FFd2_490 ),
    .I1(\master/bus_active_reg_331 ),
    .O(N32)
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \master/delay_next<7>801_SW0  (
    .I0(\master/Mcompar_bus_control_next_cmp_gt0000_cy [4]),
    .I1(N75),
    .O(N40)
  );
  LUT3 #(
    .INIT ( 8'hA2 ))
  \master/delay_next<7>801_SW1  (
    .I0(\master/Mcompar_bus_control_next_cmp_gt0000_cy [4]),
    .I1(\master/delay_scl_reg_418 ),
    .I2(\master/delay_next<7>21_370 ),
    .O(N41)
  );
  LUT4 #(
    .INIT ( 16'hCCCA ))
  \master/delay_next<7>801  (
    .I0(N40),
    .I1(N41),
    .I2(\master/delay_next<7>33_373 ),
    .I3(\master/delay_next<7>24_371 ),
    .O(\master/delay_next<7>80 )
  );
  LUT4 #(
    .INIT ( 16'hFFA8 ))
  \master/delay_next<8>161  (
    .I0(\master/Mcompar_bus_control_next_cmp_gt0000_cy [4]),
    .I1(\master/delay_next<8>125_377 ),
    .I2(N76),
    .I3(\master/delay_scl_reg_418 ),
    .O(\master/N0 )
  );
  LUT4 #(
    .INIT ( 16'h0F77 ))
  \master/sda_o_next189_SW0  (
    .I0(\master/data_reg [3]),
    .I1(\master/state_reg_FSM_FFd11_486 ),
    .I2(\master/sda_o_next169_470 ),
    .I3(\master/bit_count_reg [0]),
    .O(N45)
  );
  LUT4 #(
    .INIT ( 16'hAA80 ))
  \master/sda_o_next155  (
    .I0(\master/bit_count_reg [1]),
    .I1(N36),
    .I2(\master/state_reg_FSM_FFd3_492 ),
    .I3(N49),
    .O(\master/sda_o_next155_469 )
  );
  LUT4 #(
    .INIT ( 16'hAFA2 ))
  \master/phy_state_next<0>11  (
    .I0(\master/phy_state_reg [0]),
    .I1(\master/phy_start_bit ),
    .I2(\master/N4 ),
    .I3(\master/phy_state_reg [15]),
    .O(\master/phy_state_next<0>11_425 )
  );
  LUT4 #(
    .INIT ( 16'hF0FD ))
  \master/sda_o_next58  (
    .I0(N43),
    .I1(\master/state_reg_and0000 ),
    .I2(\master/phy_start_bit ),
    .I3(N51),
    .O(\master/sda_o_next58_478 )
  );
  LUT4 #(
    .INIT ( 16'hEA40 ))
  \master/phy_state_next<2>11  (
    .I0(\master/N4 ),
    .I1(\master/phy_start_bit ),
    .I2(\master/phy_state_reg [1]),
    .I3(\master/phy_state_reg [2]),
    .O(\master/phy_state_next<2>11_434 )
  );
  LUT4 #(
    .INIT ( 16'hBFBB ))
  \master/phy_state_next<13>1_SW0  (
    .I0(\db_button0/steady_reg_210 ),
    .I1(\master/phy_state_reg [13]),
    .I2(\master/delay_scl_reg_418 ),
    .I3(\master/Mcompar_bus_control_next_cmp_gt0000_cy [4]),
    .O(N17)
  );
  LUT4 #(
    .INIT ( 16'hBABB ))
  \master/phy_state_next<13>1_SW1  (
    .I0(\db_button0/steady_reg_210 ),
    .I1(\master/phy_state_reg [13]),
    .I2(\master/delay_scl_reg_418 ),
    .I3(\master/Mcompar_bus_control_next_cmp_gt0000_cy [4]),
    .O(N18)
  );
  LUT3 #(
    .INIT ( 8'h01 ))
  \master/sda_o_next2  (
    .I0(\master/phy_state_reg [3]),
    .I1(\master/phy_state_reg [1]),
    .I2(\master/phy_state_reg [0]),
    .O(\master/sda_o_next2_471 )
  );
  LUT4 #(
    .INIT ( 16'hAA8A ))
  \master/sda_o_next27  (
    .I0(\master/sda_o_reg_479 ),
    .I1(\master/delay_scl_reg_418 ),
    .I2(\master/Mcompar_bus_control_next_cmp_gt0000_cy [4]),
    .I3(\master/sda_o_next15_468 ),
    .O(\master/sda_o_next27_476 )
  );
  LUT4 #(
    .INIT ( 16'hFF08 ))
  \master/phy_state_next<1>132_SW0  (
    .I0(\master/state_reg_FSM_FFd4_494 ),
    .I1(\master/cmd_ready_reg_334 ),
    .I2(switch_1_IBUF_564),
    .I3(N53),
    .O(N30)
  );
  LUT4 #(
    .INIT ( 16'h000E ))
  \master/phy_read_bit1  (
    .I0(\master/state_reg_FSM_FFd3_492 ),
    .I1(\master/state_reg_FSM_FFd11_486 ),
    .I2(\master/state_reg_and0000 ),
    .I3(N77),
    .O(\master/phy_read_bit )
  );
  LUT4 #(
    .INIT ( 16'hFDEC ))
  \master/sda_o_next347  (
    .I0(\master/sda_o_next267_475 ),
    .I1(\master/sda_o_next27_476 ),
    .I2(N58),
    .I3(N57),
    .O(\master/sda_o_next )
  );
  LUT4 #(
    .INIT ( 16'h88D8 ))
  \master/delay_next<7>11  (
    .I0(\master/delay_scl_reg_418 ),
    .I1(\master/delay_reg [7]),
    .I2(\master/delay_next_addsub0000 [7]),
    .I3(\master/Mcompar_bus_control_next_cmp_gt0000_cy [4]),
    .O(\master/delay_next<7>11_367 )
  );
  LUT4 #(
    .INIT ( 16'hA2A0 ))
  \master/phy_start_bit2_SW0  (
    .I0(switch_1_IBUF_564),
    .I1(\master/bus_active_reg_331 ),
    .I2(\master/state_reg_FSM_FFd4_494 ),
    .I3(\master/state_reg_FSM_FFd1_482 ),
    .O(N60)
  );
  LUT4 #(
    .INIT ( 16'h080F ))
  \master/phy_start_bit2  (
    .I0(\master/cmd_ready_reg_334 ),
    .I1(N60),
    .I2(N72),
    .I3(N32),
    .O(\master/phy_start_bit )
  );
  MUXF5   \master/sda_o_next305_SW1  (
    .I0(N62),
    .I1(N63),
    .S(\master/sda_o_next58_478 ),
    .O(N58)
  );
  LUT4 #(
    .INIT ( 16'h0F08 ))
  \master/sda_o_next305_SW1_F  (
    .I0(\master/phy_state_reg [1]),
    .I1(\master/phy_write_bit_459 ),
    .I2(\master/N4 ),
    .I3(\master/sda_o_next40_477 ),
    .O(N62)
  );
  LUT3 #(
    .INIT ( 8'h01 ))
  \master/delay_scl_next191_SW0  (
    .I0(\master/phy_state_reg [2]),
    .I1(\master/phy_state_reg [13]),
    .I2(\master/phy_state_reg [6]),
    .O(N64)
  );
  LUT4 #(
    .INIT ( 16'h4404 ))
  \master/delay_scl_next191  (
    .I0(\master/delay_scl_reg_418 ),
    .I1(\master/Mcompar_bus_control_next_cmp_gt0000_cy [4]),
    .I2(N64),
    .I3(\master/phy_state_reg [9]),
    .O(\master/delay_scl_next19 )
  );
  LUT4 #(
    .INIT ( 16'hFFAB ))
  \master/bit_count_reg_mux0000<3>111  (
    .I0(\master/state_reg_FSM_FFd10_484 ),
    .I1(\master/state_reg_FSM_FFd11_486 ),
    .I2(\master/state_reg_FSM_FFd3_492 ),
    .I3(\master/state_reg_FSM_FFd1_482 ),
    .O(\master/bit_count_reg_mux0000<3>11_327 )
  );
  LUT4 #(
    .INIT ( 16'h3F2A ))
  \master/bit_count_reg_mux0000<0>110  (
    .I0(\master/state_reg_FSM_FFd1_482 ),
    .I1(\master/cmd_ready_reg_334 ),
    .I2(switch_1_IBUF_564),
    .I3(\master/state_reg_FSM_FFd4_494 ),
    .O(\master/bit_count_reg_mux0000<0>110_320 )
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  \master/bit_count_reg_mux0000<0>135  (
    .I0(\master/state_reg_FSM_FFd10_484 ),
    .I1(\master/state_reg_FSM_FFd8_496 ),
    .I2(\master/state_reg_FSM_FFd11_486 ),
    .I3(\master/state_reg_FSM_FFd3_492 ),
    .O(\master/bit_count_reg_mux0000<0>135_322 )
  );
  LUT4 #(
    .INIT ( 16'hCEC4 ))
  \master/phy_state_next<15>111  (
    .I0(\master/Mcompar_bus_control_next_cmp_gt0000_cy [4]),
    .I1(\master/phy_state_reg [15]),
    .I2(\master/delay_scl_reg_418 ),
    .I3(\master/phy_state_reg [14]),
    .O(\master/phy_state_next<15>11 )
  );
  LUT4 #(
    .INIT ( 16'hCEC4 ))
  \master/phy_state_next<14>111  (
    .I0(\master/Mcompar_bus_control_next_cmp_gt0000_cy [4]),
    .I1(\master/phy_state_reg [14]),
    .I2(\master/delay_scl_reg_418 ),
    .I3(\master/phy_state_reg [13]),
    .O(\master/phy_state_next<14>11 )
  );
  LUT4 #(
    .INIT ( 16'hCEC4 ))
  \master/phy_state_next<12>111  (
    .I0(\master/Mcompar_bus_control_next_cmp_gt0000_cy [4]),
    .I1(\master/phy_state_reg [12]),
    .I2(\master/delay_scl_reg_418 ),
    .I3(\master/phy_state_reg [11]),
    .O(\master/phy_state_next<12>11 )
  );
  LUT4 #(
    .INIT ( 16'hCEC4 ))
  \master/phy_state_next<11>111  (
    .I0(\master/Mcompar_bus_control_next_cmp_gt0000_cy [4]),
    .I1(\master/phy_state_reg [11]),
    .I2(\master/delay_scl_reg_418 ),
    .I3(\master/phy_state_reg [10]),
    .O(\master/phy_state_next<11>11 )
  );
  LUT4 #(
    .INIT ( 16'hCEC4 ))
  \master/phy_state_next<10>111  (
    .I0(\master/Mcompar_bus_control_next_cmp_gt0000_cy [4]),
    .I1(\master/phy_state_reg [10]),
    .I2(\master/delay_scl_reg_418 ),
    .I3(\master/phy_state_reg [9]),
    .O(\master/phy_state_next<10>11 )
  );
  LUT4 #(
    .INIT ( 16'hCEC4 ))
  \master/phy_state_next<8>111  (
    .I0(\master/Mcompar_bus_control_next_cmp_gt0000_cy [4]),
    .I1(\master/phy_state_reg [8]),
    .I2(\master/delay_scl_reg_418 ),
    .I3(\master/phy_state_reg [7]),
    .O(\master/phy_state_next<8>11 )
  );
  LUT4 #(
    .INIT ( 16'hCEC4 ))
  \master/phy_state_next<7>111  (
    .I0(\master/Mcompar_bus_control_next_cmp_gt0000_cy [4]),
    .I1(\master/phy_state_reg [7]),
    .I2(\master/delay_scl_reg_418 ),
    .I3(\master/phy_state_reg [6]),
    .O(\master/phy_state_next<7>11 )
  );
  LUT4 #(
    .INIT ( 16'hCEC4 ))
  \master/phy_state_next<5>111  (
    .I0(\master/Mcompar_bus_control_next_cmp_gt0000_cy [4]),
    .I1(\master/phy_state_reg [5]),
    .I2(\master/delay_scl_reg_418 ),
    .I3(\master/phy_state_reg [4]),
    .O(\master/phy_state_next<5>11 )
  );
  LUT4 #(
    .INIT ( 16'hCEC4 ))
  \master/phy_state_next<3>111  (
    .I0(\master/Mcompar_bus_control_next_cmp_gt0000_cy [4]),
    .I1(\master/phy_state_reg [3]),
    .I2(\master/delay_scl_reg_418 ),
    .I3(\master/phy_state_reg [2]),
    .O(\master/phy_state_next<3>11 )
  );
  LUT3 #(
    .INIT ( 8'hEA ))
  \master/data_reg_mux0000<7>1  (
    .I0(\master/data_reg [7]),
    .I1(\master/data_in_ready_reg_336 ),
    .I2(\master/state_reg_FSM_FFd10_484 ),
    .O(\master/data_reg_mux0000 [7])
  );
  LUT3 #(
    .INIT ( 8'hEA ))
  \master/data_reg_mux0000<6>1  (
    .I0(\master/data_reg [6]),
    .I1(\master/data_in_ready_reg_336 ),
    .I2(\master/state_reg_FSM_FFd10_484 ),
    .O(\master/data_reg_mux0000 [6])
  );
  LUT3 #(
    .INIT ( 8'hEA ))
  \master/data_reg_mux0000<5>1  (
    .I0(\master/data_reg [5]),
    .I1(\master/data_in_ready_reg_336 ),
    .I2(\master/state_reg_FSM_FFd10_484 ),
    .O(\master/data_reg_mux0000 [5])
  );
  LUT3 #(
    .INIT ( 8'hEA ))
  \master/data_reg_mux0000<4>1  (
    .I0(\master/data_reg [4]),
    .I1(\master/data_in_ready_reg_336 ),
    .I2(\master/state_reg_FSM_FFd10_484 ),
    .O(\master/data_reg_mux0000 [4])
  );
  LUT3 #(
    .INIT ( 8'hEA ))
  \master/data_reg_mux0000<3>1  (
    .I0(\master/data_reg [3]),
    .I1(\master/data_in_ready_reg_336 ),
    .I2(\master/state_reg_FSM_FFd10_484 ),
    .O(\master/data_reg_mux0000 [3])
  );
  LUT3 #(
    .INIT ( 8'hEA ))
  \master/data_reg_mux0000<2>1  (
    .I0(\master/data_reg [2]),
    .I1(\master/data_in_ready_reg_336 ),
    .I2(\master/state_reg_FSM_FFd10_484 ),
    .O(\master/data_reg_mux0000 [2])
  );
  LUT3 #(
    .INIT ( 8'hEA ))
  \master/data_reg_mux0000<1>1  (
    .I0(\master/data_reg [1]),
    .I1(\master/data_in_ready_reg_336 ),
    .I2(\master/state_reg_FSM_FFd10_484 ),
    .O(\master/data_reg_mux0000 [1])
  );
  LUT3 #(
    .INIT ( 8'hEA ))
  \master/data_reg_mux0000<0>1  (
    .I0(\master/data_reg [0]),
    .I1(\master/data_in_ready_reg_336 ),
    .I2(\master/state_reg_FSM_FFd10_484 ),
    .O(\master/data_reg_mux0000 [0])
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \master/state_reg_FSM_ClkEn_inv1  (
    .I0(\master/phy_state_reg [1]),
    .I1(\master/phy_state_reg [0]),
    .O(\master/state_reg_FSM_ClkEn_inv )
  );
  LUT4 #(
    .INIT ( 16'h4440 ))
  \master/sda_o_next305_SW1_G  (
    .I0(\master/delay_scl_reg_418 ),
    .I1(\master/Mcompar_bus_control_next_cmp_gt0000_cy [4]),
    .I2(\master/sda_o_next40_477 ),
    .I3(\master/phy_state_reg [1]),
    .O(N63)
  );
  LUT4 #(
    .INIT ( 16'hF8FA ))
  \master/phy_state_next<1>131111  (
    .I0(\master/phy_state_reg [1]),
    .I1(\master/delay_scl_reg_418 ),
    .I2(\master/delay_next<8>130 ),
    .I3(\master/Mcompar_bus_control_next_cmp_gt0000_cy [4]),
    .O(\master/phy_state_next<1>13111 )
  );
  LUT4 #(
    .INIT ( 16'h0302 ))
  \master/bit_count_reg_mux0000<3>34  (
    .I0(\master/state_reg_FSM_FFd3_492 ),
    .I1(\master/bit_count_reg [3]),
    .I2(\master/Msub_bit_count_reg_addsub0000_cy [2]),
    .I3(\master/state_reg_FSM_FFd11_486 ),
    .O(\master/bit_count_reg_mux0000<3>34_330 )
  );
  LUT4 #(
    .INIT ( 16'h0F02 ))
  \master/data_in_ready_next1  (
    .I0(\master/state_reg_FSM_FFd10_484 ),
    .I1(\master/data_in_ready_reg_336 ),
    .I2(\master/state_reg_and0000 ),
    .I3(\master/state_reg_FSM_FFd8_496 ),
    .O(\master/data_in_ready_next )
  );
  LUT4 #(
    .INIT ( 16'hFE54 ))
  \master/bit_count_reg_mux0000<0>2  (
    .I0(\master/bit_count_reg [0]),
    .I1(\master/state_reg_FSM_FFd11_486 ),
    .I2(\master/state_reg_FSM_FFd3_492 ),
    .I3(\master/N3 ),
    .O(\master/bit_count_reg_mux0000 [0])
  );
  LUT4 #(
    .INIT ( 16'h8ABA ))
  \master/phy_state_next<9>11  (
    .I0(\master/phy_state_reg [9]),
    .I1(\master/delay_scl_reg_418 ),
    .I2(\master/Mcompar_bus_control_next_cmp_gt0000_cy [4]),
    .I3(N15),
    .O(\master/phy_state_next<9>11_441 )
  );
  LUT4 #(
    .INIT ( 16'h8ABA ))
  \master/phy_state_next<6>11  (
    .I0(\master/phy_state_reg [6]),
    .I1(\master/delay_scl_reg_418 ),
    .I2(\master/Mcompar_bus_control_next_cmp_gt0000_cy [4]),
    .I3(N11),
    .O(\master/phy_state_next<6>11_438 )
  );
  LUT4 #(
    .INIT ( 16'h8ABA ))
  \master/phy_state_next<4>11  (
    .I0(\master/phy_state_reg [4]),
    .I1(\master/delay_scl_reg_418 ),
    .I2(\master/Mcompar_bus_control_next_cmp_gt0000_cy [4]),
    .I3(N13),
    .O(\master/phy_state_next<4>11_436 )
  );
  LUT2 #(
    .INIT ( 4'h1 ))
  \master/bit_count_reg_mux0000<2>_SW2  (
    .I0(\master/bit_count_reg [1]),
    .I1(\master/bit_count_reg [0]),
    .O(N66)
  );
  LUT4 #(
    .INIT ( 16'hEC28 ))
  \master/bit_count_reg_mux0000<2>  (
    .I0(\master/phy_read_bit_or0000 ),
    .I1(\master/bit_count_reg [2]),
    .I2(N66),
    .I3(\master/N3 ),
    .O(\master/bit_count_reg_mux0000 [2])
  );
  MUXF5   \master/sda_o_next155_SW0  (
    .I0(N68),
    .I1(N69),
    .S(\master/bit_count_reg [2]),
    .O(N49)
  );
  LUT4 #(
    .INIT ( 16'hA820 ))
  \master/sda_o_next155_SW0_F  (
    .I0(\master/state_reg_FSM_FFd11_486 ),
    .I1(\master/bit_count_reg [0]),
    .I2(\master/data_reg [1]),
    .I3(\master/data_reg [2]),
    .O(N68)
  );
  LUT4 #(
    .INIT ( 16'hA820 ))
  \master/sda_o_next155_SW0_G  (
    .I0(\master/state_reg_FSM_FFd11_486 ),
    .I1(\master/bit_count_reg [0]),
    .I2(\master/data_reg [5]),
    .I3(\master/data_reg [6]),
    .O(N69)
  );
  BUFGP   clock_27mhz_BUFGP (
    .I(clock_27mhz),
    .O(clock_27mhz_BUFGP_139)
  );
  INV   \db_button0/Mcount_count_lut<0>_INV_0  (
    .I(\db_button0/count [0]),
    .O(\db_button0/Mcount_count_lut [0])
  );
  INV   \master/Mcompar_bus_control_next_cmp_gt0000_lut<4>_INV_0  (
    .I(\master/delay_reg [16]),
    .O(\master/Mcompar_bus_control_next_cmp_gt0000_lut [4])
  );
  INV   \master/Msub_delay_next_addsub0000_lut<15>_INV_0  (
    .I(\master/delay_reg [15]),
    .O(\master/Msub_delay_next_addsub0000_lut [15])
  );
  INV   \master/Msub_delay_next_addsub0000_lut<14>_INV_0  (
    .I(\master/delay_reg [14]),
    .O(\master/Msub_delay_next_addsub0000_lut [14])
  );
  INV   \master/Msub_delay_next_addsub0000_lut<13>_INV_0  (
    .I(\master/delay_reg [13]),
    .O(\master/Msub_delay_next_addsub0000_lut [13])
  );
  INV   \master/Msub_delay_next_addsub0000_lut<12>_INV_0  (
    .I(\master/delay_reg [12]),
    .O(\master/Msub_delay_next_addsub0000_lut [12])
  );
  INV   \master/Msub_delay_next_addsub0000_lut<11>_INV_0  (
    .I(\master/delay_reg [11]),
    .O(\master/Msub_delay_next_addsub0000_lut [11])
  );
  INV   \master/Msub_delay_next_addsub0000_lut<10>_INV_0  (
    .I(\master/delay_reg [10]),
    .O(\master/Msub_delay_next_addsub0000_lut [10])
  );
  INV   \master/Msub_delay_next_addsub0000_lut<9>_INV_0  (
    .I(\master/delay_reg [9]),
    .O(\master/Msub_delay_next_addsub0000_lut [9])
  );
  INV   \master/Msub_delay_next_addsub0000_lut<8>_INV_0  (
    .I(\master/delay_reg [8]),
    .O(\master/Msub_delay_next_addsub0000_lut [8])
  );
  INV   \master/Msub_delay_next_addsub0000_lut<7>_INV_0  (
    .I(\master/delay_reg [7]),
    .O(\master/Msub_delay_next_addsub0000_lut [7])
  );
  INV   \master/Msub_delay_next_addsub0000_lut<6>_INV_0  (
    .I(\master/delay_reg [6]),
    .O(\master/Msub_delay_next_addsub0000_lut [6])
  );
  INV   \master/Msub_delay_next_addsub0000_lut<5>_INV_0  (
    .I(\master/delay_reg [5]),
    .O(\master/Msub_delay_next_addsub0000_lut [5])
  );
  INV   \master/Msub_delay_next_addsub0000_lut<4>_INV_0  (
    .I(\master/delay_reg [4]),
    .O(\master/Msub_delay_next_addsub0000_lut [4])
  );
  INV   \master/Msub_delay_next_addsub0000_lut<3>_INV_0  (
    .I(\master/delay_reg [3]),
    .O(\master/Msub_delay_next_addsub0000_lut [3])
  );
  INV   \master/Msub_delay_next_addsub0000_lut<2>_INV_0  (
    .I(\master/delay_reg [2]),
    .O(\master/Msub_delay_next_addsub0000_lut [2])
  );
  INV   \master/Msub_delay_next_addsub0000_lut<1>_INV_0  (
    .I(\master/delay_reg [1]),
    .O(\master/Msub_delay_next_addsub0000_lut [1])
  );
  INV   db_button0_not00001_INV_0 (
    .I(button0_IBUF_135),
    .O(db_button0_not0000)
  );
  INV   \db_button0/count_not00011_INV_0  (
    .I(\db_button0/count_cmp_eq0000 ),
    .O(\db_button0/count_not0001 )
  );
  INV   \master/Mcompar_bus_control_next_cmp_gt0000_lut<4>1_INV_0  (
    .I(\master/delay_reg [16]),
    .O(\master/Mcompar_bus_control_next_cmp_gt0000_lut<4>1 )
  );
  IOBUF   user3_0_IOBUF (
    .I(\master/scl_o_reg_465 ),
    .T(\master/scl_o_reg_465 ),
    .O(N26),
    .IO(user3[0])
  );
  FDS #(
    .INIT ( 1'b1 ))
  \master/scl_o_reg  (
    .C(clock_27mhz_BUFGP_139),
    .D(\master/scl_o_next ),
    .S(\db_button0/steady_reg_210 ),
    .Q(\master/scl_o_reg_465 )
  );
  IOBUF   user3_1_IOBUF (
    .I(\master/sda_o_reg_479 ),
    .T(\master/sda_o_reg_479 ),
    .O(N27),
    .IO(user3[1])
  );
  FDS #(
    .INIT ( 1'b1 ))
  \master/sda_o_reg  (
    .C(clock_27mhz_BUFGP_139),
    .D(\master/sda_o_next ),
    .S(\db_button0/steady_reg_210 ),
    .Q(\master/sda_o_reg_479 )
  );
  LUT4 #(
    .INIT ( 16'hF444 ))
  \master/delay_next<8>1  (
    .I0(\master/delay_scl_reg_418 ),
    .I1(\master/phy_state_reg [6]),
    .I2(\master/N0 ),
    .I3(\master/delay_reg [8]),
    .O(\master/delay_next<8>1_376 )
  );
  LUT4 #(
    .INIT ( 16'hF444 ))
  \master/delay_next<8>2  (
    .I0(\master/delay_scl_reg_418 ),
    .I1(\master/delay_next_addsub0000 [8]),
    .I2(\master/N0 ),
    .I3(\master/delay_reg [8]),
    .O(\master/delay_next<8>2_380 )
  );
  MUXF5   \master/delay_next<8>_f5  (
    .I0(\master/delay_next<8>2_380 ),
    .I1(\master/delay_next<8>1_376 ),
    .S(\master/Mcompar_bus_control_next_cmp_gt0000_cy [4]),
    .O(\master/delay_next[8] )
  );
  LUT4_D #(
    .INIT ( 16'hF444 ))
  \master/state_reg_FSM_FFd3-In_SW0  (
    .I0(\master/bus_active_reg_331 ),
    .I1(\master/state_reg_FSM_FFd2_490 ),
    .I2(\master/N9 ),
    .I3(\master/cmd_ready_next_and0000 ),
    .LO(N70),
    .O(N2)
  );
  LUT4_L #(
    .INIT ( 16'hFFA8 ))
  \master/bit_count_reg_mux0000<0>15  (
    .I0(\master/bus_active_reg_331 ),
    .I1(\master/state_reg_FSM_FFd2_490 ),
    .I2(\master/state_reg_FSM_FFd1_482 ),
    .I3(\master/state_reg_FSM_FFd10-In ),
    .LO(\master/bit_count_reg_mux0000<0>15_323 )
  );
  LUT3_D #(
    .INIT ( 8'hFE ))
  \master/Msub_bit_count_reg_addsub0000_cy<2>11  (
    .I0(\master/bit_count_reg [1]),
    .I1(\master/bit_count_reg [0]),
    .I2(\master/bit_count_reg [2]),
    .LO(N71),
    .O(\master/Msub_bit_count_reg_addsub0000_cy [2])
  );
  LUT3_L #(
    .INIT ( 8'hF7 ))
  \master/phy_state_next<6>1_SW0  (
    .I0(\master/phy_state_reg [1]),
    .I1(\master/phy_write_bit_459 ),
    .I2(\master/phy_start_bit ),
    .LO(N11)
  );
  LUT3_L #(
    .INIT ( 8'h13 ))
  \master/phy_state_next<4>1_SW0  (
    .I0(\master/phy_state_reg [0]),
    .I1(\master/phy_state_reg [3]),
    .I2(\master/phy_start_bit ),
    .LO(N13)
  );
  LUT4_L #(
    .INIT ( 16'hFFF7 ))
  \master/phy_state_next<9>1_SW0  (
    .I0(\master/phy_state_reg [1]),
    .I1(\master/phy_read_bit ),
    .I2(\master/phy_start_bit ),
    .I3(\master/phy_write_bit_459 ),
    .LO(N15)
  );
  LUT2_D #(
    .INIT ( 4'h1 ))
  \master/delay_next<8>1111  (
    .I0(\master/phy_state_reg [0]),
    .I1(\master/phy_state_reg [1]),
    .LO(N72),
    .O(\master/state_reg_and0000 )
  );
  LUT3_L #(
    .INIT ( 8'hBF ))
  \master/phy_stop_bit_SW0  (
    .I0(switch_1_IBUF_564),
    .I1(\master/cmd_ready_reg_334 ),
    .I2(\master/state_reg_FSM_FFd4_494 ),
    .LO(N22)
  );
  LUT2_D #(
    .INIT ( 4'h8 ))
  \master/state_reg_FSM_FFd3-In21  (
    .I0(\master/cmd_ready_reg_334 ),
    .I1(switch_1_IBUF_564),
    .LO(N73),
    .O(\master/cmd_ready_next_and0000 )
  );
  LUT3_D #(
    .INIT ( 8'hFE ))
  \master/state_reg_cmp_gt00001  (
    .I0(\master/bit_count_reg [3]),
    .I1(\master/bit_count_reg [1]),
    .I2(\master/bit_count_reg [2]),
    .LO(N74),
    .O(\master/state_reg_cmp_gt0000 )
  );
  LUT4_L #(
    .INIT ( 16'h0002 ))
  \master/phy_state_next<1>132  (
    .I0(\master/phy_state_reg [1]),
    .I1(\master/phy_read_bit ),
    .I2(\master/phy_start_bit ),
    .I3(\master/phy_write_bit_459 ),
    .LO(\master/N25 )
  );
  LUT4_D #(
    .INIT ( 16'hAA8A ))
  \master/delay_next<7>211  (
    .I0(\master/delay_reg [7]),
    .I1(\master/phy_state_reg [1]),
    .I2(\master/phy_state_reg [6]),
    .I3(\master/phy_state_reg [0]),
    .LO(N75),
    .O(\master/delay_next<7>21_370 )
  );
  LUT4_L #(
    .INIT ( 16'hAAA8 ))
  \master/delay_next<7>33  (
    .I0(\master/phy_state_reg [1]),
    .I1(\master/phy_read_bit ),
    .I2(\master/phy_start_bit ),
    .I3(\master/delay_next<7>25_372 ),
    .LO(\master/delay_next<7>33_373 )
  );
  LUT4_L #(
    .INIT ( 16'hCCCE ))
  \master/sda_o_next15  (
    .I0(\master/phy_state_reg [1]),
    .I1(\master/sda_o_next2_471 ),
    .I2(\master/phy_write_bit_459 ),
    .I3(\master/phy_stop_bit_458 ),
    .LO(\master/sda_o_next15_468 )
  );
  LUT4_L #(
    .INIT ( 16'hECA0 ))
  \master/sda_o_next169  (
    .I0(\master/data_reg [4]),
    .I1(\master/addr_reg[3] ),
    .I2(\master/state_reg_FSM_FFd11_486 ),
    .I3(\master/state_reg_FSM_FFd3_492 ),
    .LO(\master/sda_o_next169_470 )
  );
  LUT4_D #(
    .INIT ( 16'h0001 ))
  \master/phy_state_next<1>117  (
    .I0(N30),
    .I1(\master/phy_read_bit ),
    .I2(\master/phy_write_bit_459 ),
    .I3(\master/phy_start_bit ),
    .LO(N76),
    .O(\master/delay_next<8>130 )
  );
  LUT4_L #(
    .INIT ( 16'h9810 ))
  \master/sda_o_next134_SW0  (
    .I0(\master/bit_count_reg [2]),
    .I1(\master/bit_count_reg [0]),
    .I2(\master/addr_reg[0] ),
    .I3(\master/addr_reg[5] ),
    .LO(N36)
  );
  LUT4_D #(
    .INIT ( 16'hFFFE ))
  \master/phy_write_bit_SW1  (
    .I0(\master/bit_count_reg [3]),
    .I1(\master/bit_count_reg [2]),
    .I2(\master/bit_count_reg [1]),
    .I3(\master/bit_count_reg [0]),
    .LO(N77),
    .O(N43)
  );
  LUT4_D #(
    .INIT ( 16'h0E00 ))
  \master/phy_write_bit  (
    .I0(\master/state_reg_FSM_FFd3_492 ),
    .I1(\master/state_reg_FSM_FFd11_486 ),
    .I2(\master/state_reg_and0000 ),
    .I3(N43),
    .LO(N78),
    .O(\master/phy_write_bit_459 )
  );
  LUT4_L #(
    .INIT ( 16'h5504 ))
  \master/sda_o_next219  (
    .I0(\master/bit_count_reg [1]),
    .I1(\master/bit_count_reg [2]),
    .I2(N45),
    .I3(\master/sda_o_next203_472 ),
    .LO(\master/sda_o_next219_473 )
  );
  LUT4_D #(
    .INIT ( 16'hFFFE ))
  \master/delay_next<7>1114  (
    .I0(\master/phy_state_reg [11]),
    .I1(\master/phy_state_reg [14]),
    .I2(\master/delay_next<7>118_369 ),
    .I3(\master/delay_next<7>114_368 ),
    .LO(N79),
    .O(\master/N15 )
  );
  LUT4_L #(
    .INIT ( 16'hFFAB ))
  \master/sda_o_next58_SW0  (
    .I0(\master/bit_count_reg [0]),
    .I1(\master/state_reg_FSM_FFd3_492 ),
    .I2(\master/state_reg_FSM_FFd11_486 ),
    .I3(\master/state_reg_cmp_gt0000 ),
    .LO(N51)
  );
  LUT2_D #(
    .INIT ( 4'h1 ))
  \master/delay_next<7>21  (
    .I0(\master/delay_scl_reg_418 ),
    .I1(\master/Mcompar_bus_control_next_cmp_gt0000_cy [4]),
    .LO(N80),
    .O(\master/N23 )
  );
  LUT3_L #(
    .INIT ( 8'h8F ))
  \master/phy_state_next<1>132_SW0_SW0  (
    .I0(\master/state_reg_FSM_FFd12_488 ),
    .I1(\master/mode_stop_reg_420 ),
    .I2(\master/phy_state_reg [1]),
    .LO(N53)
  );
  LUT2_D #(
    .INIT ( 4'hB ))
  \master/phy_state_next<4>111  (
    .I0(\master/delay_scl_reg_418 ),
    .I1(\master/Mcompar_bus_control_next_cmp_gt0000_cy [4]),
    .LO(N81),
    .O(\master/N4 )
  );
  LUT4_L #(
    .INIT ( 16'h3230 ))
  \master/sda_o_next305_SW0  (
    .I0(\master/phy_state_reg [1]),
    .I1(\master/N4 ),
    .I2(\master/sda_o_next40_477 ),
    .I3(\master/sda_o_next58_478 ),
    .LO(N57)
  );
endmodule


`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

    wire GSR;
    wire GTS;
    wire PRLD;

    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule

