`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:46:50 11/28/2017 
// Design Name: 
// Module Name:    load_fifo 
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
module load_fifo_from_rom(
	 input reset,
	 input clk,
	 input start,
	 output done,
	 
	 input [7:0] n_loads,
    output [7:0] fifo_data_out,
	 output 
    output fifo_wr_en,
    output fifo_ext_reset,
    input fifo_full,
    input fifo_write_ack,
    input fifo_overflow,
    output [7:0] rom_addr,
    input [15:0] rom_data
    );
	 
	 //define states
	 parameter S_RESET = 2'b00;
	 parameter S_READ_ROM = 2'b01;
	 parameter S_WRITE_FIFO = 2'b10;
	 parameter S_DONE = 2'b11;
	 
	 //define state registers and counters
	 reg [1:0] state = 2'b00;
	 
	 //define output registers
	 reg done_reg = 1'b0;
	 reg [7:0] fifo_data_out_reg = 8'h00;
	 reg fifo_ext_reset_reg = 1'b1;
	 reg [7:0] rom_addr_reg = 8'h00;
	 
	 always @(posedge clk) begin
		if(reset) state <= S_RESET;
		else begin
			case(state)
				S_RESET: begin
					if(start) state <= S_READ_ROM:
					else state <= S_RESET;
					
					done_reg <= 1'b0;
					fifo_data_out_reg <= 8'h00;
					fifo_ext_reset_reg <= 1'b1;
					rom_addr_reg <= 8'h00;
				end
				S_READ_ROM: begin
					fifo_data_out_reg <= rom_data;
					rom_addr_reg <= rom_addr_reg + 1;
				end
				S_WRITE_FIFO:
				S_DONE:
			endcase
		end
	 end
	 
	 
	 //assign registers to outputs
	 assign done = done_reg;
	 assign fifo_data_out = fifo_data_out_reg;
	 assign fifo_ext_reset = fifo_ext_reset_reg;
	 assign rom_addr = rom_addr_reg;


endmodule
