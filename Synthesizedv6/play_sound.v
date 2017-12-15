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
   //inputs and output to load instrument sounds from memory
   //input wire [7:0] from_ac97_data, // 8-bit PCM data from mic
   // output wire we_ZBT,
   //input wire [35:0] data_in, //audio data for writing to ZBT
   // output wire [35:0] data_out, //audio data from reading ZBT
   //output wire [18:0] address
    );
   wire new_ready;
   wire [19:0] tone;
   wire [19:0] tone2;
   reg restart;
   reg [16:0] old_key_num;
	//wire [18:0] address_in; //for instrument sounds

	 
   ready_generator generator(.clk(clock),.restart(restart),.shift(shift),.key_num(key_num),.ready(new_ready));
   
   tone750hz xxx(.clock(clock),.ready(new_ready),.restart(restart),.pcm_data(tone));
	
   //could create a sine wave for an additional note
   //ready_generator generator2(.clk(clock),.restart(restart),.key_num(17'b0_0000_0000_0000_1000),.ready(new_ready2));
   //tone750hz xxx2(.clock(clock),.ready(new_ready2),.restart(restart),.pcm_data(tone2));
	
   //to play instrument sounds code
   //play_instrument instrument_player(.clock(clock),.reset(reset),.ready(ready),
	 //.address_in(address_in),.from_ac97_data(from_ac97_data),//.to_ac97_data(to_ac97_data),
	 //.we_ZBT(we_ZBT),.data_in(data_in),.data_out(data_out),.address(address));

	 
	 
   always @(posedge clock) begin
      if (key_num[16:0] != old_key_num[16:0]) restart <= 1;
      else restart <= 0;
      old_key_num <= key_num[16:0];
	 
      if (state == 3) to_ac97_data[7:0] <= to_ac97_data2;
      else if (key_num[16:0] == 0) to_ac97_data[7:0] <= 8'b0;
      //else if (instrument)  to_ac97_data[7:0] <= data_out[35:28]; //for instrument sounds instead of tone
      else to_ac97_data[7:0] <= tone[19:12];
      //attempt to add 2 sine waves
      //else to_ac97_data[7:0] <= {0,tone[19:13]}+{0,tone2[19:13]};
   end
   //attempt to create a restart signal when key num changes to help syncronize the two sine waves	 
   //assign restart = (key_num[16:0] != old_key_num[16:0] ) ? 1:0;
	 
   //assign old_key_num = key_num[16:0];
	 
   //assign to_ac97_data = (key_num[16:0] == 0) ? 8'b0:(8'b0+tone[19:13]+tone2[19:13]);

endmodule
