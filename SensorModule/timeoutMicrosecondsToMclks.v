`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:27:30 12/08/2017 
// Design Name: 
// Module Name:    timeoutMicrosecondsToMclks 
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
module timeoutMicrosecondsToMclks(
	 input clk,
    input reset,
    input start,
    output done, 
	 
    output [15:0] timeout_period_mclks,
    input [7:0] vcsel_period_pclks,
    input [31:0] timeout_period_us
    );
	 
	 //define states
	 parameter S_RESET = 3'b000;
	 parameter S_CONVERT_0 = 3'b001;
	 parameter S_CONVERT_1 = 3'b010;
	 parameter S_CONVERT_2 = 3'b011;
	 parameter S_CONVERT_3 = 3'b100;
	 parameter S_DONE = 3'b101;
	 
	 //define tmp registers
	 reg [31:0] macro_period_ns = 0;
	 reg [31:0] tmp0 = 0;
	 
	 //define output registers
	 reg done_reg = 1'b0;
	 reg [31:0] timeout_period_mclks_reg = 0;
	 
	 //define state register
	 reg [2:0] state = 3'b000;
	 
	 //instantiate divider
	 wire divider_ready_for_data;
	 reg [31:0] dividend_reg;
	 reg [31:0] divisor_reg;
	 wire [31:0] quotient;
	 wire [31:0] remainder;
	 
	 divider_module divider(
		.clk(clk),
		.rfd(divider_ready_for_data),
		
		.dividend(dividend_reg),
		.divisor(divisor_reg),
		.quotient(quotient),
		.remainder(remainder)
	 );
	 
	 always @(posedge clk) begin
		case(state)
			S_RESET: begin
				if(start) state <= S_CONVERT_0;
				else state <= S_RESET;
				
				timeout_period_mclks_reg <= 1'b0;
				done_reg <= 1'b0;
				macro_period_ns <= 0;
				tmp0 <= 0;
			end
			S_CONVERT_0: begin
				macro_period_ns <= (((2304 * vcsel_period_pclks * 1655) + 500) * 66) >> 16;
				state <= S_CONVERT_1;
			end
			S_CONVERT_1: begin
				tmp0 <= ((timeout_period_us * 1000) + (macro_period_ns >> 2));
				state <= S_CONVERT_2;
			end
			S_CONVERT_2: begin
				dividend_reg <= tmp0;
				divisor_reg <= macro_period_ns;
				state <= S_CONVERT_3;
			end
			S_CONVERT_3: begin
				timeout_period_mclks_reg <= quotient;
				state <= S_DONE;
			end
			S_DONE: begin
				done_reg <= 1'b1;
				state <= S_RESET;
			end
		endcase
	 end

	assign done = done_reg;
	assign timeout_period_mclks = timeout_period_mclks_reg;

endmodule

