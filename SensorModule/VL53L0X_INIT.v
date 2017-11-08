`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:11:30 11/08/2017 
// Design Name: 
// Module Name:    VL53L0X_INIT 
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
include "i2c_master.v"
include "i2C_init.v"
include "axis_fifo.v"

module #(parameter addr = 7'h29)  VL53L0X_INIT(
    input start,
	 input clk,
	 input reset,
    output done,
    output success
    );
	 
	 //define state transitions
	 parameter S_RESET = 1'b0;
	 parameter S_RUNNING = 1'b1;
	 
	 //define required constants for VL530X initialization
	 parameter VHV_CONFIG_PAD_SCL_SDA__EXTSUP_HV = 8'h89
	 parameter 
	 
	 
	 
endmodule
