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
	 input [7:0] to_ac97_data2,
	 input [1:0] state,
	 input shift,
    output reg [7:0] to_ac97_data
    );
	 wire new_ready;
	 wire [19:0] tone;
	 wire [19:0] tone2;
	 reg restart;
	 reg [16:0] old_key_num;
	 
	 ready_generator generator(.clk(clock),.restart(restart),.shift(shift),.key_num(key_num),.ready(new_ready));
	 //ready_generator generator2(.clk(clock),.restart(restart),.key_num(17'b0_0000_0000_0000_1000),.ready(new_ready2));
    tone750hz xxx(.clock(clock),.ready(new_ready),.restart(restart),.pcm_data(tone));
	 //tone750hz xxx2(.clock(clock),.ready(new_ready2),.restart(restart),.pcm_data(tone2));
	 
	 always @(posedge clock) begin
	    if (key_num[16:0] != old_key_num[16:0]) restart <= 1;
		 else restart <= 0;
		 old_key_num <= key_num[16:0];
		 
		 if (state == 3) to_ac97_data[7:0] <= to_ac97_data2;
		 else if (key_num[16:0] == 0) to_ac97_data[7:0] <= 8'b0;
		 else to_ac97_data[7:0] <= tone[19:12];
		 //else to_ac97_data[7:0] <= {0,tone[19:13]}+{0,tone2[19:13]};
	 end
	 
	 //assign restart = (key_num[16:0] != old_key_num[16:0] ) ? 1:0;
	 
	 //assign old_key_num = key_num[16:0];
	 
	 //assign to_ac97_data = (key_num[16:0] == 0) ? 8'b0:(8'b0+tone[19:13]+tone2[19:13]);

endmodule
