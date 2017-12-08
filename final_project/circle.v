`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:11:06 12/08/2017 
// Design Name: 
// Module Name:    circle 
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
module circle
   #(parameter RADIUS = 35)            // default radius: 35 pixels
   (input [10:0] x,hcount,
    input [9:0] y,vcount,
	 input [23:0] color,
    output reg [23:0] pixel);

   reg [10:0] x_length;
	reg [9:0] y_length;
	
	always @ * begin
      x_length <= hcount - x;
		y_length <= vcount - y;
		
		if ((((x_length - RADIUS) * (x_length - RADIUS)) + ((y_length - RADIUS) * (y_length - RADIUS))) <= (RADIUS * RADIUS)) pixel <= color;
		else pixel <= 0;
		
   end
endmodule
