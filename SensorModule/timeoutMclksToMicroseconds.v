`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:02:04 12/08/2017 
// Design Name: 
// Module Name:    timeoutMclksToMicroseconds 
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
module timeoutMclksToMicroseconds(
	 input clk,
    input reset,
    input start,
    output done, 
	 
    input [15:0] timeout_period_mclks,
    input [7:0] vcsel_period_pclks,
    output [31:0] timeout_period_us
    );
	 
	 //define states
	 parameter S_RESET = 2'b00;
	 parameter S_CONVERT_0 = 2'b01;
	 parameter S_CONVERT_1 = 2'b10;
	 parameter S_DONE = 2'b11;
	 
	 //define tmp registers
	 reg [31:0] macro_period_ns = 0;
	 
	 //define output registers
	 reg done_reg = 1'b0;
	 reg [31:0] timeout_period_us_reg = 0;
	 
	 //define state register
	 reg [1:0] state = 2'b00;
	 
	 always @(posedge clk) begin
		case(state)
			S_RESET: begin
				if(start) state <= S_CONVERT_0;
				else state <= S_RESET;
				
				timeout_period_us_reg <= 1'b0;
				done_reg <= 1'b0;
				macro_period_ns <= 0;
			end
			S_CONVERT_0: begin
				macro_period_ns <= (((2304 * vcsel_period_pclks * 1655) + 500) * 66) >> 16;
				state <= S_CONVERT_1;
			end
			S_CONVERT_1: begin
				timeout_period_us_reg <= (((timeout_period_mclks * macro_period_ns) + (macro_period_ns >> 2)) * 66) >> 16;
				state <= S_DONE;
			end
			S_DONE: begin
				done_reg <= 1'b1;
				state <= S_RESET;
			end
		endcase
	 end

	assign done = done_reg;
	assign timeout_period_us = timeout_period_us_reg;

endmodule
