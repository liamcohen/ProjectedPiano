`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:02:43 11/28/2017 
// Design Name: 
// Module Name:    VL53L0X_INIT 
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


module VL53L0X_INIT(
	 //FSM start and done
	 input clk,
	 input reset,
	 input start,
    output done,
	 input comm_error,
	 
	 //talk to timer
	 input timer_exp,
	 output timer_start,
	 output [3:0] timer_param,
	 output timer_reset,
	 
	 //start and done for read, write, and write_multi FSMs
    output write_start,
    input write_done,
    output write_multi_start,
    input write_multi_done,
    output read_start,
    input read_done,
	 
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
	 output init_error,
	 
	 //debug
	 output [4:0] instruction_count_debug,
	 output [5:0] instruction_count_timeout_debug,
	 output [31:0] timeout_period_us,
	 output timing_start_out
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
	
	/////////////////////////////////////////////////////////////////////////////////
	// 8 byte wide registers for tmp-variables 
	/////////////////////////////////////////////////////////////////////////////////
	reg [7:0] tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7;

	//define state parameters
	parameter S_RESET = 2'b00;
	parameter S_DATA_INIT = 2'b01;
	parameter S_STATIC_INIT = 2'b10;
	parameter S_PERFORM_REF_CALIBRATION = 2'b11;
	
	//define state register and counters
	reg [1:0] state = 2'b00;
	reg [4:0] instruction_count = 5'b00000;
	reg [7:0] count = 8'h00;
	
	//define output registers
	reg done_reg = 1'b0;

	reg timer_start_reg = 1'b0;
	reg [3:0] timer_param_reg = 4'b0001;
	reg timer_reset_reg = 1'b1;

   reg write_start_reg = 1'b0;
   reg write_multi_start_reg = 1'b0;
   reg read_start_reg = 1'b0;
	
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
	
	reg init_error_reg = 1'b0;
	
	////////////////////////////////////////////////////////////////////////////
	// Local ROM to store large number of register writes
	////////////////////////////////////////////////////////////////////////////
	wire [15:0] rom_data;
	reg [7:0] rom_addr_reg = 8'h00; 
	
	ROM INIT_ROM (
		.clka(clk),
		.addra(rom_addr_reg),
		.douta(rom_data)
	);
	
	////////////////////////////////////////////////////////////////////////////
	// Sub-FSM GetSPADInfo
	////////////////////////////////////////////////////////////////////////////
	reg spad_start = 1'b0;
	wire spad_done;
	
	wire write_start_spad;
	wire write_multi_start_spad;
	wire read_start_spad;
	
	wire timer_start_spad;
	wire [3:0] timer_param_spad;
	wire timer_reset_spad;
	
	wire [7:0] reg_address_out_spad;
	wire [7:0] data_out_spad;
	wire [3:0] n_bytes_spad;
	
	wire [1:0] fnc_sel_spad;
	
	wire [7:0] fifo_data_out_spad;
	wire fifo_wr_en_spad;
	wire fifo_ext_reset_spad;
	wire fifo_read_en_spad;
	
	wire [7:0] mem_addr_spad;
	wire [7:0] mem_data_out_spad;
	wire mem_start_spad;
	wire mem_rw_spad;
	
	wire spad_error;
	
	get_spad_info get_spad_info(
		.reset(reset),
		.clk(clk),
		.start(spad_start),
		.done(spad_done),
		
		.write_start(write_start_spad),
		.write_done(write_done),
		.write_multi_start(write_multi_start_spad),
		.write_multi_done(write_multi_done),
		.read_start(read_start_spad),
		.read_done(read_done),
		
		.timer_exp(timer_exp),
		.timer_start(timer_start_spad),
		.timer_param(timer_param_spad),
		.timer_reset(timer_reset_spad),
		
		.reg_address_out(reg_address_out_spad),
		.data_out(data_out_spad),
		.n_bytes(n_bytes_spad),
		
		.fnc_sel(fnc_sel_spad),
		
		.fifo_data_out(fifo_data_out_spad),
		.fifo_wr_en(fifo_wr_en_spad),
	   .fifo_ext_reset(fifo_ext_reset_spad),
	   .fifo_full(fifo_full),
	   .fifo_write_ack(fifo_write_ack),
	   .fifo_overflow(fifo_overflow),
		
		.fifo_data_in(fifo_data_in),
	   .fifo_read_en(fifo_read_en_spad),
	   .fifo_empty(fifo_empty),
	   .fifo_read_valid(fifo_read_valid),
	   .fifo_underflow(fifo_underflow),
		
		.mem_addr(mem_addr_spad),
	   .mem_data_out(mem_data_out_spad),
	   .mem_data_in(mem_data_in),
	   .mem_start(mem_start_spad),
		.mem_done(mem_done),
		.mem_rw(mem_rw_spad),
		
		.spad_error(spad_error)
	);
	
	////////////////////////////////////////////////////////////////////////////
	// Sub-FSM getMeasurementTimingBudget
	////////////////////////////////////////////////////////////////////////////
	reg timing_start = 1'b0;
	wire timing_done;
	wire [31:0] timing_budget;
	
	wire write_start_timing;
	wire write_multi_start_timing;
	wire read_start_timing;
	
	wire timer_start_timing;
	wire [3:0] timer_param_timing;
	wire timer_reset_timing;
	
	wire [7:0] reg_address_out_timing;
	wire [7:0] data_out_timing;
	wire [3:0] n_bytes_timing;
	
	wire [1:0] fnc_sel_timing;
	
	wire [7:0] fifo_data_out_timing;
	wire fifo_wr_en_timing;
	wire fifo_ext_reset_timing;
	wire fifo_read_en_timing;
	
	wire [7:0] mem_addr_timing;
	wire [7:0] mem_data_out_timing;
	wire mem_start_timing;
	wire mem_rw_timing;
	
	wire timing_error;
	wire [5:0] instruction_count_timeout;
	
	getMeasurementTimingBudget getMeasurementTimingBudget(
		.reset(reset),
		.clk(clk),
		.start(timing_start),
		.done(timing_done),
		.timing_budget(timing_budget),
		
		.write_start(write_start_timing),
		.write_done(write_done),
		.write_multi_start(write_multi_start_timing),
		.write_multi_done(write_multi_done),
		.read_start(read_start_timing),
		.read_done(read_done),
		
		.timer_exp(timer_exp),
		.timer_start(timer_start_timing),
		.timer_param(timer_param_timing),
		.timer_reset(timer_reset_timing),
		
		.reg_address_out(reg_address_out_timing),
		.data_out(data_out_timing),
		.n_bytes(n_bytes_timing),
		
		.fnc_sel(fnc_sel_timing),
		
		.fifo_data_out(fifo_data_out_timing),
		.fifo_wr_en(fifo_wr_en_timing),
	   .fifo_ext_reset(fifo_ext_reset_timing),
	   .fifo_full(fifo_full),
	   .fifo_write_ack(fifo_write_ack),
	   .fifo_overflow(fifo_overflow),
		
		.fifo_data_in(fifo_data_in),
	   .fifo_read_en(fifo_read_en_timing),
	   .fifo_empty(fifo_empty),
	   .fifo_read_valid(fifo_read_valid),
	   .fifo_underflow(fifo_underflow),
		
		.mem_addr(mem_addr_timing),
	   .mem_data_out(mem_data_out_timing),
	   .mem_data_in(mem_data_in),
	   .mem_start(mem_start_timing),
		.mem_done(mem_done),
		.mem_rw(mem_rw_timing),
		
		.timing_budget_error(timing_error),
		.instruction_count_debug(instruction_count_timeout),
		.timeout_period_us(timeout_period_us)
	);
	
	////////////////////////////////////////////////////////////////////////////
	// Main FSM implementation
	////////////////////////////////////////////////////////////////////////////
	
	always @(posedge clk) begin
		if(reset | comm_error) state <= S_RESET;
		else begin
			case(state)
				S_RESET: begin
					if(start) state <= S_DATA_INIT;
					else state <= S_RESET;
					
					done_reg <= 1'b0;
					
					timer_start_reg <= 1'b0;
					timer_param_reg <= 4'b0001;
					timer_reset_reg <= 1'b1;
					
					write_start_reg <= 1'b0;
					write_multi_start_reg <= 1'b0;
					read_start_reg <= 1'b0;
					
					data_out_reg <= 1'b0;
					n_bytes_reg <= 4'b0000;
					reg_address_out_reg <= 8'h00;
					
					fnc_sel_reg <= 2'b00;
					
					fifo_read_en_reg <= 1'b0;
					fifo_data_out_reg <= 8'h00;
					fifo_wr_en_reg <= 1'b0;
					fifo_ext_reset_reg <= 1'b1;
					
					rom_addr_reg <= 8'h00;
					mem_addr_reg <= 8'h00;
					mem_data_out_reg <= 8'h00;
					mem_start_reg <= 1'b0;
					mem_rw_reg <= 1'b0;
					
					init_error_reg <= 1'b0;
					
					spad_start <= 1'b0;
					timing_start <= 1'b0;
					
					instruction_count <= 5'b00000;
					count <= 8'h00;
					
					tmp0 <= 8'h00;
					tmp0 <= 8'h00;
					tmp2 <= 8'h00;
					tmp3 <= 8'h00;
					tmp4 <= 8'h00;
					tmp5 <= 8'h00;
					tmp6 <= 8'h00;
					tmp7 <= 8'h00;
				end
				S_DATA_INIT: begin
					case(instruction_count)
						///////////////////////////////////////////////////////////////
						// Setting IO voltage to 2.8 V
						///////////////////////////////////////////////////////////////
						5'b00000: begin
							//setup register read
							read_start_reg <= 1'b1;
							fnc_sel_reg <= 2'b01; //sel read
							n_bytes_reg <= 4'b0001;
							reg_address_out_reg <= VHV_CONFIG_PAD_SCL_SDA__EXTSUP_HV;
							
							state <= S_DATA_INIT;
							instruction_count <= instruction_count + 1;
						end
						5'b00001: begin
							//read data out of FIFO
							if(!read_done) begin
								instruction_count <= instruction_count;
								read_start_reg <= 1'b0;
							end
							else begin
								fifo_read_en_reg <= 1'b1;
								instruction_count <= instruction_count + 1;
							end
							state <= S_DATA_INIT;
						end
						5'b00010: begin
							//WRITE DATA USING VALUE FROM READ
							if(!fifo_read_valid) begin
								instruction_count <= instruction_count;
								fifo_read_en_reg <= 1'b0;
							end
							else begin
								write_start_reg <= 1'b1;
								fnc_sel_reg <= 2'b10; //write
								reg_address_out_reg <= VHV_CONFIG_PAD_SCL_SDA__EXTSUP_HV;
								data_out_reg <= fifo_data_in | 8'h01; //set LSB
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_DATA_INIT;
						end
						///////////////////////////////////////////////////////////////
						// Set I2C standard mode
						///////////////////////////////////////////////////////////////
						5'b00011: begin
							if(!write_done) begin
								instruction_count <= instruction_count;
								write_start_reg <= 1'b0;
							end
							else begin
								write_start_reg <= 1'b1;
								fnc_sel_reg <= 2'b10; //write
								reg_address_out_reg <= rom_data[15:8];
								data_out_reg <= rom_data[7:0];
								
								if(rom_addr_reg < 3) instruction_count <= instruction_count;
								else instruction_count <= instruction_count + 1;
								
								rom_addr_reg <= rom_addr_reg + 1;
							end
							state <= S_DATA_INIT;
						end
						5'b00100: begin
							if(!write_done) begin
								instruction_count <= instruction_count;
								write_start_reg <= 1'b0;
							end
							else begin
								//setup register read
								read_start_reg <= 1'b1;
								fnc_sel_reg <= 2'b01; //sel read
								n_bytes_reg <= 4'b0001;
								reg_address_out_reg <= 8'h91;
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_DATA_INIT;
						end
						5'b00101: begin
							if(!read_done) begin
								instruction_count <= instruction_count;
								read_start_reg <= 1'b0;
							end
							else begin
								fifo_read_en_reg <= 1'b1;
								instruction_count <= instruction_count + 1;
							end
							state <= S_DATA_INIT;
						end
						5'b00110: begin
							if(!fifo_read_valid) begin
								instruction_count <= instruction_count;
								fifo_read_en_reg <= 1'b0;
							end
							else begin
								//write STOP_VARIABLE to ram
								mem_addr_reg <= STOP_VARIABLE;
								mem_data_out_reg <= fifo_data_in;
								mem_start_reg <= 1'b1;
								mem_rw_reg <= 1'b1;
								
								//start next write after storing data for ROM addr 4
								write_start_reg <= 1'b1;
								fnc_sel_reg <= 2'b10; //write
								reg_address_out_reg <= rom_data[15:8];
								data_out_reg <= rom_data[7:0];
								rom_addr_reg <= rom_addr_reg + 1;
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_DATA_INIT;
						end
						5'b00111: begin
							if(!write_done) begin
								instruction_count <= instruction_count;
								write_start_reg <= 1'b0;
								mem_start_reg <= 1'b0;
							end
							else begin
								write_start_reg <= 1'b1;
								fnc_sel_reg <= 2'b10; //write
								reg_address_out_reg <= rom_data[15:8];
								data_out_reg <= rom_data[7:0];
								
								if(rom_addr_reg < 6) instruction_count <= instruction_count;
								else instruction_count <= instruction_count + 1;
								
								rom_addr_reg <= rom_addr_reg + 1;
							end
							state <= S_DATA_INIT;
						end
						///////////////////////////////////////////////////////////
						// disable SIGNAL_RATE_MSRC (bit 1) 
						// and SIGNAL_RATE_PRE_RANGE (bit 4) limit checks
						///////////////////////////////////////////////////////////
						5'b01000: begin
							//setup register read
							if(!write_done) begin
								instruction_count <= instruction_count;
								write_start_reg <= 1'b0;
							end
							else begin
								read_start_reg <= 1'b1;
								fnc_sel_reg <= 2'b01; //sel read
								n_bytes_reg <= 4'b0001;
								reg_address_out_reg <= MSRC_CONFIG_CONTROL;
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_DATA_INIT;
						end
						5'b01001: begin
							if(!read_done) begin
								instruction_count <= instruction_count;
								read_start_reg <= 1'b0;
							end
							else begin
								fifo_read_en_reg <= 1'b1;
								instruction_count <= instruction_count + 1;
							end
							state <= S_DATA_INIT;
						end
						5'b01010: begin
							if(!fifo_read_valid) begin
								instruction_count <= instruction_count;
								fifo_read_en_reg <= 1'b0;
							end
							else begin
								write_start_reg <= 1'b1;
								fnc_sel_reg <= 2'b10; //write
								reg_address_out_reg <= MSRC_CONFIG_CONTROL;
								data_out_reg <= fifo_data_in | 8'h12; //set LSB
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_DATA_INIT;
						end
						///////////////////////////////////////////////////////////
						// SET SIGNAL RATE LIMIT = 0.25 MCPS
						///////////////////////////////////////////////////////////
						5'b01011: begin
							//write multiple bytes to write_multi FIFO
							if(!write_done) begin
								instruction_count <= instruction_count;
								write_start_reg <= 1'b0;
							end
							else begin
								fifo_wr_en_reg <= 1'b1;
								fifo_data_out_reg <= 8'h00; //32 in hex --> lim_MCPS = 0.25
								instruction_count <= instruction_count + 1;
							end
						end
						5'b01100: begin
							if(!fifo_write_ack) begin
								instruction_count <= instruction_count;
								fifo_wr_en_reg <= 1'b0;
							end
							else begin
								fifo_wr_en_reg <= 1'b1;
								fifo_data_out_reg <= 8'h20; //32 in hex --> lim_MCPS = 0.25
								instruction_count <= instruction_count + 1;
							end
						end
						5'b01101: begin
							if(!fifo_write_ack) begin
								instruction_count <= instruction_count;
								fifo_wr_en_reg <= 1'b0;
							end
							else begin
								//setup register write_multi
								write_multi_start_reg <= 1'b1;
								fnc_sel_reg <= 2'b11; //sel write_multi
								n_bytes_reg <= 4'b0010;
								reg_address_out_reg <= FINAL_RANGE_CONFIG_MIN_COUNT_RATE_RTN_LIMIT;
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_DATA_INIT;
						end
						///////////////////////////////////////////////////////////////
						// SET SYSTEM_SEQUENCE_CONFIG
						///////////////////////////////////////////////////////////////
						5'b01110: begin
							if(!write_multi_done) begin
								instruction_count <= instruction_count;
								write_multi_start_reg <= 1'b0;
							end
							else begin
								//setup register write
								write_start_reg <= 1'b1;
								fnc_sel_reg <= 2'b10; //sel write
								reg_address_out_reg <= SYSTEM_SEQUENCE_CONFIG;
								data_out_reg <= 8'hFF;
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_DATA_INIT;
						end
						5'b01111: begin
							if(!write_done) begin
								instruction_count <= instruction_count;
								write_start_reg <= 1'b0;
								state <= S_DATA_INIT;
							end
							else begin
								state <= S_STATIC_INIT;
								instruction_count <= 4'b0000;
							end
						end
						default: state <= S_RESET;
					endcase
				end
				S_STATIC_INIT: begin
					case(instruction_count)
						///////////////////////////////////////////////////////////////
						// Set SPAD Map
						///////////////////////////////////////////////////////////////
						5'b00000: begin
							//shift FSM Control to getSPADInfo
							spad_start <= 1'b1;
							
							write_start_reg <= write_start_spad;
							write_multi_start_reg <= write_multi_start_spad;
							read_start_reg <= read_start_spad;
							
							timer_start_reg <= timer_start_spad;
							timer_param_reg <= timer_param_spad;
							timer_reset_reg <= timer_reset_spad;
							
							reg_address_out_reg <= reg_address_out_spad;
							data_out_reg <= data_out_spad;
							n_bytes_reg <= n_bytes_spad;
							
							fnc_sel_reg <= fnc_sel_spad;
							
							fifo_data_out_reg <= fifo_data_out_spad;
							fifo_wr_en_reg <= fifo_wr_en_spad;
							fifo_ext_reset_reg <= fifo_ext_reset_spad;
							fifo_read_en_reg <= fifo_read_en_spad;
							
							mem_addr_reg <= mem_addr_spad;
							mem_data_out_reg <= mem_data_out_spad;
							mem_start_reg <= mem_start_spad;
							mem_rw_reg <= mem_rw_spad;
							
							init_error_reg <= spad_error;
							
							instruction_count <= instruction_count + 1;
							state <= S_STATIC_INIT;
						end
						5'b00001: begin
							if(!spad_done) begin
								//let spad-info fsm control outputs until it is finished.
								spad_start <= 1'b0;
								
								write_start_reg <= write_start_spad;
								write_multi_start_reg <= write_multi_start_spad;
								read_start_reg <= read_start_spad;
								
								timer_start_reg <= timer_start_spad;
								timer_param_reg <= timer_param_spad;
								timer_reset_reg <= timer_reset_spad;
								
								reg_address_out_reg <= reg_address_out_spad;
								data_out_reg <= data_out_spad;
								n_bytes_reg <= n_bytes_spad;
								
								fnc_sel_reg <= fnc_sel_spad;
								
								fifo_data_out_reg <= fifo_data_out_spad;
								fifo_wr_en_reg <= fifo_wr_en_spad;
								fifo_ext_reset_reg <= fifo_ext_reset_spad;
								fifo_read_en_reg <= fifo_read_en_spad;
								
								mem_addr_reg <= mem_addr_spad;
								mem_data_out_reg <= mem_data_out_spad;
								mem_start_reg <= mem_start_spad;
								mem_rw_reg <= mem_rw_spad;
								
								init_error_reg <= spad_error;
								
								state <= S_STATIC_INIT;
								instruction_count <= instruction_count;
							end
							else begin
								state <= S_STATIC_INIT;
								instruction_count <= instruction_count + 1;
							end
						end
						5'b00010: begin
							//setup register read
							read_start_reg <= 1'b1;
							fnc_sel_reg <= 2'b01; //sel read
							n_bytes_reg <= 4'b0110;
							reg_address_out_reg <= GLOBAL_CONFIG_SPAD_ENABLES_REF_0;
								
							instruction_count <= instruction_count + 1;
							state <= S_STATIC_INIT;
						end
						5'b00011: begin
							if(!read_done) begin
								instruction_count <= instruction_count;
								read_start_reg <= 1'b0;
							end
							else begin
								fifo_read_en_reg <= 1'b1;
								instruction_count <= instruction_count + 1;
							end
							mem_addr_reg <= REF_SPAD_MAP;
							state <= S_STATIC_INIT;
						end
						5'b00100: begin
							if(!fifo_read_valid) begin
								instruction_count <= instruction_count;
								fifo_read_en_reg <= 1'b0;
							end
							else begin
								//write ref_spad_map to ram (starting from &REF_SPAD_MAP and ending on
								// &REF_SPAD_MAP + 6)
								mem_data_out_reg <= fifo_data_in;
								mem_start_reg <= 1'b1;
								mem_rw_reg <= 1'b1;
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_STATIC_INIT;
						end
						5'b00101: begin
							if(!mem_done) begin
								instruction_count <= instruction_count;
								mem_start_reg <= 1'b0;
							end
							else begin								
								if(mem_addr_reg < (REF_SPAD_MAP + 5)) begin
									instruction_count <= instruction_count - 1;
									mem_addr_reg <= mem_addr_reg + 1;
									fifo_read_en_reg <= 1'b1;
								end 
								else begin
									instruction_count <= instruction_count + 1;
								end
							end
							state <= S_STATIC_INIT;
						end
						5'b00110: begin
							write_start_reg <= 1'b1;
							fnc_sel_reg <= 2'b10; //write
							reg_address_out_reg <= 8'hFF;
							data_out_reg <= 8'h01;
							
							instruction_count <= instruction_count + 1;
							state <= S_STATIC_INIT;
						end
						5'b00111: begin
							if(!write_done) begin
								instruction_count <= instruction_count;
								write_start_reg <= 1'b0;
							end
							else begin
								write_start_reg <= 1'b1;
								fnc_sel_reg <= 2'b10; //write
								reg_address_out_reg <= DYNAMIC_SPAD_REF_EN_START_OFFSET;
								data_out_reg <= 8'h00;
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_STATIC_INIT;
						end
						5'b01000: begin
							if(!write_done) begin
								instruction_count <= instruction_count;
								write_start_reg <= 1'b0;
							end
							else begin
								write_start_reg <= 1'b1;
								fnc_sel_reg <= 2'b10; //write
								reg_address_out_reg <= DYNAMIC_SPAD_NUM_REQUESTED_REF_SPAD;
								data_out_reg <= 8'h2C;
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_STATIC_INIT;
						end
						5'b01001: begin
							if(!write_done) begin
								instruction_count <= instruction_count;
								write_start_reg <= 1'b0;
							end
							else begin
								write_start_reg <= 1'b1;
								fnc_sel_reg <= 2'b10; //write
								reg_address_out_reg <= 8'hFF;
								data_out_reg <= 8'h00;
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_STATIC_INIT;
						end
						5'b01010: begin
							if(!write_done) begin
								instruction_count <= instruction_count;
								write_start_reg <= 1'b0;
							end
							else begin
								write_start_reg <= 1'b1;
								fnc_sel_reg <= 2'b10; //write
								reg_address_out_reg <= GLOBAL_CONFIG_REF_EN_START_SELECT;
								data_out_reg <= 8'hB4;
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_STATIC_INIT;
						end
						5'b01011: begin
							if(!write_done) begin
								instruction_count <= instruction_count;
								write_start_reg <= 1'b0;
							end
							else begin
								//read SPAD_TYPE_IS_APERTURE from RAM
								//when mem_done goes high, data will be available on 
								//mem_data_in line.
								mem_rw_reg <= 1'b0;
								mem_start_reg <= 1'b1;
								mem_addr_reg <= SPAD_TYPE_IS_APERTURE;
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_STATIC_INIT;
						end
						5'b01100: begin
							if(!mem_done) begin
								mem_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								tmp0 <= mem_data_in[0] ? 8'd12 : 8'd0; //first spad to enable
								tmp1 <= 8'd0; //spads_enabled
								count <= 8'h00;
								
								//read SPAD_COUNT from RAM
								mem_rw_reg <= 1'b0;
								mem_start_reg <= 1'b1;
								mem_addr_reg <= SPAD_COUNT;
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_STATIC_INIT;
						end
						5'b01101: begin
							if(!mem_done) begin
								mem_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								tmp2 <= mem_data_in; //spad_count
								instruction_count <= instruction_count + 1;
								
								//dummy memory read to kick off next part
								mem_addr_reg <= 8'h00;
								mem_rw_reg <= 1'b0;
								mem_start_reg <= 1'b1;
							end
							state <= S_STATIC_INIT;
						end
						5'b01110: begin
							if(!mem_done) begin
								instruction_count <= instruction_count;
								mem_start_reg <= 1'b0;
							end
							else begin 
								mem_addr_reg <= REF_SPAD_MAP + (count >> 3);
								mem_rw_reg <= 1'b0;
								mem_start_reg <= 1'b1;
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_STATIC_INIT;
						end
						5'b01111: begin
							if(!mem_done) begin
								instruction_count <= instruction_count;
								mem_start_reg <= 1'b0;
							end
							else begin
								if(count < 8'd48) begin
									if(count < tmp0 || tmp1 == tmp2) begin
										mem_rw_reg <= 1'b1;
										mem_data_out_reg <= mem_data_in & ~(1 << (count % 8));
										mem_start_reg <= 1'b1;
									end
									else if((mem_data_in >> (count % 8)) & 8'h01) begin
										tmp1 <= tmp1 + 1;
										
										//dummy memory read
										mem_rw_reg <= 1'b0;
										mem_start_reg <= 1'b1;
									end 
									else begin
										//dummy memory read
										mem_rw_reg <= 1'b0;
										mem_start_reg <= 1'b1;
									end
									count <= count + 1;
									instruction_count <= instruction_count - 1;
								end
								else begin
									count <= 8'h00;
									instruction_count <= instruction_count + 1;
								end
							end
							state <= S_STATIC_INIT;
						end
						5'b10000: begin
							//write out modified ref_spad_map
							mem_addr_reg <= REF_SPAD_MAP;
							mem_rw_reg <= 1'b0;
							mem_start_reg <= 1'b1;
							
							instruction_count <= instruction_count + 1;
							state <= S_STATIC_INIT;
						end
						5'b10001: begin
							if(!mem_done) begin
								instruction_count <= instruction_count;
								mem_start_reg <= 1'b0;
							end
							else begin
								//write multiple bytes to write_multi FIFO
								fifo_wr_en_reg <= 1'b1;
								fifo_data_out_reg <= mem_data_in;
								instruction_count <= instruction_count + 1;
							end
							state <= S_STATIC_INIT;
						end
						5'b10010: begin
							if(!fifo_write_ack) begin
								instruction_count <= instruction_count;
								fifo_wr_en_reg <= 1'b0;
							end
							else begin
								if(mem_addr_reg < REF_SPAD_MAP + 5) begin
									mem_addr_reg <= mem_addr_reg + 1;
									mem_rw_reg <= 1'b0;
									mem_start_reg <= 1'b1;
									
									instruction_count <= instruction_count - 1;
								end
								else begin
									instruction_count <= instruction_count + 1;
								end
							end
							state <= S_STATIC_INIT;
						end
						5'b10011: begin
							//setup register write_multi
							write_multi_start_reg <= 1'b1;
							fnc_sel_reg <= 2'b11; //sel write_multi
							n_bytes_reg <= 4'b0110;
							reg_address_out_reg <= GLOBAL_CONFIG_SPAD_ENABLES_REF_0;
							
							instruction_count <= instruction_count + 1;
							state <= S_STATIC_INIT;
						end
						///////////////////////////////////////////////////////////////
						// LOAD DEFAULT TUNING SETTINGS FROM INIT ROM
						///////////////////////////////////////////////////////////////
						5'b10100: begin
							if(!write_multi_done) begin
								write_multi_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								write_start_reg <= 1'b1;
								fnc_sel_reg <= 2'b10; //write
								reg_address_out_reg <= rom_data[15:8];
								data_out_reg <= rom_data[7:0];
								rom_addr_reg <= rom_addr_reg + 1;
								instruction_count <= instruction_count + 1;
							end
							state <= S_STATIC_INIT;
						end
						5'b10101: begin
							if(!write_done) begin
								write_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								write_start_reg <= 1'b1;
								fnc_sel_reg <= 2'b10; //write
								reg_address_out_reg <= rom_data[15:8];
								data_out_reg <= rom_data[7:0];
								
								if(rom_addr_reg < 86) instruction_count <= instruction_count;
								else instruction_count <= instruction_count + 1;
								
								rom_addr_reg <= rom_addr_reg + 1;
							end
							state <= S_STATIC_INIT;
						end
						///////////////////////////////////////////////////////////////
						// Set interrupt config to new sample ready
						///////////////////////////////////////////////////////////////
						5'b10110: begin
							if(!write_done) begin
								write_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								write_start_reg <= 1'b1;
								fnc_sel_reg <= 2'b10; //write
								reg_address_out_reg <= SYSTEM_INTERRUPT_CONFIG_GPIO;
								data_out_reg <= 8'h04;
							
								instruction_count <= instruction_count + 1;
							end
							state <= S_STATIC_INIT;
						end
						5'b10111: begin
							if(!write_done) begin
								write_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								read_start_reg <= 1'b1;
								fnc_sel_reg <= 2'b01; //sel read
								n_bytes_reg <= 4'b0001;
								reg_address_out_reg <= GPIO_HV_MUX_ACTIVE_HIGH;
							
								instruction_count <= instruction_count + 1;
							end
							state <= S_STATIC_INIT;
						end
						5'b11000: begin
							//read data out of FIFO
							if(!read_done) begin
								instruction_count <= instruction_count;
								read_start_reg <= 1'b0;
							end
							else begin
								fifo_read_en_reg <= 1'b1;
								instruction_count <= instruction_count + 1;
							end
							state <= S_STATIC_INIT;
						end
						5'b11001: begin
							if(!fifo_read_valid) begin
								instruction_count <= instruction_count;
								fifo_read_en_reg <= 1'b0;
							end
							else begin
								write_start_reg <= 1'b1;
								fnc_sel_reg <= 2'b10; //write
								reg_address_out_reg <= GPIO_HV_MUX_ACTIVE_HIGH;
								data_out_reg <= fifo_data_in & ~8'h10; //set LSB
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_STATIC_INIT;
						end
						5'b11010: begin
							if(!write_done) begin
								write_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								write_start_reg <= 1'b1;
								fnc_sel_reg <= 2'b10; //write
								reg_address_out_reg <= SYSTEM_INTERRUPT_CLEAR;
								data_out_reg <= 8'h01;
							
								instruction_count <= instruction_count + 1;
							end
							state <= S_STATIC_INIT;
						end
						///////////////////////////////////////////////////////////////
						// getMeasurementTimingBudget
						///////////////////////////////////////////////////////////////
						5'b11011: begin
							if(!write_done) begin
								write_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								//shift FSM Control to getMeasurementTimingBudget
								timing_start <= 1'b1;
								
								write_start_reg <= write_start_timing;
								write_multi_start_reg <= write_multi_start_timing;
								read_start_reg <= read_start_timing;
								
								timer_start_reg <= timer_start_timing;
								timer_param_reg <= timer_param_timing;
								timer_reset_reg <= timer_reset_timing;
								
								reg_address_out_reg <= reg_address_out_timing;
								data_out_reg <= data_out_timing;
								n_bytes_reg <= n_bytes_timing;
								
								fnc_sel_reg <= fnc_sel_timing;
								
								fifo_data_out_reg <= fifo_data_out_timing;
								fifo_wr_en_reg <= fifo_wr_en_timing;
								fifo_ext_reset_reg <= fifo_ext_reset_timing;
								fifo_read_en_reg <= fifo_read_en_timing;
								
								mem_addr_reg <= mem_addr_timing;
								mem_data_out_reg <= mem_data_out_timing;
								mem_start_reg <= mem_start_timing;
								mem_rw_reg <= mem_rw_timing;
								
								init_error_reg <= timing_error;
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_STATIC_INIT;
						end
						5'b11100: begin
							if(!timing_done) begin
								//keep FSM Control under getMeasurementTimingBudget until done
								timing_start <= 1'b0;
								
								write_start_reg <= write_start_timing;
								write_multi_start_reg <= write_multi_start_timing;
								read_start_reg <= read_start_timing;
								
								timer_start_reg <= timer_start_timing;
								timer_param_reg <= timer_param_timing;
								timer_reset_reg <= timer_reset_timing;
								
								reg_address_out_reg <= reg_address_out_timing;
								data_out_reg <= data_out_timing;
								n_bytes_reg <= n_bytes_timing;
								
								fnc_sel_reg <= fnc_sel_timing;
								
								fifo_data_out_reg <= fifo_data_out_timing;
								fifo_wr_en_reg <= fifo_wr_en_timing;
								fifo_ext_reset_reg <= fifo_ext_reset_timing;
								fifo_read_en_reg <= fifo_read_en_timing;
								
								mem_addr_reg <= mem_addr_timing;
								mem_data_out_reg <= mem_data_out_timing;
								mem_start_reg <= mem_start_timing;
								mem_rw_reg <= mem_rw_timing;
								
								init_error_reg <= timing_error;
								
								instruction_count <= instruction_count;
								state <= S_STATIC_INIT;
							end
							else begin
								state <= S_STATIC_INIT;
								
								write_start_reg <= 1'b1;
								fnc_sel_reg <= 2'b10; //write
								reg_address_out_reg <= 8'h00;
								data_out_reg <= timing_budget[7:0];
								
								instruction_count <= instruction_count + 1;
							end
						end
						5'b11101: begin
							if(!write_done) begin
								instruction_count <= instruction_count;
								write_start_reg <= 1'b0;
							end
							else begin
								write_start_reg <= 1'b1;
								fnc_sel_reg <= 2'b10; //write
								reg_address_out_reg <= 8'h00;
								data_out_reg <= timing_budget[15:8];
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_STATIC_INIT;
						end
						5'b11110: begin
							if(!write_done) begin
								instruction_count <= instruction_count;
								write_start_reg <= 1'b0;
							end
							else begin
								write_start_reg <= 1'b1;
								fnc_sel_reg <= 2'b10; //write
								reg_address_out_reg <= 8'h00;
								data_out_reg <= timing_budget[23:16];
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_STATIC_INIT;
						end
						5'b11111: begin
							if(!write_done) begin
								instruction_count <= instruction_count;
								write_start_reg <= 1'b0;
								state <= S_STATIC_INIT;
							end
							else begin
								write_start_reg <= 1'b1;
								fnc_sel_reg <= 2'b10; //write
								reg_address_out_reg <= 8'h00;
								data_out_reg <= timing_budget[31:24];
								
								instruction_count <= instruction_count + 1;
								state <= S_RESET;
							end
							//state <= S_STATIC_INIT;
						end
						default: state <= S_RESET;
					endcase
				end
				S_PERFORM_REF_CALIBRATION: begin
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
	
	assign init_error = init_error_reg;
	assign instruction_count_debug = instruction_count;
	assign instruction_count_timeout_debug = instruction_count_timeout;
	assign timing_start_out = timing_start;

endmodule
