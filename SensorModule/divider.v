`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:57:34 10/13/2016 
// Design Name: 
// Module Name:    divider 
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
module divider(
    input clk,
	 input reset,
    output clk_1000Hz
    ); //1000Hz enable --> on for a pulse every millisecond
	 parameter CLOCK_PERIOD = 27000; //27Mhz clock 
	
	reg [16:0] counter; //32-bit counter to reduce clock period
	reg clk_1000Hz_reg;
	
	always @(posedge clk) begin
		if(counter < CLOCK_PERIOD - 1) begin
			counter <= counter + 1;
			clk_1000Hz_reg <= 0;
		end
		else if(counter >= CLOCK_PERIOD - 1) begin
			clk_1000Hz_reg <= 1;
			counter <= 0;
		end
		else if(reset) begin
			clk_1000Hz_reg <= 0;
			counter <= 0;
		end
		else begin 
			clk_1000Hz_reg <= 0;
			counter <= 0;
		end
	end
	
	assign clk_1000Hz = clk_1000Hz_reg;

endmodule
