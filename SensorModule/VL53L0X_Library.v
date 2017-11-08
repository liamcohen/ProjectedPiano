`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:11:30 11/08/2017 
// Design Name: 
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
include "i2c_master.v"
include "i2C_init.v"
include "axis_fifo.v"

/////////////////////////////////////////////////////////////////////////////////
// Register map taken from Pololu VL53L0X open-source library on github        //
//																										 //
/////////////////////////////////////////////////////////////////////////////////
parameter SYSRANGE_START                              = 0x00;

parameter SYSTEM_THRESH_HIGH                          = 0x0C;
parameter SYSTEM_THRESH_LOW                           = 0x0E;

parameter SYSTEM_SEQUENCE_CONFIG                      = 0x01;
parameter SYSTEM_RANGE_CONFIG                         = 0x09;
parameter SYSTEM_INTERMEASUREMENT_PERIOD              = 0x04;

parameter SYSTEM_INTERRUPT_CONFIG_GPIO                = 0x0A;

parameter GPIO_HV_MUX_ACTIVE_HIGH                     = 0x84;

parameter SYSTEM_INTERRUPT_CLEAR                      = 0x0B;

parameter RESULT_INTERRUPT_STATUS                     = 0x13;
parameter RESULT_RANGE_STATUS                         = 0x14;

parameter RESULT_CORE_AMBIENT_WINDOW_EVENTS_RTN       = 0xBC;
parameter RESULT_CORE_RANGING_TOTAL_EVENTS_RTN        = 0xC0;
parameter RESULT_CORE_AMBIENT_WINDOW_EVENTS_REF       = 0xD0;
parameter RESULT_CORE_RANGING_TOTAL_EVENTS_REF        = 0xD4;
parameter RESULT_PEAK_SIGNAL_RATE_REF                 = 0xB6;

parameter ALGO_PART_TO_PART_RANGE_OFFSET_MM           = 0x28;

parameter I2C_SLAVE_DEVICE_ADDRESS                    = 0x8A;

parameter MSRC_CONFIG_CONTROL                         = 0x60;

parameter PRE_RANGE_CONFIG_MIN_SNR                    = 0x27;
parameter PRE_RANGE_CONFIG_VALID_PHASE_LOW            = 0x56;
parameter PRE_RANGE_CONFIG_VALID_PHASE_HIGH           = 0x57;
parameter PRE_RANGE_MIN_COUNT_RATE_RTN_LIMIT          = 0x64;

parameter FINAL_RANGE_CONFIG_MIN_SNR                  = 0x67;
parameter FINAL_RANGE_CONFIG_VALID_PHASE_LOW          = 0x47;
parameter FINAL_RANGE_CONFIG_VALID_PHASE_HIGH         = 0x48;
parameter FINAL_RANGE_CONFIG_MIN_COUNT_RATE_RTN_LIMIT = 0x44;

parameter PRE_RANGE_CONFIG_SIGMA_THRESH_HI            = 0x61;
parameter PRE_RANGE_CONFIG_SIGMA_THRESH_LO            = 0x62;
parameter PRE_RANGE_CONFIG_VCSEL_PERIOD               = 0x50;
parameter PRE_RANGE_CONFIG_TIMEOUT_MACROP_HI          = 0x51;
parameter PRE_RANGE_CONFIG_TIMEOUT_MACROP_LO          = 0x52;
parameter SYSTEM_HISTOGRAM_BIN                        = 0x81;
parameter HISTOGRAM_CONFIG_INITIAL_PHASE_SELECT       = 0x33;
parameter HISTOGRAM_CONFIG_READOUT_CTRL               = 0x55;
parameter FINAL_RANGE_CONFIG_VCSEL_PERIOD             = 0x70;
parameter FINAL_RANGE_CONFIG_TIMEOUT_MACROP_HI        = 0x71;
parameter FINAL_RANGE_CONFIG_TIMEOUT_MACROP_LO        = 0x72;
parameter CROSSTALK_COMPENSATION_PEAK_RATE_MCPS       = 0x20;
parameter MSRC_CONFIG_TIMEOUT_MACROP                  = 0x46;

parameter SOFT_RESET_GO2_SOFT_RESET_N                 = 0xBF;
parameter IDENTIFICATION_MODEL_ID                     = 0xC0;
parameter IDENTIFICATION_REVISION_ID                  = 0xC2;
parameter OSC_CALIBRATE_VAL                           = 0xF8;
parameter GLOBAL_CONFIG_VCSEL_WIDTH                   = 0x32;
parameter GLOBAL_CONFIG_SPAD_ENABLES_REF_0            = 0xB0;
parameter GLOBAL_CONFIG_SPAD_ENABLES_REF_1            = 0xB1;
parameter GLOBAL_CONFIG_SPAD_ENABLES_REF_2            = 0xB2;
parameter GLOBAL_CONFIG_SPAD_ENABLES_REF_3            = 0xB3;
parameter GLOBAL_CONFIG_SPAD_ENABLES_REF_4            = 0xB4;
parameter GLOBAL_CONFIG_SPAD_ENABLES_REF_5            = 0xB5;
parameter GLOBAL_CONFIG_REF_EN_START_SELECT           = 0xB6;
parameter DYNAMIC_SPAD_NUM_REQUESTED_REF_SPAD         = 0x4E;
parameter DYNAMIC_SPAD_REF_EN_START_OFFSET            = 0x4F;
parameter POWER_MANAGEMENT_GO1_POWER_FORCE            = 0x80;
parameter VHV_CONFIG_PAD_SCL_SDA__EXTSUP_HV           = 0x89;
parameter ALGO_PHASECAL_LIM                           = 0x30;
parameter ALGO_PHASECAL_CONFIG_TIMEOUT                = 0x30;

/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////

module write_reg_i2c(
   //data inputs
	 input [6:0] dev_address,
	 input [7:0] reg_address,
	 input [7:0] data,
	 
    //FSM inputs for module
	 input clk,
	 input reset,
	 input start,
	 output done,
	 output error,
	 
	 //communication bus with I2C master module
	 input i2c_data_in_ready,
	 input i2c_cmd_ready,
	 input i2c_bus_busy,
	 input i2c_bus_control,
	 input i2c_bus_active,
	 input i2c_missed_ack,
	 
	 output [7:0] i2c_data_out,
	 output [6:0] i2c_dev_address,
	 
	 output i2c_cmd_start,
	 output i2c_cmd_write,
	 output i2c_cmd_stop,
	 output i2c_cmd_valid,
	 output i2c_data_in_valid,
	);
	//write_reg_i2c acts as a module which will, given that the I2C bus is available,
	//upon start, will take the data available at reg_address and data and upon
   //response from an i2C master send the register address and the corresponding data 
	//in the appropriate manner to write to the given register.
	
	//define state parameters
	parameter S_RESET = 2'b00;
	parameter S_SEND_ADDR = 2'b01;
	parameter S_SEND_DATA = 2'b10;
	parameter S_VERIFY = 2'b11;
	
	//define registers
	reg [1:0] state = 2'b00;
	reg [1:0] nextstate = 2'b00;
	
	always @ (posedge clk)
		if(reset) state <= S_RESET;
		case(state):
			S_RESET:
			S_SEND_ADDR:
			S_SEND_DATA:
			S_VERIFY:
		endcase

module #(parameter DEV_ADDRESS = 7'h29)  VL53L0X_INIT(
    input start,
	 input clk,
	 input reset,
    output done,
    output success,
	 
	 output [6:0] cmd_address,
	 output cmd_start,
	 output cmd_read,
	 output cmd_write,
	 output cmd_write_multiple,
	 output cmd_stop,
	 output cmd_valid,
	 
	 output [7:0] data_in_reg,
	 output data_in_valid,
	 output data_in_last,
	 output data_out_ready
    );
	 
	 //define reg variables
	 reg state = 0;
	 reg nextstate = 0;
	 reg done_reg = 0;
	 reg success_reg = 0;
	 
	 //define I2C reg variables
	 /*
    * Host interface
    */
	 reg [6:0] cmd_address_reg = DEV_ADDRESSS;
	 reg cmd_start_reg = 1'b0;
	 reg cmd_read_reg = 1'b0;
	 reg cmd_write_reg = 1'b0;
	 reg cmd_write_multiple_reg = 1'b0;
	 reg cmd_stop_reg = 1'b0;
	 reg cmd_valid_reg = 1'b1;
	 
	 reg [7:0] data_in_reg = 8'h00;
    reg data_in_valid_reg = 1'b1;
    reg data_in_last_reg = 1'b0;

    reg data_out_ready_reg = 1'b0;
	 
	 //define state transitions
	 parameter S_RESET = 1'b0;
	 parameter S_READING = 1'b1;
	 
	 always @(posedge clk)
		case(state):
			S_RESET:
				if(start) begin
					nextstate <= S_READING;
					state <= nextstate;
					//unfinished
				end
				else begin
					nextstate <= S_RESET;
					state <= nextstate;
				end
			S_READING:
				if(reset) begin
					nextstate <= S_RESET;
					state <= nextstate;
					done_reg <= 0;
					success_reg <= 0;
				end
				else begin
					//unfinished
				end
		endcase
	 assign done = done_reg;
	 assign success = success_reg;
	 
endmodule
