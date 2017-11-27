`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:50:13 11/12/2017 
// Design Name: 
// Module Name:    i2c_write_reg_multi 
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
module i2c_write_reg_multi(
   //data inputs
	 input [6:0] dev_address,
	 input [7:0] reg_address,
	 
    //FSM inputs for module
	 input clk,
	 input reset,
	 input start,
	 output done,
	 input [3:0] byte_width,
	 
	 //timer inputs and outputs
	 input timer_exp,
	 output timer_start,
	 output [3:0] timer_param,
	 output timer_reset,
	 
	 //communication bus with I2C master module
	 //combined with read module, all I2C master inputs should
	 //be well defined
	 input i2c_data_out_ready,
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
	 output i2c_data_out_valid,
	 output i2c_data_out_last,
	 output [3:0] state_out,
	 
	 //FIFO input
	 input [7:0] data,
	 input fifo_wr_en,
	 input fifo_ext_reset,
	 output fifo_full,
	 output fifo_write_ack,
	 output fifo_overflow,
	 
	 //status
	 output message_failure,
	 
	 //debug signals - to be deleted
	 output FIFO_UNDERFLOW_DEBUG,
	 output [3:0] DATA_COUNT_DEBUG,
	 output [7:0] FIFO_OUT_DEBUG
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
	parameter S_WRITE_DATA_1_LAST = 4'b1000;
	parameter S_WRITE_DATA_2 = 4'b1001;
	parameter S_WRITE_DATA_TIMEOUT = 4'b1010;
	parameter S_WRITE_DATA_TIMEOUT_LAST = 4'b1011;
	parameter S_FIFO_READ_VALID_TIMEOUT_0 = 4'b1100;
	parameter S_FIFO_READ_VALID_TIMEOUT_1 = 4'b1101;
	parameter S_CHECK_I2C_FREE = 4'b1110;
	parameter S_CHECK_I2C_FREE_TIMEOUT = 4'b1111;
	
	//define state registers and counters
	reg [3:0] state = 4'b0000;
	reg [3:0] data_read_count = 4'b0000;

	//define output registers -- outputs that are shared with
	//other I2C communication modules should be tristated as to prevent
	//bus contention -- looking to the future if I have a read/write module
	//for 16/32 bit I2C register writes, then any potentially shared connection
	//should be tristated.
	reg done_reg = 1'b0;
	reg timer_start_reg = 1'b0;
	reg [3:0] timer_param_reg = 4'b0001;
	reg timer_reset_reg = 1'b1;
	
	reg [7:0] i2c_data_out_reg = 8'h00;
	reg [6:0] i2c_dev_address_reg = 7'b0000000;
	
	reg i2c_cmd_start_reg = 1'b0;
	reg i2c_cmd_write_multiple_reg = 1'b0;
	reg i2c_cmd_stop_reg = 1'b0;
	reg i2c_cmd_valid_reg = 1'b0;
	reg i2c_data_out_valid_reg = 1'b0;
	reg i2c_data_out_last_reg = 1'b0;
	
	reg message_failure_reg = 1'b0;
	
	//define combinational logic
	wire bus_valid;
	assign bus_valid = ~i2c_bus_busy & ~i2c_bus_active;
	wire i2c_bus_free = ~i2c_bus_busy & ~i2c_bus_control;
	assign i2c_bus_free_output = i2c_bus_free;
	
	//define I2C read FIFO
	wire fifo_reset;
	wire fifo_empty;
	wire fifo_read_valid;
	wire fifo_underflow;
	wire [7:0] fifo_data_out;
	
	reg fifo_reset_reg = 1'b0;
	reg fifo_read_en_reg = 1'b0;
	wire [3:0] data_count;
	
	FIFO fifo_1(
		.din(data),
		.dout(fifo_data_out),
		.wr_en(fifo_wr_en),
		.rd_en(fifo_read_en_reg),
		.clk(clk),
		.rst(fifo_reset),
		.full(fifo_full),
		.empty(fifo_empty),
		.valid(fifo_read_valid),
		.wr_ack(fifo_write_ack),
		.overflow(fifo_overflow),
		.underflow(fifo_underflow),
		.data_count(data_count)
	);
	
	assign fifo_reset = fifo_reset_reg | fifo_ext_reset;
	assign FIFO_UNDERFLOW_DEBUG = fifo_underflow;
	assign DATA_COUNT_DEBUG = data_count;
	assign FIFO_OUT_DEBUG = fifo_data_out;
	
	//define state transition diagram
	//and state outputs 
	always @(posedge clk) begin
		if(reset) state <= S_RESET;
		else if(i2c_missed_ack) begin
			state <= S_RESET;
			message_failure_reg <= 1'b1; //missed_ack --> pulse message_failure 
		end
		else begin
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
					timer_start_reg <= 1'b0;
					timer_param_reg <= 4'b0001;
					timer_reset_reg <= 1'b1;
					data_read_count <= byte_width;
					
					fifo_reset_reg <= 1'b0;
					fifo_read_en_reg <= 1'b0;
					
					i2c_data_out_reg <= 8'h00;
					i2c_dev_address_reg <= 7'b0000000;
					
					i2c_cmd_start_reg <= 1'b0;
					i2c_cmd_write_multiple_reg <= 1'b0;
					i2c_cmd_stop_reg <= 1'b0;
					i2c_cmd_valid_reg <= 1'b0;
					i2c_data_out_valid_reg <= 1'b0;
					i2c_data_out_last_reg <= 1'b0;
					
					message_failure_reg <= 1'b0;
				end
				S_VALIDATE_BUS: begin
					if(bus_valid) begin
						state <= S_WRITE_REG_ADDRESS_0;			
					end
					else begin
						state <= S_VALIDATE_TIMEOUT;
						timer_start_reg <= 1'b1;
						timer_reset_reg <= 1'b1;
					end
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
					timer_start_reg <= 1'b0;
					timer_reset_reg <= 1'b0;
					timer_param_reg <= 3'b001;
				end
				S_WRITE_REG_ADDRESS_0: begin
					if(i2c_data_out_ready) begin
						state <= S_WRITE_REG_ADDRESS_1;
					end
					else begin
						state <= S_WRITE_REG_ADDRESS_TIMEOUT;
						timer_start_reg <= 1'b1;
						timer_reset_reg <= 1'b1;
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
					i2c_data_out_valid_reg <= 1'b1;
					i2c_data_out_last_reg <= 1'b0;
				end
				S_WRITE_REG_ADDRESS_1: begin
					state <= S_WRITE_DATA_0;
					i2c_data_out_valid_reg <= 1'b0;
				end
				S_WRITE_REG_ADDRESS_TIMEOUT: begin
					if(timer_exp) begin
						state <= S_RESET;
					end
					else if(i2c_data_out_ready) begin
						state <= S_WRITE_REG_ADDRESS_1;
					end
					else begin
						state <= S_WRITE_REG_ADDRESS_TIMEOUT;
					end
					timer_start_reg <= 1'b0;
					timer_reset_reg <= 1'b0;
					timer_param_reg <= 3'b001;
				end
				S_WRITE_DATA_0: begin
					if(fifo_underflow) begin
						state <= S_RESET;
						message_failure_reg <= 1'b1;
					end
					else begin
						if(data_read_count > 4'b0001) begin
							state <= S_FIFO_READ_VALID_TIMEOUT_0;
							timer_start_reg <= 1'b1;
							timer_reset_reg <= 1'b1;
						end
						else begin
							state <= S_FIFO_READ_VALID_TIMEOUT_1;
							timer_start_reg <= 1'b1;
							timer_reset_reg <= 1'b1;
						end
						data_read_count <= data_read_count - 1;
						fifo_read_en_reg <= 1'b1;
						i2c_data_out_valid_reg <= 1'b0;
					end
				end
				S_WRITE_DATA_1: begin
					if(i2c_data_out_ready) begin
						state <= S_WRITE_DATA_0;
					end
					else begin
						state <= S_WRITE_DATA_TIMEOUT;
						timer_start_reg <= 1'b1;
						timer_reset_reg <= 1'b1;
					end
					i2c_data_out_valid_reg <= 1'b1;
					i2c_data_out_reg <= fifo_data_out;
				end
				S_WRITE_DATA_1_LAST: begin
					if(i2c_data_out_ready) begin
						state <= S_WRITE_DATA_2;
					end
					else begin
						state <= S_WRITE_DATA_TIMEOUT_LAST;
						timer_start_reg <= 1'b1;
						timer_reset_reg <= 1'b1;
					end
					i2c_data_out_valid_reg <= 1'b1;
					i2c_data_out_reg <= fifo_data_out;
					i2c_data_out_last_reg <= 1'b1;
				end
				S_WRITE_DATA_2: begin
					state <= S_CHECK_I2C_FREE;
					i2c_data_out_valid_reg <= 1'b0;
				end
				S_WRITE_DATA_TIMEOUT: begin
					if(timer_exp) begin
						state <= S_RESET;
						message_failure_reg <= 1'b1;
					end
					else if(i2c_data_out_ready) begin
						state <= S_WRITE_DATA_0;
					end
					else begin
						state <= S_WRITE_DATA_TIMEOUT;
					end
					timer_start_reg <= 1'b0;
					timer_reset_reg <= 1'b0;
					timer_param_reg <= 3'b001;
				end
				S_WRITE_DATA_TIMEOUT_LAST: begin
					if(timer_exp) begin
						state <= S_RESET;
						message_failure_reg <= 1'b1;
					end
					else if(i2c_data_out_ready) begin
						state <= S_WRITE_DATA_2;
					end
					else begin
						state <= S_WRITE_DATA_TIMEOUT_LAST;
					end
					timer_start_reg <= 1'b0;
					timer_reset_reg <= 1'b0;
					timer_param_reg <= 3'b001;
				end
				S_FIFO_READ_VALID_TIMEOUT_0: begin
					if(timer_exp) begin
						state <= S_RESET;
						message_failure_reg <= 1'b1;
					end
					else if(fifo_read_valid) begin
						state <= S_WRITE_DATA_1;
					end
					else begin
						state <= S_FIFO_READ_VALID_TIMEOUT_0;
					end
					timer_start_reg <= 1'b0;
					timer_reset_reg <= 1'b0;
					timer_param_reg <= 3'b001;
					
					fifo_read_en_reg <= 1'b0;
				end
				S_FIFO_READ_VALID_TIMEOUT_1: begin
					if(timer_exp) begin
						state <= S_RESET;
						message_failure_reg <= 1'b1;
					end
					else if(fifo_read_valid) begin
						state <= S_WRITE_DATA_1_LAST;
					end
					else begin
						state <= S_FIFO_READ_VALID_TIMEOUT_1;
					end
					timer_start_reg <= 1'b0;
					timer_reset_reg <= 1'b0;
					timer_param_reg <= 3'b001;
					
					fifo_read_en_reg <= 1'b0;
				end
				S_CHECK_I2C_FREE: begin
					if(i2c_bus_free) begin
						state <= S_RESET;
					end
					else begin
						state <= S_CHECK_I2C_FREE_TIMEOUT;
						timer_start_reg <= 1'b1;
						timer_reset_reg <= 1'b1;
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
					
					fifo_reset_reg <= 1'b1;
					
					i2c_data_out_valid_reg <= 1'b0;
					i2c_cmd_valid_reg <= 1'b0;
					
					timer_start_reg <= 1'b0;
					timer_reset_reg <= 1'b0;
					timer_param_reg <= 3'b001;
				end
				default: state <= S_RESET;
			endcase
		end
	end
		
	//assign registers to outputs	
	assign done = done_reg;
	assign timer_start = timer_start_reg;
	assign timer_param = timer_param_reg;
	assign timer_reset = timer_reset_reg;
	
	assign i2c_data_out = i2c_data_out_reg;
	assign i2c_dev_address = i2c_dev_address_reg;
	
	assign i2c_cmd_start = i2c_cmd_start_reg;
	assign i2c_cmd_write_multiple = i2c_cmd_write_multiple_reg;
	assign i2c_cmd_stop = i2c_cmd_stop_reg;
	assign i2c_cmd_valid = i2c_cmd_valid_reg;
	assign i2c_data_out_valid = i2c_data_out_valid_reg;
	assign i2c_data_out_last = i2c_data_out_last_reg;
	
	assign message_failure = message_failure_reg;
	
	//debugging
	assign state_out = state;

endmodule 


