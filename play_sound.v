`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:42:22 11/20/2017 
// Design Name: 
// Module Name:    play_sound 
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
module play_sound(
    input [16:0] key_num,
	 input clock,
    output [7:0] to_ac97_data
    );
	 wire new_ready;
	 wire [19:0] tone;
	 ready_generator generator(.clk(clock),.restart(0),.key_num(key_num),.ready(new_ready));
    tone750hz xxx(.clock(clock),.ready(new_ready),.pcm_data(tone));
	 
	 assign to_ac97_data = (key_num[16:0] == 0) ? 8'b0:tone[19:12];

endmodule
