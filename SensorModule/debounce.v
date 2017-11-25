`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:40:34 09/22/2016 
// Design Name: 
// Module Name:    debounce 
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
module debounce #(parameter DELAY=270000-1) (
	input reset,
	input clock,
	input bouncey,
	output steady
	);
	
	reg [18:0] count;
	reg old;
	reg steady_reg;
	
	always @(posedge clock) begin
		if(reset) begin
			count <= 0;
			old <= bouncey;
			steady_reg <= bouncey;
		end
		else if(bouncey != old) begin
			old <= bouncey;
			count <= 0;
		end
		else if(count == DELAY) begin
			steady_reg <= old;
		end
		else count <= count + 1;
	end
	assign steady = steady_reg;
endmodule
