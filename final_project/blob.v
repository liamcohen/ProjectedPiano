`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:38:22 10/03/2017 
// Design Name: 
// Module Name:    blob 
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
//////////////////////////////////////////////////////////////////////
//
// blob: generate rectangle on screen
//
//////////////////////////////////////////////////////////////////////
module blob
   #(parameter WIDTH = 64,            // default width: 64 pixels
               HEIGHT = 64)           // default height: 64 pixels
   (input [10:0] x,hcount,
    input [9:0] y,vcount,
	 input [23:0] color,
    output reg [23:0] pixel);

   always @ * begin
      if ((hcount >= x && hcount < (x+WIDTH)) && (vcount >= y && vcount < (y+HEIGHT))) pixel = color;
      else pixel = 0;
   end
endmodule
