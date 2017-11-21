`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:03:35 11/21/2017 
// Design Name: 
// Module Name:    key_colors 
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
module key_colors(
    input reset,
    input note_ready,
    input [16:0] key_num,
    input clk,
    output reg [23:0] c_color, db_color, d_color, eb_color, e_color, f_color,
				gb_color, g_color, ab_color, a_color, bb_color, b_color,
				high_c_color, high_db_color, high_d_color, high_eb_color, high_e_color
    );
	
	parameter BLACK = 24'h00_00_00;
	parameter RED = 24'hFF_00_00;
	parameter WHITE = 24'hFF_FF_FF;
	
	always @(posedge clk)
	begin
		if (note_ready)
		begin
		
			if (key_num[16]) c_color <= RED;
			else c_color <= WHITE;
			
			if (key_num[15]) db_color <= RED;
			else db_color <= BLACK;
			
			if (key_num[14]) d_color <= RED;
			else d_color <= WHITE;
			
			if (key_num[13]) eb_color <= RED;
			else eb_color <= BLACK;
			
			if (key_num[12]) e_color <= RED;
			else e_color <= WHITE;
			
			if (key_num[11]) f_color <= RED;
			else f_color <= WHITE;
			
			if (key_num[10]) gb_color <= RED;
			else gb_color <= BLACK;
			
			if (key_num[9]) g_color <= RED;
			else g_color <= WHITE;
			
			if (key_num[8]) ab_color <= RED;
			else ab_color <= BLACK;
			
			if (key_num[7]) a_color <= RED;
			else a_color <= WHITE;
			
			if (key_num[6]) bb_color <= RED;
			else bb_color <= BLACK;
			
			if (key_num[5]) b_color <= RED;
			else b_color <= WHITE;
			
			if (key_num[4]) high_c_color <= RED;
			else high_c_color <= WHITE;
			
			if (key_num[3]) high_db_color <= RED;
			else high_db_color <= BLACK;
			
			if (key_num[2]) high_d_color <= RED;
			else high_d_color <= WHITE;
			
			if (key_num[1]) high_eb_color <= RED;
			else high_eb_color <= BLACK;
			
			if (key_num[0]) high_e_color <= RED;
			else high_e_color <= WHITE;
			
		end
	end

endmodule
