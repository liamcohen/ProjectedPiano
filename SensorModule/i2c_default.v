`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:02:53 11/20/2017 
// Design Name: 
// Module Name:    i2c_default 
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
// The purpose of this module is guarantee that the I2C master's inputs are always
// well defined.
//
//////////////////////////////////////////////////////////////////////////////////
module i2c_default(
	 input clk,
	 input reset,

    output [6:0] cmd_address,
    output cmd_start,
    output cmd_read,
    output cmd_write,
    output cmd_write_multiple,
    output cmd_stop,
    output cmd_valid,
    output [7:0] data_in,
    output data_in_valid,
    output data_in_last,
    output data_out_ready,
	 
    );
	 
	 parameter S_IDLE = 1'b0;
	 parameter S_INACTIVE = 1'b1;
	 
	 //define state registers
	 reg state = 1'b0;
	 
	 //define output registers
	 reg [6:0] cmd_address_reg = 7'b0000000;
	 reg cmd_start_reg = 1'b0;
	 reg cmd_read_reg = 1'b0;
	 reg cmd_write_reg = 1'b0;
	 reg cmd_write_multiple_reg = 1'b0;
	 reg cmd_valid_reg = 1'b0;
	 reg cmd_stop_reg = 1'b0;
	 reg [7:0] data_in_reg = 8'h00;
	 reg data_in_valid_reg = 1'b0;
	 reg data_in_last_reg = 1'b0;
	 reg data_out_ready_reg = 1'b0;
	 
	 always @(posedge clk) begin
		if(reset) state <= S_IDLE;
		case(state)
			S_IDLE: begin
				state <= S_IDLE;
				cmd_address_reg <= 7'b0000000;
				cmd_start_reg <= 1'b0;
				cmd_read_reg <= 1'b0;
				cmd_write_reg <= 1'b0;
				cmd_write_multiple_reg <= 1'b0;
				cmd_stop_reg <= 1'b0;
				cmd_valid_reg <= 1'b0;
				data_in_reg <= 8'h00;
				data_in_valid_reg <= 1'b0;
				data_in_last_reg <= 1'b0;
				data_out_ready_reg <= 1'b0;
			end
			default state <= S_IDLE;
		endcase
	 end
	 
	 assign cmd_address = cmd_address_reg;
	 assign cmd_start = cmd_start_reg;
	 assign cmd_read = cmd_read_reg;
	 assign cmd_write = cmd_write_reg;
	 assign cmd_write_multiple = cmd_write_multiple_reg;
	 assign cmd_stop = cmd_stop_reg;
	 assign cmd_valid = cmd_valid_reg;
	 assign data_in = data_in_reg;
	 assign data_in_valid = data_in_valid_reg;
	 assign data_in_last = data_in_last_reg;
	 assign data_out_ready = data_out_ready_reg;

endmodule
