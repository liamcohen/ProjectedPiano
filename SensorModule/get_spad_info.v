`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:52:51 11/29/2017 
// Design Name: 
// Module Name:    get_spad_info 
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
module get_spad_info(
    //FSM start and done
	 input clk,
	 input reset,
	 input start,
    output done,
	 
	 //start and done for read, write, and write_multi FSMs
    output write_start,
    input write_done,
    output write_multi_start,
    input write_multi_done,
    output read_start,
    input read_done,
	 
	 //timer inputs and outputs
	 input timer_exp,
	 output timer_start,
	 output [3:0] timer_param,
	 output timer_reset,
	 
	 //data input and output
	 output [7:0] reg_address_out,
    output [7:0] data_out,
    output [3:0] n_bytes,
	 
	 //read/write/write_multi select
	 output [1:0] fnc_sel,
	 
	 //FIFO inputs and outputs 
	 //read fifo
	 input [7:0] fifo_data_in,
	 output fifo_read_en,
	 input fifo_empty,
	 input fifo_read_valid,
	 input fifo_underflow,
	 
	 //write fifo
	 output [7:0] fifo_data_out,
	 output fifo_wr_en,
	 output fifo_ext_reset,
	 input fifo_full,
	 input fifo_write_ack,
	 input fifo_overflow,
	 
	 //inputs and outputs to read RAM
	 //ram instantiated in labkit so that gobal variables can be stored and updated
	 output [7:0] mem_addr,
	 output [7:0] mem_data_out,
	 input [7:0] mem_data_in,
	 output mem_start,
	 input mem_done,
	 output mem_rw,
	 
	 //status
	 output spad_error
    );
	 
	/////////////////////////////////////////////////////////////////////////////////
	// Register map taken from Pololu VL53L0X open-source library on github        //
	//																										 //
	/////////////////////////////////////////////////////////////////////////////////
	parameter SYSRANGE_START                              = 8'h00;

	parameter SYSTEM_THRESH_HIGH                          = 8'h0C;
	parameter SYSTEM_THRESH_LOW                           = 8'h0E;

	parameter SYSTEM_SEQUENCE_CONFIG                      = 8'h01;
	parameter SYSTEM_RANGE_CONFIG                         = 8'h09;
	parameter SYSTEM_INTERMEASUREMENT_PERIOD              = 8'h04;

	parameter SYSTEM_INTERRUPT_CONFIG_GPIO                = 8'h0A;

	parameter GPIO_HV_MUX_ACTIVE_HIGH                     = 8'h84;

	parameter SYSTEM_INTERRUPT_CLEAR                      = 8'h0B;

	parameter RESULT_INTERRUPT_STATUS                     = 8'h13;
	parameter RESULT_RANGE_STATUS                         = 8'h14;

	parameter RESULT_CORE_AMBIENT_WINDOW_EVENTS_RTN       = 8'hBC;
	parameter RESULT_CORE_RANGING_TOTAL_EVENTS_RTN        = 8'hC0;
	parameter RESULT_CORE_AMBIENT_WINDOW_EVENTS_REF       = 8'hD0;
	parameter RESULT_CORE_RANGING_TOTAL_EVENTS_REF        = 8'hD4;
	parameter RESULT_PEAK_SIGNAL_RATE_REF                 = 8'hB6;

	parameter ALGO_PART_TO_PART_RANGE_OFFSET_MM           = 8'h28;

	parameter I2C_SLAVE_DEVICE_ADDRESS                    = 8'h8A;

	parameter MSRC_CONFIG_CONTROL                         = 8'h60;

	parameter PRE_RANGE_CONFIG_MIN_SNR                    = 8'h27;
	parameter PRE_RANGE_CONFIG_VALID_PHASE_LOW            = 8'h56;
	parameter PRE_RANGE_CONFIG_VALID_PHASE_HIGH           = 8'h57;
	parameter PRE_RANGE_MIN_COUNT_RATE_RTN_LIMIT          = 8'h64;

	parameter FINAL_RANGE_CONFIG_MIN_SNR                  = 8'h67;
	parameter FINAL_RANGE_CONFIG_VALID_PHASE_LOW          = 8'h47;
	parameter FINAL_RANGE_CONFIG_VALID_PHASE_HIGH         = 8'h48;
	parameter FINAL_RANGE_CONFIG_MIN_COUNT_RATE_RTN_LIMIT = 8'h44;

	parameter PRE_RANGE_CONFIG_SIGMA_THRESH_HI            = 8'h61;
	parameter PRE_RANGE_CONFIG_SIGMA_THRESH_LO            = 8'h62;
	parameter PRE_RANGE_CONFIG_VCSEL_PERIOD               = 8'h50;
	parameter PRE_RANGE_CONFIG_TIMEOUT_MACROP_HI          = 8'h51;
	parameter PRE_RANGE_CONFIG_TIMEOUT_MACROP_LO          = 8'h52;
	parameter SYSTEM_HISTOGRAM_BIN                        = 8'h81;
	parameter HISTOGRAM_CONFIG_INITIAL_PHASE_SELECT       = 8'h33;
	parameter HISTOGRAM_CONFIG_READOUT_CTRL               = 8'h55;
	parameter FINAL_RANGE_CONFIG_VCSEL_PERIOD             = 8'h70;
	parameter FINAL_RANGE_CONFIG_TIMEOUT_MACROP_HI        = 8'h71;
	parameter FINAL_RANGE_CONFIG_TIMEOUT_MACROP_LO        = 8'h72;
	parameter CROSSTALK_COMPENSATION_PEAK_RATE_MCPS       = 8'h20;
	parameter MSRC_CONFIG_TIMEOUT_MACROP                  = 8'h46;

	parameter SOFT_RESET_GO2_SOFT_RESET_N                 = 8'hBF;
	parameter IDENTIFICATION_MODEL_ID                     = 8'hC0;
	parameter IDENTIFICATION_REVISION_ID                  = 8'hC2;
	parameter OSC_CALIBRATE_VAL                           = 8'hF8;
	parameter GLOBAL_CONFIG_VCSEL_WIDTH                   = 8'h32;
	parameter GLOBAL_CONFIG_SPAD_ENABLES_REF_0            = 8'hB0;
	parameter GLOBAL_CONFIG_SPAD_ENABLES_REF_1            = 8'hB1;
	parameter GLOBAL_CONFIG_SPAD_ENABLES_REF_2            = 8'hB2;
	parameter GLOBAL_CONFIG_SPAD_ENABLES_REF_3            = 8'hB3;
	parameter GLOBAL_CONFIG_SPAD_ENABLES_REF_4            = 8'hB4;
	parameter GLOBAL_CONFIG_SPAD_ENABLES_REF_5            = 8'hB5;
	parameter GLOBAL_CONFIG_REF_EN_START_SELECT           = 8'hB6;
	parameter DYNAMIC_SPAD_NUM_REQUESTED_REF_SPAD         = 8'h4E;
	parameter DYNAMIC_SPAD_REF_EN_START_OFFSET            = 8'h4F;
	parameter POWER_MANAGEMENT_GO1_POWER_FORCE            = 8'h80;
	parameter VHV_CONFIG_PAD_SCL_SDA__EXTSUP_HV           = 8'h89;
	parameter ALGO_PHASECAL_LIM                           = 8'h30;
	parameter ALGO_PHASECAL_CONFIG_TIMEOUT                = 8'h30;

	/////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////
	
	/////////////////////////////////////////////////////////////////////////////////
	// Memory map for variables: ram is global 
	/////////////////////////////////////////////////////////////////////////////////
	parameter STOP_VARIABLE = 8'h00;//8-bit
	parameter SPAD_COUNT = 8'h01;//8-bit
	parameter SPAD_TYPE_IS_APERTURE = 8'h02;//bool
	parameter REF_SPAD_MAP = 8'h03; //array
	parameter SEQUENCE_STEP_ENABLE_TCC = 8'h09;//bool
	parameter SEQUENCE_STEP_ENABLE_MSRC = 8'h0A;//bool
	parameter SEQUENCE_STEP_ENABLE_DSS = 8'h0B;//bool
	parameter SEQUENCE_STEP_ENABLE_PRE_RANGE = 8'h0C;//bool
	parameter SEQUENCE_STEP_ENABLE_FINAL_RANGE = 8'h0D;//bool
	parameter SEQUENCE_STEP_TIMEOUTS_PRE_RANGE_VPP = 8'h0E;//16-bit
	parameter SEQUENCE_STEP_TIMEOUTS_FINAL_RANGE_VPP = 8'h10;//16-bit
	parameter SEQUENCE_STEP_TIMEOUTS_MSRC_DTM = 8'h12; //16-bit
	parameter SEQUENCE_STEP_TIMEOUTS_PRE_RANGE_MCLKS = 8'h14; //16-bit
	parameter SEQUENCE_STEP_TIMEOUTS_FINAL_RANGE_MCLKS = 8'h16; //16-bit
	parameter SEQUENCE_STEP_TIMEOUTS_MSRC_DTU = 8'h18; //32-bit
	parameter SEQUENCE_STEP_TIMEOUTS_PRE_RANGE_US = 8'h22; //32-b-t
	parameter SEQUENCE_STEP_TIMEOUTS_FINAL_RANGE_US = 8'h26; //32 bit
	parameter MEASUREMENT_TIMING_BUDGET = 8'h30; //32-bit
	
	//define data_types
	parameter VcselPeriodPreRange = 8'h00;
	parameter VcselPeriodFinalRange = 8'h01;
	 
	//define state parameters
	parameter S_RESET = 2'b00;
	parameter S_TIMEOUT = 2'b01;
	parameter S_WRITE = 2'b10;
	parameter S_DONE = 2'b11;
	
	//define state register and counters
	reg [1:0] state = 2'b00;
	reg [3:0] instruction_count = 4'b0000;
	
	//define output registers
	reg done_reg = 1'b0;
	
	reg write_start_reg = 1'b0;
   reg write_multi_start_reg = 1'b0;
   reg read_start_reg = 1'b0;
	
	reg timer_start_reg = 1'b0;
	reg [3:0] timer_param_reg = 4'b0101;
	reg timer_reset_reg = 1'b1;
	
	reg [7:0] data_out_reg = 1'b0;
	reg [3:0] n_bytes_reg = 4'b0000;
	reg [7:0] reg_address_out_reg = 8'h00;
	
	reg [1:0] fnc_sel_reg = 2'b00;
	 
	reg fifo_read_en_reg = 1'b0;
	reg [7:0] fifo_data_out_reg = 8'h00;
	reg fifo_wr_en_reg = 1'b0;
	reg fifo_ext_reset_reg = 1'b1;
	
	reg [7:0] mem_addr_reg = 8'h00;
	reg [7:0] mem_data_out_reg = 8'h00;
	reg mem_start_reg = 1'b0;
	reg mem_rw_reg = 1'b0;
	
	reg spad_error_reg = 1'b0;
	
	//main FSM implementation
	always @(posedge clk) begin
		if(reset) state <= S_RESET;
		else begin
			case(state)
				S_RESET: begin
					if(start) state <= S_TIMEOUT;
					else state <= S_RESET;
					
					done_reg <= 1'b0;
					
					write_start_reg <= 1'b0;
					write_multi_start_reg <= 1'b0;
					read_start_reg <= 1'b0;
					
					timer_start_reg <= 1'b0;
					timer_param_reg <= 4'b0101;
					timer_reset_reg <= 1'b1;
					
					data_out_reg <= 8'h00;
					n_bytes_reg <= 4'b0000;
					reg_address_out_reg <= 8'h00;
					
					fnc_sel_reg <= 2'b00;
					
					fifo_read_en_reg <= 1'b0;
					fifo_data_out_reg <= 8'h00;
					fifo_wr_en_reg <= 1'b0;
					fifo_ext_reset_reg <= 1'b1;
					
					mem_addr_reg <= 8'h00;
					mem_data_out_reg <= 8'h00;
					mem_rw_reg <= 1'b0;
					mem_start_reg <= 1'b0;
					
					spad_error_reg <= 1'b0;
					
					instruction_count <= 4'b0000;
				end
				S_TIMEOUT: begin
					case(instruction_count)
						4'b0000: begin
							write_start_reg <= 1'b1;
							fnc_sel_reg <= 2'b10; //write
							reg_address_out_reg <= 8'h80;
							data_out_reg <= 8'h01; //set LSB
								
							instruction_count <= instruction_count + 1;
							state <= S_TIMEOUT;
						end
						4'b0001: begin
							if(!write_done) begin
								instruction_count <= instruction_count;
								write_start_reg <= 1'b0;
							end
							else begin
								write_start_reg <= 1'b1;
								fnc_sel_reg <= 2'b10; //write
								reg_address_out_reg <= 8'hFF;
								data_out_reg <= 8'h01;
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_TIMEOUT;
						end
						4'b0010: begin
							if(!write_done) begin
								instruction_count <= instruction_count;
								write_start_reg <= 1'b0;
							end
							else begin
								write_start_reg <= 1'b1;
								fnc_sel_reg <= 2'b10; //write
								reg_address_out_reg <= 8'h00;
								data_out_reg <= 8'h00;
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_TIMEOUT;
						end
						4'b0011: begin
							if(!write_done) begin
								instruction_count <= instruction_count;
								write_start_reg <= 1'b0;
							end
							else begin
								write_start_reg <= 1'b1;
								fnc_sel_reg <= 2'b10; //write
								reg_address_out_reg <= 8'hFF;
								data_out_reg <= 8'h06;
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_TIMEOUT;
						end
						4'b0100: begin
							if(!write_done) begin
								instruction_count <= instruction_count;
								write_start_reg <= 1'b0;
							end
							else begin
								//setup register read
								read_start_reg <= 1'b1;
								fnc_sel_reg <= 2'b01; //sel read
								n_bytes_reg <= 4'b0001;
								reg_address_out_reg <= 8'h83;
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_TIMEOUT;
						end
						4'b0101: begin
							if(!read_done) begin
								instruction_count <= instruction_count;
								read_start_reg <= 1'b0;
							end
							else begin
								fifo_read_en_reg <= 1'b1;
								instruction_count <= instruction_count + 1;
							end
							state <= S_TIMEOUT;
						end
						4'b0110: begin
							if(!fifo_read_valid) begin
								instruction_count <= instruction_count;
								fifo_read_en_reg <= 1'b0;
							end
							else begin
								write_start_reg <= 1'b1;
								fnc_sel_reg <= 2'b10; //write
								reg_address_out_reg <= 8'h83;
								data_out_reg <= fifo_data_in | 8'h04; //set LSB
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_TIMEOUT;
						end
						4'b0111: begin
							if(!write_done) begin
								instruction_count <= instruction_count;
								write_start_reg <= 1'b0;
							end
							else begin
								write_start_reg <= 1'b1;
								fnc_sel_reg <= 2'b10; //write
								reg_address_out_reg <= 8'hFF;
								data_out_reg <= 8'h07;
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_TIMEOUT;
						end
						4'b1000: begin
							if(!write_done) begin
								instruction_count <= instruction_count;
								write_start_reg <= 1'b0;
							end
							else begin
								write_start_reg <= 1'b1;
								fnc_sel_reg <= 2'b10; //write
								reg_address_out_reg <= 8'h81;
								data_out_reg <= 8'h01;
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_TIMEOUT;
						end
						4'b1001: begin
							if(!write_done) begin
								instruction_count <= instruction_count;
								write_start_reg <= 1'b0;
							end
							else begin
								write_start_reg <= 1'b1;
								fnc_sel_reg <= 2'b10; //write
								reg_address_out_reg <= 8'h80;
								data_out_reg <= 8'h01;
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_TIMEOUT;
						end
						4'b1010: begin
							if(!write_done) begin
								instruction_count <= instruction_count;
								write_start_reg <= 1'b0;
							end
							else begin
								write_start_reg <= 1'b1;
								fnc_sel_reg <= 2'b10; //write
								reg_address_out_reg <= 8'h94;
								data_out_reg <= 8'h6B;
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_TIMEOUT;
						end
						4'b1011: begin
							if(!write_done) begin
								instruction_count <= instruction_count;
								write_start_reg <= 1'b0;
							end
							else begin
								write_start_reg <= 1'b1;
								fnc_sel_reg <= 2'b10; //write
								reg_address_out_reg <= 8'h83;
								data_out_reg <= 8'h00;
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_TIMEOUT;
						end
						4'b1100: begin
							if(!write_done) begin
								instruction_count <= instruction_count;
								write_start_reg <= 1'b0;
							end
							else begin
								timer_start_reg <= 1'b1;
								timer_reset_reg <= 1'b1;
								timer_param_reg <= 3'b101; //500ms timeout
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_TIMEOUT;
						end
						4'b1101: begin
							read_start_reg <= 1'b1;
							fnc_sel_reg <= 2'b01; //sel read
							n_bytes_reg <= 4'b0001;
							reg_address_out_reg <= 8'h83;
							
							timer_start_reg <= 1'b0;
							timer_reset_reg <= 1'b0;
							
							instruction_count <= instruction_count + 1;
							state <= S_TIMEOUT;
						end
						4'b1110: begin
							if(!read_done) begin
								instruction_count <= instruction_count;
								read_start_reg <= 1'b0;
							end
							else begin
								fifo_read_en_reg <= 1'b1;
								instruction_count <= instruction_count + 1;
							end
							state <= S_TIMEOUT;
						end
						4'b1111: begin
							if(timer_exp) begin
								state <= S_RESET;
								spad_error_reg <= 1'b1;
								instruction_count <= 4'b0000;
							end
							else if(fifo_data_in == 8'h00) begin //loop until 0x83 reg is not 0x00
								instruction_count <= instruction_count - 2;
								state <= S_TIMEOUT;
							end
							else begin
								instruction_count <= 4'b0000;
								state <= S_WRITE;
							end
							fifo_read_en_reg <= 1'b0;
						end
					endcase
				end
				S_WRITE: begin
					case(instruction_count)
						4'b0000: begin
							write_start_reg <= 1'b1;
							fnc_sel_reg <= 2'b10; //write
							reg_address_out_reg <= 8'h83;
							data_out_reg <= 8'h01; //set LSB
								
							instruction_count <= instruction_count + 1;
							state <= S_WRITE;
						end
						4'b0001: begin
							if(!write_done) begin
								instruction_count <= instruction_count;
								write_start_reg <= 1'b0;
							end
							else begin
								read_start_reg <= 1'b1;
								fnc_sel_reg <= 2'b01; //sel read
								n_bytes_reg <= 4'b0001;
								reg_address_out_reg <= 8'h92;
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_WRITE;
						end
						4'b0010: begin
							if(!read_done) begin
								instruction_count <= instruction_count;
								read_start_reg <= 1'b0;
							end
							else begin
								fifo_read_en_reg <= 1'b1;
								instruction_count <= instruction_count + 1;
							end
							state <= S_WRITE;
						end
						4'b0011: begin
							if(!fifo_read_valid) begin
								instruction_count <= instruction_count;
								fifo_read_en_reg <= 1'b0;
							end
							else begin
								mem_addr_reg <= SPAD_COUNT;
								mem_data_out_reg <= fifo_data_in & 8'h7F;
								mem_rw_reg <= 1'b1;
								mem_start_reg <= 1'b1;
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_WRITE;
						end
						4'b0100: begin
							if(!mem_done) begin
								instruction_count <= instruction_count;
								mem_start_reg <= 1'b0;
							end
							else begin
								write_start_reg <= 1'b1;
								fnc_sel_reg <= 2'b10; //write
								reg_address_out_reg <= 8'h81;
								data_out_reg <= 8'h00; //set LSB
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_WRITE;
						end
						4'b0101: begin
							if(!write_done) begin
								instruction_count <= instruction_count;
								write_start_reg <= 1'b0;
							end
							else begin
								mem_addr_reg <= SPAD_TYPE_IS_APERTURE;
								mem_data_out_reg <= (fifo_data_in >> 7) & 8'h01;
								mem_start_reg <= 1'b1;
								mem_rw_reg <= 1'b1;
								
								write_start_reg <= 1'b1;
								fnc_sel_reg <= 2'b10; //write
								reg_address_out_reg <= 8'hFF;
								data_out_reg <= 8'h06; //set LSB
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_WRITE;
						end
						4'b0110: begin
							if(!write_done) begin
								instruction_count <= instruction_count;
								write_start_reg <= 1'b0;
								mem_start_reg <= 1'b0;
							end
							else begin
								read_start_reg <= 1'b1;
								fnc_sel_reg <= 2'b01; //sel read
								n_bytes_reg <= 4'b0001;
								reg_address_out_reg <= 8'h83;
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_WRITE;
						end
						4'b0111: begin
							if(!read_done) begin
								instruction_count <= instruction_count;
								read_start_reg <= 1'b0;
							end
							else begin
								fifo_read_en_reg <= 1'b1;
								instruction_count <= instruction_count + 1;
							end
							state <= S_WRITE;
						end
						4'b1000: begin
							if(!fifo_read_valid) begin
								instruction_count <= instruction_count;
								fifo_read_en_reg <= 1'b0;
							end
							else begin
								write_start_reg <= 1'b1;
								fnc_sel_reg <= 2'b10; //write
								reg_address_out_reg <= 8'h83;
								data_out_reg <= fifo_data_in & ~(8'h04); //set LSB
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_WRITE;
						end
						4'b1001: begin
							if(!write_done) begin
								instruction_count <= instruction_count;
								write_start_reg <= 1'b0;
							end
							else begin
								write_start_reg <= 1'b1;
								fnc_sel_reg <= 2'b10; //write
								reg_address_out_reg <= 8'hFF;
								data_out_reg <= 8'h01; //set LSB
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_WRITE;
						end
						4'b1010: begin
							if(!write_done) begin
								instruction_count <= instruction_count;
								write_start_reg <= 1'b0;
							end
							else begin
								write_start_reg <= 1'b1;
								fnc_sel_reg <= 2'b10; //write
								reg_address_out_reg <= 8'h00;
								data_out_reg <= 8'h01; //set LSB
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_WRITE;
						end
						4'b1011: begin
							if(!write_done) begin
								instruction_count <= instruction_count;
								write_start_reg <= 1'b0;
							end
							else begin
								write_start_reg <= 1'b1;
								fnc_sel_reg <= 2'b10; //write
								reg_address_out_reg <= 8'hFF;
								data_out_reg <= 8'h00; //set LSB
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_WRITE;
						end
						4'b1100: begin
							if(!write_done) begin
								instruction_count <= instruction_count;
								write_start_reg <= 1'b0;
								state <= S_WRITE;
							end
							else begin
								write_start_reg <= 1'b1;
								fnc_sel_reg <= 2'b10; //write
								reg_address_out_reg <= 8'h80;
								data_out_reg <= 8'h00; //set LSB
								
								instruction_count <= 4'b0000;
								state <= S_DONE;
							end
						end
						default: state <= S_RESET;
					endcase
				end
				S_DONE: begin
					if(!write_done) begin
						write_start_reg <= 1'b0;
						state <= S_DONE;
					end
					else begin
						state <= S_RESET;
						write_start_reg <= 1'b0;
						done_reg <= 1'b1;
					end
				end
			endcase
		end
	end
	
	//assign registers to outputs 
	assign done = done_reg;
	
	assign timer_start = timer_start_reg;
	assign timer_param = timer_param_reg;
	assign timer_reset = timer_reset_reg;

   assign write_start = write_start_reg;
   assign write_multi_start = write_multi_start_reg;
   assign read_start = read_start_reg;
	
	assign data_out = data_out_reg;
	assign n_bytes = n_bytes_reg;
	assign reg_address_out = reg_address_out_reg;
	
	assign fnc_sel = fnc_sel_reg;
	 
	assign fifo_read_en = fifo_read_en_reg;
	assign fifo_data_out = fifo_data_out_reg;
	assign fifo_wr_en = fifo_wr_en_reg;
	assign fifo_ext_reset = fifo_ext_reset_reg;
	
	assign mem_addr = mem_addr_reg;
	assign mem_data_out = mem_data_out_reg;
	assign mem_start = mem_start_reg;
	assign mem_rw = mem_rw_reg;
	
	assign spad_error = spad_error_reg;

endmodule
