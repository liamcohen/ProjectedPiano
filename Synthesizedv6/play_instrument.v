`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:17:07 12/10/2017 
// Design Name: 
// Module Name:    play_instrument 
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
module play_instrument#(RECORDING_LEN = 16384)

(
   input wire clock,	           // 27mhz system clock
   input wire reset,                // 1 to reset to initial state
   input wire playback,             // 1 for playback, 0 for record
   input wire ready,                // 1 when AC97 data is available
   input wire [18:0] address_in,
   input wire [7:0] from_ac97_data, // 8-bit PCM data from mic
   output reg [7:0] to_ac97_data,  // 8-bit PCM data to headphone
   output reg we_ZBT,
   input wire [35:0] data_in, //audio data for writing to ZBT
   output reg [35:0] data_out, //audio data from reading ZBT
   output reg [18:0] address,   //ZBT address
   output reg [7:0] led);
	 
   reg started = 0;

   reg [1:0] counter = 0;

   
   reg [LOGSIZE-1:0] highest_address;

   always @ (posedge clock) begin
      //led<= 8'b11111111;
      mode <= playback;
         if (~started) begin
	    address <= start_address;
	    counter <= 0;
	 end
	 we_ZBT <= 1; //don't write to memory just read it
	 //led[1:0]<= ~2'b10;
	 if (ready)begin
	    counter <= counter + 1;
	    if (address == address_in + RECORDING_LEN) begin
	       counter <= 0;
	       address <= address_in;
	    end

	    else if (counter == 3) begin 
			   
	       address <= address + 1;
	       to_ac97_data <= data_in;
	    end
	       data_out <= 36'hZ;
	end
   end


endmodule
