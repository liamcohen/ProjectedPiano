`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:05:52 11/06/2017 
// Design Name: 
// Module Name:    CommModule 
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

//I2C clock should be 375kHz which corresponds a prescale of 18 
//for our I2C module.

module CommModule(
     input request_data,
     output data_ready,
     inout sda,
     inout scl,
     output [7:0] data_out,
     input meas_ready,
	  input reset
    );
	 

endmodule
