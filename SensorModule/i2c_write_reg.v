`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:50:13 11/12/2017 
// Design Name: 
// Module Name:    i2c_write_reg 
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
module i2c_write_reg(
   //data inputs
	 input [6:0] dev_address,
	 input [7:0] reg_address,
	 input [7:0] data,
	 
    //FSM inputs for module
	 input clk,
	 input reset,
	 input start,
	 output done,
	 
	 //timer inputs and outputs
	 input timer_exp,
	 output timer_start,
	 output [3:0] timer_param,
	 
	 //communication bus with I2C master module
	 //combined with read module, all I2C master inputs should
	 //be well defined
	 input i2c_data_in_ready,
	 input i2c_cmd_ready,
	 input i2c_bus_busy,
	 input i2c_bus_control,
	 input i2c_bus_active,
	 input i2c_missed_ack,
	 
	 output [7:0] i2c_data_out,
	 output [6:0] i2c_dev_address,
	 
	 output i2c_cmd_start,
	 output i2c_cmd_write_multiple,
	 output i2c_cmd_stop,
	 output i2c_cmd_valid,
	 output i2c_data_in_valid,
	 output i2c_data_in_last,
	 output [3:0] state_out,
	 
	 //status
	 output message_failure,
	 output i2c_control,
	 input i2c_relinquish //from other i2c comm modules, forces tristate of necessary busses
	);
	//write_reg_i2c acts as a module which will, given that the I2C bus is available,
	//upon start, will take the data available at reg_address and data and upon
   //response from an i2C master send the register address and the corresponding data 
	//in the appropriate manner to write to the given register.
	
	//define state parameters
	parameter S_RESET = 4'b0000;
	parameter S_VALIDATE_BUS = 4'b0001;
	parameter S_VALIDATE_TIMEOUT = 4'b0010;
	parameter S_WRITE_REG_ADDRESS_0 = 4'b0011;
	parameter S_WRITE_REG_ADDRESS_1 = 4'b0100;
 	parameter S_WRITE_REG_ADDRESS_TIMEOUT = 4'b0101;
	parameter S_WRITE_DATA_0 = 4'b0110;
	parameter S_WRITE_DATA_1 = 4'b0111;
	parameter S_WRITE_DATA_TIMEOUT = 4'b1000;
	parameter S_CHECK_I2C_FREE = 4'b1001;
	parameter S_CHECK_I2C_FREE_TIMEOUT = 4'b1010;
	
	//define state registers and counters
	reg [3:0] state = 4'b0000;

	//define output registers -- outputs that are shared with
	//other I2C communication modules should be tristated as to prevent
	//bus contention -- looking to the future if I have a read/write module
	//for 16/32 bit I2C register writes, then any potentially shared connection
	//should be tristated.
	reg done_reg = 1'b0;
	reg timer_start_reg = 1'bz;
	reg [3:0] timer_param_reg = 3'bzzz;
	
	reg [7:0] i2c_data_out_reg = 8'hzz;
	reg [6:0] i2c_dev_address_reg = 7'bzzzzzzz;
	
	reg i2c_cmd_start_reg = 1'bz;
	reg i2c_cmd_write_multiple_reg = 1'bz;
	reg i2c_cmd_stop_reg = 1'bz;
	reg i2c_cmd_valid_reg = 1'bz;
	reg i2c_data_in_valid_reg = 1'bz;
	reg i2c_data_in_last_reg = 1'bz;
	
	reg message_failure_reg = 1'b0;
	reg i2c_control_reg = 1'b0;
	
	//define combinational logic
	wire bus_valid;
	assign bus_valid = ~i2c_bus_busy & ~i2c_bus_active;
	wire i2c_bus_free = ~i2c_bus_busy & ~i2c_bus_control;
	assign i2c_bus_free_output = i2c_bus_free;
	
	//define state transition diagram
	//and state outputs 
	always @(posedge clk) begin
		if(reset | i2c_relinquish) state <= S_RESET;
		if(i2c_missed_ack) begin
			state <= S_RESET;
			message_failure_reg <= 1'b1; //missed_ack --> pulse message_failure 
		end
		case(state)
			S_RESET: begin
				if(start) begin
					state <= S_VALIDATE_BUS;
				end
				else begin
					state <= S_RESET;
				end
				
				//reset values
				done_reg <= 1'b0;
				timer_start_reg <= 1'bz;
				timer_param_reg <= 3'bzzz;
				
				i2c_data_out_reg <= 8'hzz;
				i2c_dev_address_reg <= 7'bzzzzzzz;
				
				i2c_cmd_start_reg <= 1'bz;
				i2c_cmd_write_multiple_reg <= 1'bz;
				i2c_cmd_stop_reg <= 1'bz;
				i2c_cmd_valid_reg <= 1'bz;
				i2c_data_in_valid_reg <= 1'bz;
				i2c_data_in_last_reg <= 1'bz;
				
				message_failure_reg <= 1'b0;
				i2c_control_reg <= 1'b0;
			end
			S_VALIDATE_BUS: begin
				if(bus_valid) begin
					state <= S_WRITE_REG_ADDRESS_0;			
				end
				else begin
					state <= S_VALIDATE_TIMEOUT;
				end
				//outputs for S_VALIDATE_BUS state -- take ownership of the 
				//communication channel:
				i2c_control_reg <= 1'b1;
			end
			S_VALIDATE_TIMEOUT: begin
				if(timer_exp) begin
					state <= S_RESET;
				end
				else if(bus_valid) begin
					state <= S_WRITE_REG_ADDRESS_0;
				end
				else begin
					state <= S_VALIDATE_TIMEOUT;
				end
				timer_start_reg <= 1'b1;
				timer_param_reg <= 3'b001;
			end
			S_WRITE_REG_ADDRESS_0: begin
				if(i2c_data_in_ready) begin
					state <= S_WRITE_REG_ADDRESS_1;
				end
				else begin
					state <= S_WRITE_REG_ADDRESS_TIMEOUT;
				end
				//This state is designed to validate whether or not
				//the I2C master is ready to accept data, so we need
				//to tell the master we're getting ready to write.
				i2c_data_out_reg <= reg_address;
				i2c_dev_address_reg <= dev_address;
				i2c_cmd_start_reg <= 1'b1;
				i2c_cmd_write_multiple_reg <= 1'b1;
				i2c_cmd_stop_reg <= 1'b1;
				i2c_cmd_valid_reg <= 1'b1;
				i2c_data_in_valid_reg <= 1'b0;
				i2c_data_in_last_reg <= 1'b0;
			end
			S_WRITE_REG_ADDRESS_1: begin
				state <= S_WRITE_DATA_0;
				i2c_data_in_valid_reg <= 1'b1;
			end
			S_WRITE_REG_ADDRESS_TIMEOUT: begin
				if(timer_exp) begin
					state <= S_RESET;
				end
				else if(i2c_data_in_ready) begin
					state <= S_WRITE_REG_ADDRESS_1;
				end
				else begin
					state <= S_WRITE_REG_ADDRESS_TIMEOUT;
				end
				timer_start_reg <= 1'b1;
				timer_param_reg <= 3'b001;
			end
			S_WRITE_DATA_0: begin
				if(i2c_data_in_ready) begin
					state <= S_CHECK_I2C_FREE;
				end
				else begin
					state <= S_WRITE_DATA_TIMEOUT;
				end
				i2c_data_out_reg <= data;
				i2c_data_in_valid_reg <= 1'b0;
				i2c_data_in_last_reg <= 1'b1;
			end
			S_WRITE_DATA_1: begin
				state <= S_CHECK_I2C_FREE;
				i2c_data_in_valid_reg <= 1'b1;
			end
			S_WRITE_DATA_TIMEOUT: begin
				if(timer_exp) begin
					state <= S_RESET;
				end
				else if(i2c_data_in_ready) begin
					state <= S_WRITE_DATA_1;
				end
				else begin
					state <= S_WRITE_DATA_TIMEOUT;
				end
				timer_start_reg <= 1'b1;
				timer_param_reg <= 3'b001;
			end
			S_CHECK_I2C_FREE: begin
				if(i2c_bus_free) begin
					state <= S_RESET;
				end
				else begin
					state <= S_CHECK_I2C_FREE_TIMEOUT;
				end
			end
			S_CHECK_I2C_FREE_TIMEOUT: begin
				if(timer_exp) begin
					state <= S_RESET;
					message_failure_reg <= 1'b1;
				end
				else if(i2c_bus_free) begin
					state <= S_RESET;
				end
				else begin
					state <= S_CHECK_I2C_FREE_TIMEOUT;
				end
				done_reg <= 1'b1;
				timer_start_reg <= 1'b1;
				timer_param_reg <= 3'b001;
			end
			default: state <= S_RESET;
		endcase
	end
		
	//assign registers to outputs	
	assign done = done_reg;
	assign timer_start = timer_start_reg;
	assign timer_param = timer_param_reg;
	
	assign i2c_data_out = i2c_data_out_reg;
	assign i2c_dev_address = i2c_dev_address_reg;
	
	assign i2c_cmd_start = i2c_cmd_start_reg;
	assign i2c_cmd_write_multiple = i2c_cmd_write_multiple_reg;
	assign i2c_cmd_stop = i2c_cmd_stop_reg;
	assign i2c_cmd_valid = i2c_cmd_valid_reg;
	assign i2c_data_in_valid = i2c_data_in_valid_reg;
	assign i2c_data_in_last = i2c_data_in_last_reg;
	
	assign message_failure = message_failure_reg;
	assign i2c_control = i2c_control_reg;
	
	//debugging
	assign state_out = state;

endmodule 

