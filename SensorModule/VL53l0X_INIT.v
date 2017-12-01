`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:00:40 11/28/2017 
// Design Name: 
// Module Name:    VL53l0X_INIT 
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
module VL53l0X_INIT(
    input start,
    output done,
    output write_start,
    input write_done,
    output write_multi_start,
    input write_multi_done,
    output read_start,
    input read_done,
    output [7:0] data_out,
    input [7:0] data_in,
    input [3:0] n_bytes
    );


endmodule
