`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:43:24 11/09/2017 
// Design Name: 
// Module Name:    left_key 
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
module left_key
   #(parameter WIDTH = 64,            // default width: 64 pixels
               HEIGHT = 64,           // default height: 64 pixels
               BLACK_KEY_HEIGHT = 64,  // default black key height: 64 pixels
               BLACK_KEY_WIDTH = 15,   // default black key width: 15 pixels
               WHITE_KEY_WIDTH = 90)   // default white key width: 90 pixels
   (input [10:0] x, hcount,
    input [9:0] y, vcount,
	 input [23:0] color,
    output reg [23:0] pixel
    );
    
    always @ * begin
      if ((hcount >= (x+WHITE_KEY_WIDTH-BLACK_KEY_WIDTH)) && (vcount < (y+BLACK_KEY_HEIGHT))) pixel = 0;
      else if ((hcount >= x && hcount < (x+WIDTH)) && (vcount >= y && vcount < (y+HEIGHT))) pixel = color;
      else pixel = 0;
   end

endmodule