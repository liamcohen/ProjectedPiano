`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:02:30 11/12/2017
// Design Name:   i2c_write_reg
// Module Name:   /afs/athena.mit.edu/user/l/c/lc2017/Desktop/6.111_Final_Project/ProjectedPiano/SensorModule/test_i2c_write_reg.v
// Project Name:  SensorModule
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: i2c_write_reg
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_i2c_write_reg;

	// Inputs
	reg [5:0] dev_address;
	reg [7:0] reg_address;
	reg [7:0] data;
	reg clk;
	reg reset;
	reg start;
	reg timer_exp;
	reg i2c_data_in_ready;
	reg i2c_cmd_ready;
	reg i2c_bus_busy;
	reg i2c_bus_control;
	reg i2c_bus_active;
	reg i2c_missed_ack;
	reg i2c_relinquish;

	// Outputs
	wire done;
	wire timer_start;
	wire [3:0] timer_param;
	wire [7:0] i2c_data_out;
	wire [5:0] i2c_dev_address;
	wire i2c_cmd_start;
	wire i2c_cmd_write_multiple;
	wire i2c_cmd_stop;
	wire i2c_cmd_valid;
	wire i2c_data_in_valid;
	wire i2c_data_in_last;
	wire message_failure;
	wire i2c_control;
	wire [3:0] state_out;
	
	// Instantiate the Unit Under Test (UUT)
	i2c_write_reg uut (
		.dev_address(dev_address), 
		.reg_address(reg_address), 
		.data(data), 
		.clk(clk), 
		.reset(reset), 
		.start(start), 
		.done(done), 
		.timer_exp(timer_exp), 
		.timer_start(timer_start), 
		.timer_param(timer_param), 
		.i2c_data_in_ready(i2c_data_in_ready), 
		.i2c_cmd_ready(i2c_cmd_ready), 
		.i2c_bus_busy(i2c_bus_busy), 
		.i2c_bus_control(i2c_bus_control), 
		.i2c_bus_active(i2c_bus_active), 
		.i2c_missed_ack(i2c_missed_ack), 
		.i2c_data_out(i2c_data_out), 
		.i2c_dev_address(i2c_dev_address), 
		.i2c_cmd_start(i2c_cmd_start), 
		.i2c_cmd_write_multiple(i2c_cmd_write_multiple), 
		.i2c_cmd_stop(i2c_cmd_stop), 
		.i2c_cmd_valid(i2c_cmd_valid), 
		.i2c_data_in_valid(i2c_data_in_valid), 
		.i2c_data_in_last(i2c_data_in_last), 
		.message_failure(message_failure), 
		.i2c_control(i2c_control), 
		.i2c_relinquish(i2c_relinquish),
		.state_out(state_out)
	);

	always #5 clk = !clk; //10ns clock
	initial begin
		// Initialize Inputs
		dev_address = 6'h29;
		reg_address = 8'h69;
		data = 8'h73;
		clk = 0;
		reset = 0;
		start = 0;
		timer_exp = 0;
		i2c_data_in_ready = 0;
		i2c_cmd_ready = 0;
		i2c_bus_busy = 0;
		i2c_bus_control = 0;
		i2c_bus_active = 1;
		i2c_missed_ack = 0;
		i2c_relinquish = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		start = 1;
		#10
		start = 0;
		#50
		i2c_bus_active = 0;
		#30
		i2c_bus_active = 1;
		i2c_bus_control = 1;
		i2c_bus_busy = 1;
		#80
		i2c_data_in_ready = 1;
		#10
		i2c_data_in_ready = 0;
		#80
		i2c_data_in_ready = 1;
		#10
		i2c_data_in_ready = 0;
		#100
		i2c_bus_active = 0;
		i2c_bus_control = 0;
		i2c_bus_busy = 0;
		
	end
      
endmodule

