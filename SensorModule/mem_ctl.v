`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:31:47 12/07/2017 
// Design Name: 
// Module Name:    mem_ctl 
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
// Memory controller FSM for easy addressing to RAM
// designed around a write-first timing scheme.
//
//////////////////////////////////////////////////////////////////////////////////
module mem_ctl(
	 //FSM inputs 
    input clk,
    input reset,
    input start,
    output done,
	 input rw, //set means write, not set means read
	 
	 //to RAM
	 output mem_wr_en,
    output [7:0] mem_addr,
    input [7:0] mem_data_in,
    output [7:0] mem_data_out,
	 
	 //to logic
    input [7:0] log_mem_addr,
    output [7:0] log_mem_data_in,
    input [7:0] log_mem_data_out
    );
	 
	 //define states
	 parameter S_RESET = 3'b000;
	 parameter S_SET_ADDRESS = 3'b001;
	 parameter S_DATA_IN = 3'b010;
	 parameter S_WR_ENABLE = 3'b011;
	 parameter S_DATA_OUT = 3'b100;
	 parameter S_DONE = 3'b101;
	 
	 //define state register
	 reg [2:0] state = 3'b000;
	 
	 //define output registers
	 reg done_reg = 1'b0;
	 reg mem_wr_en_reg = 1'b0;
	 reg [7:0] mem_addr_reg = 8'h00;
	 reg [7:0] mem_data_out_reg = 8'h00;
	 reg [7:0] log_mem_data_in_reg = 8'h00;
	 
	 always @(posedge clk) begin
		if(reset) state <= S_RESET;
		else begin
			case(state)
				S_RESET: begin
					done_reg <= 1'b0;
					mem_wr_en_reg <= 1'b0;
					mem_addr_reg <= 8'h00;
					mem_data_out_reg <= 8'h00;
					log_mem_data_in_reg <= 8'h00;
					
					if(start) state <= S_SET_ADDRESS;
					else state <= S_RESET;
				end
				S_SET_ADDRESS: begin
					mem_addr_reg <= log_mem_addr;
					state <= S_DATA_IN;
				end
				S_DATA_IN: begin
					mem_data_out_reg <= log_mem_data_out;
					state <= S_WR_ENABLE;
				end
				S_WR_ENABLE: begin
					if(rw) mem_wr_en_reg <= 1'b1;
					else mem_wr_en_reg <= 1'b0;
					state <= S_DATA_OUT;
				end
				S_DATA_OUT: begin
					log_mem_data_in_reg <= mem_data_in;
					state <= S_DONE;
				end
				S_DONE: begin
					done_reg <= 1'b1;
					mem_wr_en_reg <= 1'b0;
					state <= S_RESET;
				end
				//default: state <= S_RESET;
			endcase
		end
	 end

	assign done = done_reg;
	assign mem_wr_en = mem_wr_en_reg;
	assign mem_addr = mem_addr_reg;
	assign mem_data_out = mem_data_out_reg;
	assign log_mem_data_in = log_mem_data_in_reg;

endmodule
