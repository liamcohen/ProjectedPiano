`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:13:26 11/20/2017 
// Design Name: 
// Module Name:    test_write_multi 
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
module test_write_multi(
     input clk,
     input reset,
     input start,
     output done,
	 
     output [7:0] data_out,
	  output write_en,
	  input full,
	  input write_ack,
	  input overflow
    );
	 
	 //define states
	 parameter S_RESET = 2'b00;
	 parameter S_WRITE_0 = 2'b01;
	 parameter S_WRITE_1 = 2'b10;
	 parameter S_DONE = 2'b11;
	 
	 //define registers
	 reg done_reg = 1'b0;
	 reg [7:0] data_out_reg = 8'h00;
	 reg write_en_reg = 1'b0;
	 
	 //define state register
	 reg [1:0] state = 2'b00;
	 
	 always @(posedge clk) begin
		if(reset) state <= S_RESET;
		if(overflow) state <= S_RESET;
		if(full) state <= S_RESET;
		case(state)
			S_RESET: begin
				if(start) begin
					state <= S_WRITE_0;
				end
				else begin
					state <= S_RESET;
				end
				done_reg <= 1'b0;
				data_out_reg <= 8'h00;
				write_en_reg <= 1'b0;
			end
			S_WRITE_0: begin
				if(write_ack) begin
					state <= S_WRITE_1;
				end
				else begin
					state <= S_WRITE_0;
				end
				data_out_reg <= 8'hAA;
			end
			S_WRITE_1: begin
				if(write_ack) begin
					state <= S_DONE;
				end
				else begin
					state <= S_WRITE_1;
				end
				data_out_reg <= 8'hBB;
			end
			S_DONE: begin
				state <= S_RESET;
				done_reg <= 1'b1;
			end
		endcase
	 end

	assign done = done_reg;
	assign data_out = data_out_reg;
	assign write_en = write_en_reg;

endmodule
