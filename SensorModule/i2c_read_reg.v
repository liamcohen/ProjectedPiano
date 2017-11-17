`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:13:32 11/15/2017 
// Design Name: 
// Module Name:    i2c_read_reg 
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

module i2c_read_reg(
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
	 
    input i2c_data_in_valid,
    output i2c_data_in_ready,
    input i2c_data_in_last,
	 
	 output [7:0] i2c_data_out,
	 input  [7:0] i2c_data_in,
	 output [6:0] i2c_dev_address,
	 
	 output i2c_cmd_start,
	 output i2c_cmd_read,
	 output i2c_cmd_write,
	 output i2c_cmd_stop,
	 output i2c_cmd_valid,
	 output i2c_data_out_valid,
	 output [3:0] state_out,
	 
	 //FIFO outputs
	 output [7:0] data_out,
	 output fifo_read_en,
	 output fifo_empty,
	 output fifo_read_valid,
	 output fifo_underflow,
	 
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
	parameter S_READ_DATA_0 = 4'b0110;
	parameter S_READ_DATA_1 = 4'b0111;
	parameter S_READ_DATA_2 = 4'b1000;
	parameter S_READ_DATA_TIMEOUT = 4'b1001;
	parameter S_FIFO_WRITE_ACK_TIMEOUT_0 = 4'b1010;
	parameter S_FIFO_WRITE_ACK_TIMEOUT_1 = 4'b1011;
	parameter S_CHECK_I2C_FREE = 4'b1100;
	parameter S_CHECK_I2C_FREE_TIMEOUT = 4'b1101;
	
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
	reg [3:0] timer_param_reg = 3'b001;
	reg timer_reset_reg = 1'b0;
	
	reg [7:0] i2c_data_out_reg = 8'h00;
	reg [6:0] i2c_dev_address_reg = 7'b0000000;
	
	reg i2c_cmd_start_reg = 1'b0;
	reg i2c_cmd_write_reg = 1'b0;
	reg i2c_cmd_read_reg = 1'b0;
	reg i2c_cmd_stop_reg = 1'b0;
	reg i2c_cmd_valid_reg = 1'b0;
	
	reg i2c_data_in_ready_reg = 1'b0;
	reg i2c_data_out_valid_reg = 1'b0;

	reg message_failure_reg = 1'b0;
	reg i2c_control_reg = 1'b0;
	
	//define combinational logic
	wire bus_valid;
	assign bus_valid = ~i2c_bus_busy & ~i2c_bus_active;
	wire i2c_bus_free = ~i2c_bus_busy & ~i2c_bus_control;
	assign i2c_bus_free_output = i2c_bus_free;
	
	//define I2C read FIFO
	wire fifo_reset;
	wire fifo_write_en;
	wire fifo_full;
	wire fifo_write_ack;
	wire fifo_overflow;
	
	reg fifo_reset_reg = 1'b0;
	reg fifo_write_en_reg = 1'b0;
	
	FIFO fifo(
		.din(i2c_data_in),
		.dout(data_out),
		.wr_en(fifo_write_en_reg),
		.rd_en(fifo_read_en),
		.clk(clk),
		.rst(fifo_reset_reg),
		.full(fifo_full),
		.empty(fifo_empty),
		.valid(fifo_read_valid),
		.wr_ack(fifo_write_ack),
		.overflow(fifo_overflow),
		.underflow(fifo_underflow)
	);
	
	assign fifo_reset = fifo_reset_reg;
	assign fifo_write_en = fifo_write_en_reg;
	
	//define state transition diagram
	//and state outputs 
	always @(posedge clk) begin
		if(reset | i2c_relinquish) state <= S_RESET;
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
					timer_param_reg <= 3'b001;
					timer_reset_reg <= 1'b1;
					data_read_count <= byte_width;
					
					i2c_data_out_reg <= 8'h00;
					i2c_dev_address_reg <= dev_address;
					
					i2c_cmd_start_reg <= 1'b0;
					i2c_cmd_write_reg <= 1'b0;
					i2c_cmd_read_reg <= 1'b0;
					i2c_cmd_stop_reg <= 1'b0;
					i2c_cmd_valid_reg <= 1'b0;
					
					i2c_data_in_ready_reg <= 1'b0;
					i2c_data_out_valid_reg <= 1'b0;
					
					message_failure_reg <= 1'b0;
					i2c_control_reg <= 1'b0;
					
					fifo_reset_reg <= 1'b1;
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
					fifo_reset_reg <= 1'b0; //clear fifo before reading from I2C slave
					timer_reset_reg <= 1'b0; //reset timer
				end
				S_VALIDATE_TIMEOUT: begin
					if(timer_exp) begin
						state <= S_RESET;
						message_failure_reg <= 1'b1;
					end
					else if(bus_valid) begin
						state <= S_WRITE_REG_ADDRESS_0;
						timer_start_reg <= 1'b0;
						timer_reset_reg <= 1'b1;
					end
					else begin
						state <= S_VALIDATE_TIMEOUT;
						timer_start_reg <= 1'b1;
						timer_reset_reg <= 1'b0;
					end
					timer_param_reg <= 3'b001;
				end
				S_WRITE_REG_ADDRESS_0: begin
					if(i2c_data_out_ready) begin
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
					i2c_cmd_write_reg <= 1'b1;
					i2c_cmd_stop_reg <= 1'b1;
					i2c_cmd_valid_reg <= 1'b1;
					i2c_data_out_valid_reg <= 1'b0;
				end
				S_WRITE_REG_ADDRESS_1: begin
					state <= S_READ_DATA_0;
					i2c_data_out_valid_reg <= 1'b1;
				end
				S_WRITE_REG_ADDRESS_TIMEOUT: begin
					if(timer_exp) begin
						state <= S_RESET;
						message_failure_reg <= 1'b1;
					end
					else if(i2c_data_out_ready) begin
						state <= S_WRITE_REG_ADDRESS_1;
						timer_start_reg <= 1'b0;
						timer_reset_reg <= 1'b1;
					end
					else begin
						state <= S_WRITE_REG_ADDRESS_TIMEOUT;
						timer_start_reg <= 1'b1;
						timer_reset_reg <= 1'b0;
					end
					timer_param_reg <= 3'b001;
				end
				S_READ_DATA_0: begin
					state <= S_READ_DATA_TIMEOUT;
					i2c_cmd_read_reg <= 1'b1;
					i2c_cmd_start_reg <= 1'b0;
					i2c_cmd_stop_reg <= 1'b0;
					i2c_cmd_write_reg <= 1'b0;
					i2c_cmd_valid_reg <= 1'b0;
				end
				S_READ_DATA_1: begin
					if(i2c_data_in_valid) begin
						state <= S_READ_DATA_2;
					end
					else begin
						state <= S_READ_DATA_TIMEOUT;
					end
					i2c_data_in_ready_reg <= 1'b1;
				end
				S_READ_DATA_2: begin
					//Now that we know that the master module is ready
					//to send data over I2C we need to clock the data
					//into a shift register and put it into the FIFO
					if(fifo_overflow) begin
						//too many data bytes were sent -- fifo is 16 bytes deep,
						//if more than 16 bytes were read this constitutes and error
						state <= S_RESET;
						message_failure_reg <= 1'b1;
					end
					else begin
						if(data_read_count != 4'b0000) begin
							state <= S_FIFO_WRITE_ACK_TIMEOUT_0;
						end
						else begin
							state <= S_FIFO_WRITE_ACK_TIMEOUT_1;
							i2c_cmd_stop_reg <= 1'b1;
						end
						data_read_count <= data_read_count - 1;
						fifo_write_en_reg <= 1'b1;
					end
				end
				S_READ_DATA_TIMEOUT: begin
					if(timer_exp) begin
						state <= S_RESET;
						message_failure_reg <= 1'b1;
					end
					else if(i2c_data_in_valid) begin
						state <= S_READ_DATA_2;
						timer_start_reg <= 1'b0;
						timer_reset_reg <= 1'b1;
					end
					else begin
						state <= S_READ_DATA_TIMEOUT;
						timer_start_reg <= 1'b1;
						timer_reset_reg <= 1'b0;
					end
					i2c_cmd_valid_reg <= 1'b1;
					timer_param_reg <= 3'b001;
				end
				S_FIFO_WRITE_ACK_TIMEOUT_0: begin
					if(timer_exp) begin
						state <= S_RESET;
						message_failure_reg <= 1'b1;
					end
					else if(fifo_write_ack) begin
						state <= S_READ_DATA_1;
						timer_start_reg <= 1'b0;
						timer_reset_reg <= 1'b1;
					end
					else begin
						state <= S_FIFO_WRITE_ACK_TIMEOUT_0;
						timer_start_reg <= 1'b1;
						timer_reset_reg <= 1'b0;
					end
					fifo_write_en_reg <= 1'b0;
					timer_param_reg <= 3'b001;
				end
				S_FIFO_WRITE_ACK_TIMEOUT_1: begin
					if(timer_exp) begin
						state <= S_RESET;
						message_failure_reg <= 1'b1;
					end
					else if(fifo_write_ack) begin
						state <= S_CHECK_I2C_FREE;
						timer_start_reg <= 1'b0;
						timer_reset_reg <= 1'b1;
					end
					else begin
						state <= S_FIFO_WRITE_ACK_TIMEOUT_1;
						timer_start_reg <= 1'b1;
						timer_reset_reg <= 1'b0;
					end
					fifo_write_en_reg <= 1'b0;
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
						timer_start_reg <= 1'b0;
						timer_reset_reg <= 1'b1;
					end
					else begin
						state <= S_CHECK_I2C_FREE_TIMEOUT;
						timer_start_reg <= 1'b1;
						timer_reset_reg <= 1'b0;
					end
					done_reg <= 1'b1;
					i2c_cmd_valid_reg <= 1'b0;
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
	assign i2c_data_out_valid = i2c_data_out_valid_reg;
	assign i2c_data_in_ready = i2c_data_in_ready_reg;
	assign i2c_dev_address = i2c_dev_address_reg;
	
	assign i2c_cmd_start = i2c_cmd_start_reg;
	assign i2c_cmd_read = i2c_cmd_read_reg;
	assign i2c_cmd_write = i2c_cmd_write_reg;
	assign i2c_cmd_stop = i2c_cmd_stop_reg;
	assign i2c_cmd_valid = i2c_cmd_valid_reg;
	
	assign message_failure = message_failure_reg;
	assign i2c_control = i2c_control_reg;
	
	//debugging
	assign state_out = state;

endmodule 


