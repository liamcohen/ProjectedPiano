`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:29:27 12/05/2017 
// Design Name: 
// Module Name:    sound 
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
module sound(
    input clock,
    input reset,
    input playback,
    input record,
    input ready,
    input we_ZBT,
    input [35:0] data_in,
    input [35:0] data_out,
    input [18:0] address,
    input [16:0] key_num,
	 input [1:0] state,
    output [16:0] key_num_fsm,
    output [7:0] to_ac97_data
    );

    wire [16:0] key_num_fsm2;
fsm fsm2(.clock(clock), .reset(reset), .ready(ready),
              .playback(playback), .record(record),
				  .we_ZBT(we_ZBT), .data_in(data_in[35:0]),
				  .data_out(data_out[35:0]), .address(address[18:0]),
				  .key_num(key_num[16:0]),.key_num_fsm(key_num_fsm2[16:0]),
				  .state(state[1:0]));
				  
play_sound player(.clock(clock),.key_num(key_num_fsm2[16:0]),.to_ac97_data(to_ac97_data));

assign key_num_fsm[16:0] = key_num_fsm2;

endmodule
