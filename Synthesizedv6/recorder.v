`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:41:29 12/09/2017 
// Design Name: 
// Module Name:    recorder 
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
module recorder#(parameter LOGSIZE=19, WIDTH=36,MAX_MEM_ADDR = 2**LOGSIZE-1,RECORDING_LEN = 32768)

   (input wire clock,	           // 27mhz system clock
   input wire reset,                // 1 to reset to initial state
   input wire record,             
   input wire ready,                // 1 when AC97 data is available
	input wire [18:0] address_in,
   input wire [7:0] from_ac97_data, // 8-bit PCM data from mic
   output reg [7:0] to_ac97_data,  // 8-bit PCM data to headphone
   output reg we_ZBT,
	input wire [35:0] data_in, //audio data for writing to ZBT
	output reg [35:0] data_out, //audio data from reading ZBT
	output reg [18:0] address,   //ZBT address
	output reg [7:0] led,
	output reg done_prev,
	output reg recording_done);  
 
   // test: playback 750hz tone, or loopback using incoming data
   //reg [LOGSIZE-1:0] address;
   reg mode;
   //wire [19:0] tone;
   reg [1:0] counter = 0;
	//reg [10:3] counter2 = 0;
   reg send = 0;
   
	reg [LOGSIZE-1:0] highest_address;
   reg we;
   //reg [7:0] din = 8'b0;
   //wire [7:0] dout;	
   //reg [7:0] filter_input = 8'b0;
   //wire [17:0] filter_output;
	
   //tone750hz xxx(.clock(clock),.ready(ready),.pcm_data(tone));
	
	
   //mybram #(.LOGSIZE(LOGSIZE),.WIDTH(WIDTH))
   //record_samples(.addr(address),.clk(clock),.we(we),.din(din),.dout(dout));
				
   //fir31 filter2(.clock(clock),.reset(reset),.ready(ready),.x(filter_input),.y(filter_output));
   
	reg started = 0;

   always @ (posedge clock) begin
      //led<= 8'b11111111;
		done_prev <= recording_done;
		if (~started) begin
		    address <= address_in;
			 counter <= 0;
			 started <= 1;
	   end
	//Record Mode
	  if ((address >= (address_in + RECORDING_LEN)) & ~recording_done) begin
	     recording_done <= 1;
			we_ZBT <= 1; //don't write to memory
		end
		else recording_done <= 0;
		if (ready & record) begin
		   to_ac97_data <= from_ac97_data;
			data_out <= from_ac97_data;
			counter <= counter + 1;
			if (counter == 3) begin
			   we_ZBT <= 0; //write to memory
				address <= address + 1; 
				led[7:0] <= address[18:12];
				highest_address <= address + 1; 
			end
			else we_ZBT <= 1; // don't write to memory if not 8th sample	 
		end
   end
endmodule

