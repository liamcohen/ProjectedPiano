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
	  input restart,
     output done,
	 
     output [7:0] data_out,
	  output write_en,
	  output ext_reset,
	  input full,
	  input write_ack,
	  input overflow
    );
	 
	 //define states
	 parameter S_RESET = 3'b000;
	 parameter S_WRITE_0 = 3'b001;
	 parameter S_WRITE_1 = 3'b010;
	 parameter S_DONE_0 = 3'b011;
	 parameter S_DONE_1 = 3'b100;
	 
	 //define registers
	 reg done_reg = 1'b0;
	 reg [7:0] data_out_reg = 8'h00;
	 reg write_en_reg = 1'b0;
	 reg ext_reset_reg = 1'b1;
	 
	 //define state register
	 reg [2:0] state = 3'b000;
	 
	 always @(posedge clk) begin
		if(reset) state <= S_RESET;
		else if(overflow) state <= S_RESET;
		else if(full) state <= S_RESET;
		else begin
			case(state)
				S_RESET: begin
					if(start) begin
						state <= S_WRITE_0;
						ext_reset_reg <= 1'b0;
						data_out_reg <= 8'hAA;
						write_en_reg <= 1'b1;
					end
					else begin
						state <= S_RESET;
						ext_reset_reg <= 1'b1;
						data_out_reg <= 8'h00;
						write_en_reg <= 1'b0;
					end
					done_reg <= 1'b0;
				end
				S_WRITE_0: begin
					if(write_ack) begin
						state <= S_WRITE_1;
						write_en_reg <= 1'b1;
						data_out_reg <= 8'hBB;
					end
					else begin
						state <= S_WRITE_0;
						write_en_reg <= 1'b0;
						data_out_reg <= 8'hAA;
					end
				end
				S_WRITE_1: begin
					if(write_ack) begin
						state <= S_DONE_0;
						data_out_reg <= 8'h00;
					end
					else begin
						state <= S_WRITE_1;
						data_out_reg <= 8'hBB;
					end
					write_en_reg <= 1'b0;
				end
				S_DONE_0: begin
					state <= S_DONE_1;
					done_reg <= 1'b1;
					write_en_reg <= 1'b0;
				end
				S_DONE_1: begin
					if(restart) state <= S_RESET;
					else state <= S_DONE_1;
					done_reg <= 1'b0;
				end
			endcase
		end
	 end

	assign done = done_reg;
	assign data_out = data_out_reg;
	assign write_en = write_en_reg;
	assign ext_reset = ext_reset_reg;

endmodule
