`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:52:51 11/29/2017 
// Design Name: 
// Module Name:    get_measurement_timing_budget 
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
module getMeasurementTimingBudget (
    //FSM start and done
	 input clk,
	 input reset,
	 input start,
    output done,
    output [31:0] timing_budget,
	 
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
	 output timing_budget_error,
	 
	 //debug
	 output [5:0] instruction_count_debug,
	 output [31:0] timeout_period_us
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
	// Multi-byte memory locations are stacked LSB, then MSB in order of increasing
	// addresses
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
	parameter SEQUENCE_STEP_TIMEOUTS_PRE_RANGE_US = 8'h22; //32-bIt
	parameter SEQUENCE_STEP_TIMEOUTS_FINAL_RANGE_US = 8'h26; //32 bit
	parameter MEASUREMENT_TIMING_BUDGET = 8'h30; //32-bit
	
	//define data_types
	parameter VcselPeriodPreRange = 8'h00;
	parameter VcselPeriodFinalRange = 8'h01;
	
	
	/////////////////////////////////////////////////////////////////////////////////
	// Program Constants
	/////////////////////////////////////////////////////////////////////////////////
	parameter StartOverhead      = 32'd1910; 
   parameter EndOverhead        = 32'd960;
   parameter MsrcOverhead       = 32'd660;
   parameter TccOverhead        = 32'd590;
   parameter DssOverhead        = 32'd690;
   parameter PreRangeOverhead   = 32'd660;
	parameter FinalRangeOverhead = 32'd550;
	
	/////////////////////////////////////////////////////////////////////////////////
	// Some temporary registers
	/////////////////////////////////////////////////////////////////////////////////
	reg [7:0] tmp0_8, tmp1_8, tmp2_8, tmp3_8;
	reg [15:0] tmp0_16, tmp1_16, tmp2_16, tmp3_16;
	reg [31:0] tmp0_32, tmp1_32, tmp2_32, tmp3_32;
	 
	//define state parameters
	parameter S_RESET = 2'b00;
	parameter S_GET_ENABLES = 2'b01;
	parameter S_GET_TIMEOUTS = 2'b10;
	parameter S_DONE = 2'b11;
	
	//define state register and counters
	reg [1:0] state = 2'b00;
	reg [5:0] instruction_count = 6'b000000;
	
	//define output registers
	reg done_reg = 1'b0;
	reg [31:0] timing_budget_reg = 32'b0;
	
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
	
	reg timing_budget_error_reg = 1'b0;
	
	////////////////////////////////////////////////////////////////////////////
	// Sub-FSM getVcselPulsePeriod
	////////////////////////////////////////////////////////////////////////////
	reg pulse_start = 1'b0;
	wire pulse_done;
	
	wire write_start_pulse;
	wire write_multi_start_pulse;
	wire read_start_pulse;
	
	reg [7:0] vcsel_period_type = 8'h00;
	wire [7:0] vcsel_pulse_period;
	
	wire timer_start_pulse;
	wire [3:0] timer_param_pulse;
	wire timer_reset_pulse;
	
	wire [7:0] reg_address_out_pulse;
	wire [7:0] data_out_pulse;
	wire [3:0] n_bytes_pulse;
	
	wire [1:0] fnc_sel_pulse;
	
	wire [7:0] fifo_data_out_pulse;
	wire fifo_wr_en_pulse;
	wire fifo_ext_reset_pulse;
	wire fifo_read_en_pulse;
	
	wire [7:0] mem_addr_pulse;
	wire [7:0] mem_data_out_pulse;
	wire mem_start_pulse;
	wire mem_rw_pulse;
	
	wire pulse_error;
	
	getVcselPulsePeriod getVcselPulsePeriod(
		.reset(reset),
		.clk(clk),
		.start(pulse_start),
		.done(pulse_done),
		
		.vcsel_period_type(vcsel_period_type),
		.vcsel_pulse_period(vcsel_pulse_period),
		
		.write_start(write_start_pulse),
		.write_done(write_done),
		.write_multi_start(write_multi_start_pulse),
		.write_multi_done(write_multi_done),
		.read_start(read_start_pulse),
		.read_done(read_done),
		
		.timer_exp(timer_exp),
		.timer_start(timer_start_pulse),
		.timer_param(timer_param_pulse),
		.timer_reset(timer_reset_pulse),
		
		.reg_address_out(reg_address_out_pulse),
		.data_out(data_out_pulse),
		.n_bytes(n_bytes_pulse),
		
		.fnc_sel(fnc_sel_pulse),
		
		.fifo_data_out(fifo_data_out_pulse),
		.fifo_wr_en(fifo_wr_en_pulse),
	   .fifo_ext_reset(fifo_ext_reset_pulse),
	   .fifo_full(fifo_full),
	   .fifo_write_ack(fifo_write_ack),
	   .fifo_overflow(fifo_overflow),
		
		.fifo_data_in(fifo_data_in),
	   .fifo_read_en(fifo_read_en_pulse),
	   .fifo_empty(fifo_empty),
	   .fifo_read_valid(fifo_read_valid),
	   .fifo_underflow(fifo_underflow),
		
		.mem_addr(mem_addr_pulse),
	   .mem_data_out(mem_data_out_pulse),
	   .mem_data_in(mem_data_in),
	   .mem_start(mem_start_pulse),
		.mem_done(mem_done),
		.mem_rw(mem_rw_pulse),
		
		.error(pulse_error)
	);
	
	////////////////////////////////////////////////////////////////////////////
	// Sub-FSM timeoutMclksToMicroseconds
	////////////////////////////////////////////////////////////////////////////
	reg timeout_convert_start = 1'b0;
	wire timeout_convert_done;
	reg [15:0] timeout_period_mclks= 16'h0000;
	reg [7:0] vcsel_period_pclks = 8'h00;
	//wire [31:0] timeout_period_us;
	
	timeoutMclksToMicroseconds timeoutMclksToMicroseconds(
		.clk(clk),
		.reset(reset),
		.start(timeout_convert_start),
		.done(timeout_convert_done),
		
		.timeout_period_mclks(timeout_period_mclks),
		.vcsel_period_pclks(vcsel_period_pclks),
		.timeout_period_us(timeout_period_us)
	);
	
	//main FSM implementation
	always @(posedge clk) begin
		if(reset) state <= S_RESET;
		else begin
			case(state)
				S_RESET: begin
					if(start) state <= S_GET_ENABLES;
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
					
					timing_budget_error_reg <= 1'b0;
					
					tmp0_8 <= 8'h00;
					tmp1_8 <= 8'h00;
					tmp2_8 <= 8'h00;
					tmp3_8 <= 8'h00;
					
					tmp0_16 <= 16'h0000;
					tmp1_16 <= 16'h0000;
					tmp2_16 <= 16'h0000;
					tmp3_16 <= 16'h0000;
					
					tmp0_32 <= 32'h00000000;
					tmp1_32 <= 32'h00000000;
					tmp2_32 <= 32'h00000000;
					tmp3_32 <= 32'h00000000;
					
					pulse_start <= 1'b0;
					vcsel_period_type <= 8'h00;
					
					timeout_convert_start <= 1'b0;
					timeout_period_mclks <= 16'h0000;
					vcsel_period_pclks <= 8'h00;
					
					instruction_count <= 6'b000000;
				end
				S_GET_ENABLES: begin
					//getSequenceStepEnables(&enables);
					case(instruction_count)
						//uint8_t sequence_config = readReg(SYSTEM_SEQUENCE_CONFIG);
						6'b000000: begin
							tmp0_32 <= StartOverhead + EndOverhead;
							instruction_count <= instruction_count + 1;
							state <= S_GET_ENABLES;
						end
						6'b000001: begin
							read_start_reg <= 1'b1;
							fnc_sel_reg <= 2'b01; //sel read
							n_bytes_reg <= 4'b0001;
							reg_address_out_reg <= SYSTEM_SEQUENCE_CONFIG;
								
							instruction_count <= instruction_count + 1;
							state <= S_GET_ENABLES;
						end
						6'b000010: begin
							if(!read_done) begin
								instruction_count <= instruction_count;
								read_start_reg <= 1'b0; 
							end
							else begin
								fifo_read_en_reg <= 1'b1;
								instruction_count <= instruction_count + 1;
							end
							state <= S_GET_ENABLES;
						end
						6'b000011: begin
							if(!fifo_read_valid) begin
								instruction_count <= instruction_count;
								fifo_read_en_reg <= 1'b0;
							end
							else begin
								mem_addr_reg <= SEQUENCE_STEP_ENABLE_TCC;
								mem_data_out_reg <= (fifo_data_in >> 4) & 8'h01;
								mem_rw_reg <= 1'b1;
								mem_start_reg <= 1'b1;
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_GET_ENABLES;
						end
						6'b000100: begin
							if(!mem_done) begin
								instruction_count <= instruction_count;
								mem_start_reg <= 1'b0;
							end
							else begin
								mem_addr_reg <= SEQUENCE_STEP_ENABLE_DSS;
								mem_data_out_reg <= (fifo_data_in >> 3) & 8'h01;
								mem_rw_reg <= 1'b1;
								mem_start_reg <= 1'b1;
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_GET_ENABLES;
						end
						6'b000101: begin
							if(!mem_done) begin
								instruction_count <= instruction_count;
								mem_start_reg <= 1'b0;
							end
							else begin
								mem_addr_reg <= SEQUENCE_STEP_ENABLE_MSRC;
								mem_data_out_reg <= (fifo_data_in >> 2) & 8'h01;
								mem_rw_reg <= 1'b1;
								mem_start_reg <= 1'b1;
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_GET_ENABLES;
						end
						6'b000110: begin
							if(!mem_done) begin
								instruction_count <= instruction_count;
								mem_start_reg <= 1'b0;
							end
							else begin
								mem_addr_reg <= SEQUENCE_STEP_ENABLE_PRE_RANGE;
								mem_data_out_reg <= (fifo_data_in >> 6) & 8'h01;
								mem_rw_reg <= 1'b1;
								mem_start_reg <= 1'b1;
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_GET_ENABLES;
						end
						6'b000111: begin
							if(!mem_done) begin
								instruction_count <= instruction_count;
								mem_start_reg <= 1'b0;
							end
							else begin
								mem_addr_reg <= SEQUENCE_STEP_ENABLE_FINAL_RANGE;
								mem_data_out_reg <= (fifo_data_in >> 7) & 8'h01;
								mem_rw_reg <= 1'b1;
								mem_start_reg <= 1'b1;
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_GET_ENABLES;
						end
						6'b001000: begin
							if(!mem_done) begin
								instruction_count <= instruction_count;
								mem_start_reg <= 1'b0;
								state <= S_GET_ENABLES;
							end
							else begin
								instruction_count <= 6'b000000;
								state <= S_GET_TIMEOUTS;
							end
						end
					endcase
				end
				S_GET_TIMEOUTS: begin
					////////////////////////////////////////////////////////////////////////////////////////////////
					// getSequenceStepTimeouts
					////////////////////////////////////////////////////////////////////////////////////////////////
					case(instruction_count)
						////////////////////////////////////////////////////////////////////////////////////////////////
						//timeouts->pre_range_vcsel_period_pclks = getVcselPulsePeriod(VcselPeriodPreRange);
						////////////////////////////////////////////////////////////////////////////////////////////////
						6'b000000: begin
							//shift FSM Control to getVcselPulsePeriod
							pulse_start <= 1'b1;
							vcsel_period_type <= VcselPeriodPreRange;
							
							write_start_reg <= write_start_pulse;
							write_multi_start_reg <= write_multi_start_pulse;
							read_start_reg <= read_start_pulse;
							
							timer_start_reg <= timer_start_pulse;
							timer_param_reg <= timer_param_pulse;
							timer_reset_reg <= timer_reset_pulse;
							
							reg_address_out_reg <= reg_address_out_pulse;
							data_out_reg <= data_out_pulse;
							n_bytes_reg <= n_bytes_pulse;
							
							fnc_sel_reg <= fnc_sel_pulse;
							
							fifo_data_out_reg <= fifo_data_out_pulse;
							fifo_wr_en_reg <= fifo_wr_en_pulse;
							fifo_ext_reset_reg <= fifo_ext_reset_pulse;
							fifo_read_en_reg <= fifo_read_en_pulse;
							
							mem_addr_reg <= mem_addr_pulse;
							mem_data_out_reg <= mem_data_out_pulse;
							mem_start_reg <= mem_start_pulse;
							mem_rw_reg <= mem_rw_pulse;
							
							timing_budget_error_reg <= pulse_error;
							
							instruction_count <= instruction_count + 1;
							state <= S_GET_TIMEOUTS;
						end
						6'b000001: begin
							//only relinquish control back to normals FSM until VcselPulsePeriod is finished
							if(!pulse_done) begin
								pulse_start <= 1'b0;
								vcsel_period_type <= VcselPeriodPreRange;
							
								write_start_reg <= write_start_pulse;
								write_multi_start_reg <= write_multi_start_pulse;
								read_start_reg <= read_start_pulse;
								
								timer_start_reg <= timer_start_pulse;
								timer_param_reg <= timer_param_pulse;
								timer_reset_reg <= timer_reset_pulse;
								
								reg_address_out_reg <= reg_address_out_pulse;
								data_out_reg <= data_out_pulse;
								n_bytes_reg <= n_bytes_pulse;
								
								fnc_sel_reg <= fnc_sel_pulse;
								
								fifo_data_out_reg <= fifo_data_out_pulse;
								fifo_wr_en_reg <= fifo_wr_en_pulse;
								fifo_ext_reset_reg <= fifo_ext_reset_pulse;
								fifo_read_en_reg <= fifo_read_en_pulse;
								
								mem_addr_reg <= mem_addr_pulse;
								mem_data_out_reg <= mem_data_out_pulse;
								mem_start_reg <= mem_start_pulse;
								mem_rw_reg <= mem_rw_pulse;
								
								timing_budget_error_reg <= pulse_error;
								
								instruction_count <= instruction_count;
							end
							else begin
								instruction_count <= instruction_count + 1;
							end
							state <= S_GET_TIMEOUTS;
						end
						6'b000010: begin
							mem_addr_reg <= SEQUENCE_STEP_TIMEOUTS_PRE_RANGE_VPP;
							mem_data_out_reg <= vcsel_pulse_period;
							mem_rw_reg <= 1'b1;
							mem_start_reg <= 1'b1;
								
							instruction_count <= instruction_count + 1;
							state <= S_GET_TIMEOUTS;
						end
						6'b000011: begin
							if(!mem_done) begin
								mem_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								mem_addr_reg <= SEQUENCE_STEP_TIMEOUTS_PRE_RANGE_VPP + 1;
								mem_data_out_reg <= 8'h00;
								mem_rw_reg <= 1'b1;
								mem_start_reg <= 1'b1;
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_GET_TIMEOUTS;
						end
						////////////////////////////////////////////////////////////////////////////////////////////////
						//timeouts->msrc_dss_tcc_mclks = readReg(MSRC_CONFIG_TIMEOUT_MACROP) + 1;
						////////////////////////////////////////////////////////////////////////////////////////////////
						6'b000100: begin
							if(!mem_done) begin
								mem_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								read_start_reg <= 1'b1;
								fnc_sel_reg <= 2'b01; //sel read
								n_bytes_reg <= 4'b0001;
								reg_address_out_reg <= MSRC_CONFIG_TIMEOUT_MACROP;
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_GET_TIMEOUTS;
						end
						6'b000101: begin
							if(!read_done) begin
								instruction_count <= instruction_count;
								read_start_reg <= 1'b0;
							end
							else begin
								fifo_read_en_reg <= 1'b1;
								instruction_count <= instruction_count + 1;
							end
							state <= S_GET_TIMEOUTS;
						end
						6'b000110: begin
							if(!fifo_read_valid) begin
								instruction_count <= instruction_count;
								fifo_read_en_reg <= 1'b0;
							end
							else begin
								tmp0_16 <= fifo_data_in + 1;
								instruction_count <= instruction_count + 1;
							end
							state <= S_GET_TIMEOUTS;
						end
						6'b000111: begin
							mem_addr_reg <= SEQUENCE_STEP_TIMEOUTS_MSRC_DTM;
							mem_data_out_reg <= tmp0_16[7:0];
							mem_rw_reg <= 1'b1;
							mem_start_reg <= 1'b1;
								
							instruction_count <= instruction_count + 1;
							state <= S_GET_TIMEOUTS;
						end
						6'b001000: begin
							if(!mem_done) begin
								mem_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								mem_addr_reg <= SEQUENCE_STEP_TIMEOUTS_MSRC_DTM + 1;
								mem_data_out_reg <= tmp0_16[15:8];
								mem_rw_reg <= 1'b1;
								mem_start_reg <= 1'b1;
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_GET_TIMEOUTS;
						end
						/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
						//timeouts->msrc_dss_tcc_us = timeoutMclksToMicroseconds(timeouts->msrc_dss_tcc_mclks, timeouts->pre_range_vcsel_period_pclks);
						/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
						6'b001001: begin
							if(!mem_done) begin
								mem_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								timeout_convert_start <= 1'b1;
								timeout_period_mclks <= tmp0_16; //mrsc_dtm
								vcsel_period_pclks <= vcsel_pulse_period;
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_GET_TIMEOUTS;
						end
						6'b001010: begin
							if(!timeout_convert_done) begin
								instruction_count <= instruction_count;
								timeout_convert_start <= 1'b0;
							end
							else begin
								mem_addr_reg <= SEQUENCE_STEP_TIMEOUTS_MSRC_DTU;
								mem_data_out_reg <= timeout_period_us[7:0];
								mem_rw_reg <= 1'b1;
								mem_start_reg <= 1'b1;

								instruction_count <= instruction_count + 1;
							end
							state <= S_GET_TIMEOUTS;
						end
						6'b001011: begin
							if(!mem_done) begin
								mem_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								mem_addr_reg <= SEQUENCE_STEP_TIMEOUTS_MSRC_DTU + 1;
								mem_data_out_reg <= timeout_period_us[15:8];
								mem_rw_reg <= 1'b1;
								mem_start_reg <= 1'b1;
							
								instruction_count <= instruction_count + 1;
							end
							state <= S_GET_TIMEOUTS;
						end
						6'b001100: begin
							if(!mem_done) begin
								mem_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								mem_addr_reg <= SEQUENCE_STEP_TIMEOUTS_MSRC_DTU + 2;
								mem_data_out_reg <= timeout_period_us[23:16];
								mem_rw_reg <= 1'b1;
								mem_start_reg <= 1'b1;
							
								instruction_count <= instruction_count + 1;
							end
							state <= S_GET_TIMEOUTS;
						end
						6'b001101: begin
							if(!mem_done) begin
								mem_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								mem_addr_reg <= SEQUENCE_STEP_TIMEOUTS_MSRC_DTU + 3;
								mem_data_out_reg <= timeout_period_us[31:24];
								mem_rw_reg <= 1'b1;
								mem_start_reg <= 1'b1;
							
								instruction_count <= instruction_count + 1;
							end
							state <= S_GET_TIMEOUTS;
						end
						////////////////////////////////////////////////////////////////////////////////////////////////
						//timeouts->pre_range_mclks = decodeTimeout(readReg16Bit(PRE_RANGE_CONFIG_TIMEOUT_MACROP_HI));
						////////////////////////////////////////////////////////////////////////////////////////////////
						6'b001110: begin
							if(!mem_done) begin
								mem_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin 
								read_start_reg <= 1'b1;
								fnc_sel_reg <= 2'b01; //sel read
								n_bytes_reg <= 4'b0010;
								reg_address_out_reg <= PRE_RANGE_CONFIG_TIMEOUT_MACROP_HI;
									
								instruction_count <= instruction_count + 1;
							end
							state <= S_GET_TIMEOUTS;
						end
						6'b001111: begin
							//Read MSB of byte
							if(!read_done) begin
								instruction_count <= instruction_count;
								read_start_reg <= 1'b0;
							end
							else begin
								fifo_read_en_reg <= 1'b1;
								instruction_count <= instruction_count + 1;
							end
							state <= S_GET_TIMEOUTS;
						end
						6'b010000: begin
							if(!fifo_read_valid) begin
								instruction_count <= instruction_count;
								fifo_read_en_reg <= 1'b0;
							end
							else begin
								tmp0_8 <= fifo_data_in;
								instruction_count <= instruction_count + 1;
							end
							state <= S_GET_TIMEOUTS;
						end
						6'b010001: begin
							//Read LSB of byte
							fifo_read_en_reg <= 1'b1;
							instruction_count <= instruction_count + 1;
							state <= S_GET_TIMEOUTS;
						end
						6'b010010: begin
							if(!fifo_read_valid) begin
								instruction_count <= instruction_count;
								fifo_read_en_reg <= 1'b0;
							end
							else begin
								tmp1_8 <= fifo_data_in;
								instruction_count <= instruction_count + 1;
							end
							state <= S_GET_TIMEOUTS;
						end
						6'b010011: begin
							tmp0_16 <= tmp1_8 * (1 << tmp0_8) + 1; //LS_BYTE * 2^(MS_BYTE) + 1 - I2C sends msb then lsb
							instruction_count <= instruction_count + 1;
							state <= S_GET_TIMEOUTS;
						end
						6'b010100: begin
							mem_addr_reg <= SEQUENCE_STEP_TIMEOUTS_PRE_RANGE_MCLKS;
							mem_data_out_reg <= tmp0_16[7:0]; //lsb
							mem_rw_reg <= 1'b1;
							mem_start_reg <= 1'b1;
							
							instruction_count <= instruction_count + 1;
							state <= S_GET_TIMEOUTS;
						end
						6'b010101: begin
							if(!mem_done) begin
								mem_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								mem_addr_reg <= SEQUENCE_STEP_TIMEOUTS_PRE_RANGE_MCLKS + 1;
								mem_data_out_reg <= tmp0_16[15:8]; //msb
								mem_rw_reg <= 1'b1;
								mem_start_reg <= 1'b1;
							
								instruction_count <= instruction_count + 1;
							end
							state <= S_GET_TIMEOUTS;
						end
						///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
						//timeouts->pre_range_us = timeoutMclksToMicroseconds(timeouts->pre_range_mclks, timeouts->pre_range_vcsel_period_pclks);
						///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
						6'b010110: begin
							if(!mem_done) begin
								mem_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								timeout_convert_start <= 1'b1;
								timeout_period_mclks <= {tmp0_8, tmp1_8}; //pre_range_mclks
								vcsel_period_pclks <= vcsel_pulse_period; //same period from before 
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_GET_TIMEOUTS;
						end
						6'b010111: begin
							if(!timeout_convert_done) begin
								timeout_convert_start <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								mem_addr_reg <= SEQUENCE_STEP_TIMEOUTS_PRE_RANGE_US;
								mem_data_out_reg <= timeout_period_us[7:0];
								mem_rw_reg <= 1'b1;
								mem_start_reg <= 1'b1;
								
								instruction_count <= instruction_count + 1;
								state <= S_GET_TIMEOUTS;
							end
						end
						6'b011000: begin
							if(!mem_done) begin
								mem_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								mem_addr_reg <= SEQUENCE_STEP_TIMEOUTS_PRE_RANGE_US + 1;
								mem_data_out_reg <= timeout_period_us[15:8];
								mem_rw_reg <= 1'b1;
								mem_start_reg <= 1'b1;
							
								instruction_count <= instruction_count + 1;
							end
							state <= S_GET_TIMEOUTS;
						end
						6'b011001: begin
							if(!mem_done) begin
								mem_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								mem_addr_reg <= SEQUENCE_STEP_TIMEOUTS_PRE_RANGE_US + 2;
								mem_data_out_reg <= timeout_period_us[23:16];
								mem_rw_reg <= 1'b1;
								mem_start_reg <= 1'b1;
							
								instruction_count <= instruction_count + 1;
							end
							state <= S_GET_TIMEOUTS;
						end
						6'b011010: begin
							if(!mem_done) begin
								mem_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								mem_addr_reg <= SEQUENCE_STEP_TIMEOUTS_PRE_RANGE_US + 3;
								mem_data_out_reg <= timeout_period_us[31:24];
								mem_rw_reg <= 1'b1;
								mem_start_reg <= 1'b1;
							
								instruction_count <= instruction_count + 1;
							end
							state <= S_GET_TIMEOUTS;
						end
						////////////////////////////////////////////////////////////////////////////////////////////
						// timeouts->final_range_vcsel_period_pclks = getVcselPulsePeriod(VcselPeriodFinalRange);
						////////////////////////////////////////////////////////////////////////////////////////////
						6'b011011: begin
							if(!mem_done) begin
								mem_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								//shift FSM Control to getVcselPulsePeriod
								pulse_start <= 1'b1;
								vcsel_period_type <= VcselPeriodFinalRange;
								
								write_start_reg <= write_start_pulse;
								write_multi_start_reg <= write_multi_start_pulse;
								read_start_reg <= read_start_pulse;
								
								timer_start_reg <= timer_start_pulse;
								timer_param_reg <= timer_param_pulse;
								timer_reset_reg <= timer_reset_pulse;
								
								reg_address_out_reg <= reg_address_out_pulse;
								data_out_reg <= data_out_pulse;
								n_bytes_reg <= n_bytes_pulse;
								
								fnc_sel_reg <= fnc_sel_pulse;
								
								fifo_data_out_reg <= fifo_data_out_pulse;
								fifo_wr_en_reg <= fifo_wr_en_pulse;
								fifo_ext_reset_reg <= fifo_ext_reset_pulse;
								fifo_read_en_reg <= fifo_read_en_pulse;
								
								mem_addr_reg <= mem_addr_pulse;
								mem_data_out_reg <= mem_data_out_pulse;
								mem_start_reg <= mem_start_pulse;
								mem_rw_reg <= mem_rw_pulse;
								
								timing_budget_error_reg <= pulse_error;
								
								instruction_count <= instruction_count + 1;
								state <= S_GET_TIMEOUTS;
							end
						end
						6'b011100: begin
							//only relinquish control back to normals FSM until VcselPulsePeriod is finished
							if(!pulse_done) begin
								pulse_start <= 1'b0;
								vcsel_period_type <= VcselPeriodFinalRange;
							
								write_start_reg <= write_start_pulse;
								write_multi_start_reg <= write_multi_start_pulse;
								read_start_reg <= read_start_pulse;
								
								timer_start_reg <= timer_start_pulse;
								timer_param_reg <= timer_param_pulse;
								timer_reset_reg <= timer_reset_pulse;
								
								reg_address_out_reg <= reg_address_out_pulse;
								data_out_reg <= data_out_pulse;
								n_bytes_reg <= n_bytes_pulse;
								
								fnc_sel_reg <= fnc_sel_pulse;
								
								fifo_data_out_reg <= fifo_data_out_pulse;
								fifo_wr_en_reg <= fifo_wr_en_pulse;
								fifo_ext_reset_reg <= fifo_ext_reset_pulse;
								fifo_read_en_reg <= fifo_read_en_pulse;
								
								mem_addr_reg <= mem_addr_pulse;
								mem_data_out_reg <= mem_data_out_pulse;
								mem_start_reg <= mem_start_pulse;
								mem_rw_reg <= mem_rw_pulse;
								
								timing_budget_error_reg <= pulse_error;
								
								instruction_count <= instruction_count;
							end
							else begin
								instruction_count <= instruction_count + 1;
							end
							state <= S_GET_TIMEOUTS;
						end
						6'b011101: begin
							mem_addr_reg <= SEQUENCE_STEP_TIMEOUTS_FINAL_RANGE_VPP;
							mem_data_out_reg <= vcsel_pulse_period;
							mem_rw_reg <= 1'b1;
							mem_start_reg <= 1'b1;
								
							instruction_count <= instruction_count + 1;
							state <= S_GET_TIMEOUTS;
						end
						6'b011110: begin
							if(!mem_done) begin
								mem_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								mem_addr_reg <= SEQUENCE_STEP_TIMEOUTS_FINAL_RANGE_VPP + 1;
								mem_data_out_reg <= 8'h00;
								mem_rw_reg <= 1'b1;
								mem_start_reg <= 1'b1;
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_GET_TIMEOUTS;
						end
						/////////////////////////////////////////////////////////////////////////////////////////////////////
						//timeouts->final_range_mclks = decodeTimeout(readReg16Bit(FINAL_RANGE_CONFIG_TIMEOUT_MACROP_HI));
						/////////////////////////////////////////////////////////////////////////////////////////////////////
						6'b011111: begin
							if(!mem_done) begin
								mem_start_reg <= instruction_count;
							end
							else begin
								read_start_reg <= 1'b1;
								fnc_sel_reg <= 2'b01; //sel read
								n_bytes_reg <= 4'b0010;
								reg_address_out_reg <= FINAL_RANGE_CONFIG_TIMEOUT_MACROP_HI;
									
								instruction_count <= instruction_count + 1;
							end
							state <= S_GET_TIMEOUTS;
						end
						6'b100000: begin
							//Read MSB of byte
							if(!read_done) begin
								instruction_count <= instruction_count;
								read_start_reg <= 1'b0;
							end
							else begin
								fifo_read_en_reg <= 1'b1;
								instruction_count <= instruction_count + 1;
							end
							state <= S_GET_TIMEOUTS;
						end
						6'b100001: begin
							if(!fifo_read_valid) begin
								instruction_count <= instruction_count;
								fifo_read_en_reg <= 1'b0;
							end
							else begin
								tmp0_8 <= fifo_data_in;
								instruction_count <= instruction_count + 1;
							end
							state <= S_GET_TIMEOUTS;
						end
						6'b100010: begin
							//Read LSB of byte
							fifo_read_en_reg <= 1'b1;
							instruction_count <= instruction_count + 1;
							state <= S_GET_TIMEOUTS;
						end
						6'b100011: begin
							if(!fifo_read_valid) begin
								instruction_count <= instruction_count;
								fifo_read_en_reg <= 1'b0;
							end
							else begin
								tmp1_8 <= fifo_data_in;
								instruction_count <= instruction_count + 1;
							end
							state <= S_GET_TIMEOUTS;
						end
						6'b100100: begin
							tmp0_16 <= tmp1_8 * (1 << tmp0_8) + 1; //LS_BYTE * 2^(MS_BYTE) + 1 - I2C sends msb then lsb
							instruction_count <= instruction_count + 1;
							state <= S_GET_TIMEOUTS;
						end
						6'b100101: begin
							mem_addr_reg <= SEQUENCE_STEP_TIMEOUTS_FINAL_RANGE_MCLKS;
							mem_data_out_reg <= tmp0_16[7:0]; //lsb
							mem_rw_reg <= 1'b1;
							mem_start_reg <= 1'b1;
							
							instruction_count <= instruction_count + 1;
							state <= S_GET_TIMEOUTS;
						end
						6'b100110: begin
							if(!mem_done) begin
								mem_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								mem_addr_reg <= SEQUENCE_STEP_TIMEOUTS_FINAL_RANGE_MCLKS + 1;
								mem_data_out_reg <= tmp0_16[15:8]; //msb
								mem_rw_reg <= 1'b1;
								mem_start_reg <= 1'b1;
							
								instruction_count <= instruction_count + 1;
							end
							state <= S_GET_TIMEOUTS;
						end
						/*
						 if (enables->pre_range)
  						 {
    						timeouts->final_range_mclks -= timeouts->pre_range_mclks;
  						 }
						*/
						6'b100111: begin
							if(!mem_done) begin
								mem_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin 
								mem_addr_reg <= SEQUENCE_STEP_ENABLE_PRE_RANGE;
								mem_rw_reg <= 1'b0;
								mem_start_reg <= 1'b1;

								instruction_count <= instruction_count + 1;
							end
							state <= S_GET_TIMEOUTS;
						end
						6'b101000: begin
							if(!mem_done) begin
								mem_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin 
								tmp0_8 <= mem_data_in; //enables->pre_range
								mem_addr_reg <= SEQUENCE_STEP_TIMEOUTS_FINAL_RANGE_MCLKS;
								mem_rw_reg <= 1'b0;
								mem_start_reg <= 1'b1;

								instruction_count <= instruction_count + 1;
							end
							state <= S_GET_TIMEOUTS;
						end
						6'b101001: begin
							if(!mem_done) begin
								mem_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								tmp0_16 <= {8'h00, mem_data_in} & 16'h00FF; //set LSB of FINAL_RANGE_MCLKS
								mem_addr_reg <= SEQUENCE_STEP_TIMEOUTS_FINAL_RANGE_MCLKS + 1;
								mem_rw_reg <= 1'b0;
								mem_start_reg <= 1'b1;

								instruction_count <= instruction_count + 1;
							end
							state <= S_GET_TIMEOUTS;
						end
						6'b101010: begin
							if(!mem_done) begin
								mem_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								tmp0_16 <= tmp0_16 + ({mem_data_in, 8'h00} & 16'hFF00); //set MSB of FINAL_RANGE_MCLKS
								mem_addr_reg <= SEQUENCE_STEP_TIMEOUTS_PRE_RANGE_MCLKS;
								mem_rw_reg <= 1'b0;
								mem_start_reg <= 1'b1;

								instruction_count <= instruction_count + 1;
							end
							state <= S_GET_TIMEOUTS;
						end
						6'b101011: begin
							if(!mem_done) begin
								mem_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								tmp1_16 <= {8'h00, mem_data_in} & 16'h00FF;//set LSB of PRE_RANGE_MCLKS
								mem_addr_reg <= SEQUENCE_STEP_TIMEOUTS_PRE_RANGE_MCLKS + 1;
								mem_rw_reg <= 1'b0;
								mem_start_reg <= 1'b1;

								instruction_count <= instruction_count + 1;
							end
							state <= S_GET_TIMEOUTS;
						end
						6'b101100: begin
							if(!mem_done) begin
								mem_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								tmp1_16 <= tmp1_16 + ({mem_data_in, 8'h00} & 16'hFF00); //set MSB of PRE_RANGE_MCLKS
								instruction_count <= instruction_count + 1;
							end
							state <= S_GET_TIMEOUTS;
						end
						6'b101101: begin
							if(tmp0_8[0]) begin //if enables->pre_range
								tmp0_16 <= tmp0_16 - tmp1_16;
							end
							instruction_count <= instruction_count + 1;
							state <= S_GET_TIMEOUTS;
						end
						6'b101110: begin
							mem_addr_reg <= SEQUENCE_STEP_TIMEOUTS_FINAL_RANGE_MCLKS;
							mem_data_out_reg <= tmp0_16[7:0]; //lsb
							mem_rw_reg <= 1'b1;
							mem_start_reg <= 1'b1;

							instruction_count <= instruction_count + 1;
							state <= S_GET_TIMEOUTS;
						end
						6'b101111: begin
							if(!mem_done) begin
								mem_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								mem_addr_reg <= SEQUENCE_STEP_TIMEOUTS_FINAL_RANGE_MCLKS + 1;
								mem_data_out_reg <= tmp0_16[15:8]; //msb
								mem_rw_reg <= 1'b1;
								mem_start_reg <= 1'b1;

								instruction_count <= instruction_count + 1;
							end
							state <= S_GET_TIMEOUTS;
						end
						////////////////////////////////////////////////////////////////////////////////////////////////
						// timeouts->final_range_us = timeoutMclksToMicroseconds(timeouts->final_range_mclks, timeouts->final_range_vcsel_period_pclks);
						////////////////////////////////////////////////////////////////////////////////////////////////
						6'b110000: begin
							if(!mem_done) begin
								mem_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								timeout_convert_start <= 1'b1;
								timeout_period_mclks <= tmp0_16; //final_range_mclks
								vcsel_period_pclks <= vcsel_pulse_period; //same period from before 
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_GET_TIMEOUTS;
						end
						6'b110001: begin
							if(!timeout_convert_done) begin
								timeout_convert_start <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								mem_addr_reg <= SEQUENCE_STEP_TIMEOUTS_FINAL_RANGE_US;
								mem_data_out_reg <= timeout_period_us[7:0];
								mem_rw_reg <= 1'b1;
								mem_start_reg <= 1'b1;
								
								instruction_count <= instruction_count + 1;
								state <= S_GET_TIMEOUTS;
							end
						end
						6'b110010: begin
							if(!mem_done) begin
								mem_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								mem_addr_reg <= SEQUENCE_STEP_TIMEOUTS_FINAL_RANGE_US + 1;
								mem_data_out_reg <= timeout_period_us[15:8];
								mem_rw_reg <= 1'b1;
								mem_start_reg <= 1'b1;
							
								instruction_count <= instruction_count + 1;
							end
							state <= S_GET_TIMEOUTS;
						end
						6'b110011: begin
							if(!mem_done) begin
								mem_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								mem_addr_reg <= SEQUENCE_STEP_TIMEOUTS_FINAL_RANGE_US + 2;
								mem_data_out_reg <= timeout_period_us[23:16];
								mem_rw_reg <= 1'b1;
								mem_start_reg <= 1'b1;
							
								instruction_count <= instruction_count + 1;
							end
							state <= S_GET_TIMEOUTS;
						end
						6'b110100: begin
							if(!mem_done) begin
								mem_start_reg <= 1'b0;
								instruction_count <= instruction_count;
								state <= S_GET_TIMEOUTS;
							end
							else begin
								mem_addr_reg <= SEQUENCE_STEP_TIMEOUTS_FINAL_RANGE_US + 3;
								mem_data_out_reg <= timeout_period_us[31:24];
								mem_rw_reg <= 1'b1;
								mem_start_reg <= 1'b1;
							
								instruction_count <= 6'b000000;
								state <= S_DONE;
							end
						end
					endcase
				end
				S_DONE: begin
					/*
					if (enables.tcc)
  					{
    					budget_us += (timeouts.msrc_dss_tcc_us + TccOverhead);
  					}
					*/
					case(instruction_count)
						6'b000000: begin
							if(!mem_done) begin
								mem_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								mem_addr_reg <= SEQUENCE_STEP_ENABLE_TCC;
								mem_rw_reg <= 1'b0;
								mem_start_reg <= 1'b1;

								instruction_count <= instruction_count + 1;
							end
							state <= S_DONE;
						end
						6'b000001: begin
							if(!mem_done) begin
								mem_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								tmp0_8 <= mem_data_in;
								mem_addr_reg <= SEQUENCE_STEP_TIMEOUTS_MSRC_DTU;
								mem_rw_reg <= 1'b0;
								mem_start_reg <= 1'b1;

								instruction_count <= instruction_count + 1;
							end
							state <= S_DONE;
						end
						6'b000010: begin
							if(!mem_done) begin
								mem_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								tmp1_32 <= {8'h00, 8'h00, 8'h00, mem_data_in} & 32'h000000FF; 
								mem_addr_reg <= SEQUENCE_STEP_TIMEOUTS_MSRC_DTU + 1;
								mem_rw_reg <= 1'b0;
								mem_start_reg <= 1'b1;

								instruction_count <= instruction_count + 1;
							end
							state <= S_DONE;
						end
						6'b000011: begin
							if(!mem_done) begin
								mem_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								tmp1_32 <= tmp1_32 + ({8'h00, 8'h00, mem_data_in, 8'h00} & 32'h0000FF00); 
								mem_addr_reg <= SEQUENCE_STEP_TIMEOUTS_MSRC_DTU + 2;
								mem_rw_reg <= 1'b0;
								mem_start_reg <= 1'b1;

								instruction_count <= instruction_count + 1;
							end
							state <= S_DONE;
						end
						6'b000100: begin
							if(!mem_done) begin
								mem_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								tmp1_32 <= tmp1_32 + ({8'h00, mem_data_in, 8'h00, 8'h00} & 32'h00FF0000); 
								mem_addr_reg <= SEQUENCE_STEP_TIMEOUTS_MSRC_DTU + 3;
								mem_rw_reg <= 1'b0;
								mem_start_reg <= 1'b1;

								instruction_count <= instruction_count + 1;
							end
							state <= S_DONE;
						end
						6'b000101: begin
							if(!mem_done) begin
								mem_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								tmp1_32 <= tmp1_32 + ({mem_data_in, 8'h00, 8'h00, 8'h00} & 32'hFF000000); 
								instruction_count <= instruction_count + 1;
							end
							state <= S_DONE;
						end
						6'b000110: begin
							if(tmp0_8[0]) begin
								tmp0_32 <= tmp0_32 + (tmp1_32 + TccOverhead);
							end
							instruction_count <= instruction_count + 1;
							state <= S_DONE;
						end
						/*
						 if (enables.dss)
  						 {
    						budget_us += 2 * (timeouts.msrc_dss_tcc_us + DssOverhead);
  						 }
  						 else if (enables.msrc)
						 {
						    budget_us += (timeouts.msrc_dss_tcc_us + MsrcOverhead);
						 }
						*/
						6'b000111: begin
							mem_addr_reg <= SEQUENCE_STEP_ENABLE_DSS;
							mem_rw_reg <= 1'b0;
							mem_start_reg <= 1'b1;

							instruction_count <= instruction_count + 1;
							state <= S_DONE;
						end
						6'b001000: begin
							if(!mem_done) begin
								mem_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								tmp0_8 <= mem_data_in;
								instruction_count <= instruction_count + 1;
							end
							state <= S_DONE;
						end
						6'b001001: begin
							mem_addr_reg <= SEQUENCE_STEP_ENABLE_MSRC;
							mem_rw_reg <= 1'b0;
							mem_start_reg <= 1'b1;

							instruction_count <= instruction_count + 1;
							state <= S_DONE;
						end
						6'b001010: begin
							if(!mem_done) begin
								mem_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								tmp1_8 <= mem_data_in;
								instruction_count <= instruction_count + 1;
							end
							state <= S_DONE;
						end
						6'b001011: begin
							if(tmp0_8[0]) begin
								tmp0_32 <= tmp0_32 + 2*(tmp1_32 + DssOverhead);
							end
							else if (tmp1_8[0]) begin
								tmp0_32 <= tmp0_32 + (tmp1_32 + MsrcOverhead);
							end
							instruction_count <= instruction_count + 1;
							state <= S_DONE;
						end
						/*
						 if (enables.pre_range)
  						 {
    					  budget_us += (timeouts.pre_range_us + PreRangeOverhead);
  						 }
						*/
						6'b001100: begin
							mem_addr_reg <= SEQUENCE_STEP_ENABLE_PRE_RANGE;
							mem_rw_reg <= 1'b0;
							mem_start_reg <= 1'b1;

							instruction_count <= instruction_count + 1;
							state <= S_DONE;
						end
						6'b001101: begin
							if(!mem_done) begin
								mem_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								tmp0_8 <= mem_data_in;
								mem_addr_reg <= SEQUENCE_STEP_TIMEOUTS_PRE_RANGE_US;
								mem_rw_reg <= 1'b0;
								mem_start_reg <= 1'b1;

								instruction_count <= instruction_count + 1;
							end
							state <= S_DONE;
						end
						6'b001110: begin
							if(!mem_done) begin
								mem_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								tmp1_32 <= {8'h00, 8'h00, 8'h00, mem_data_in} & 32'h000000FF; 
								mem_addr_reg <= SEQUENCE_STEP_TIMEOUTS_PRE_RANGE_US + 1;
								mem_rw_reg <= 1'b0;
								mem_start_reg <= 1'b1;

								instruction_count <= instruction_count + 1;
							end
							state <= S_DONE;
						end
						6'b001111: begin
							if(!mem_done) begin
								mem_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								tmp1_32 <= tmp1_32 + ({8'h00, 8'h00, mem_data_in, 8'h00} & 32'h0000FF00); 
								mem_addr_reg <= SEQUENCE_STEP_TIMEOUTS_PRE_RANGE_US + 2;
								mem_rw_reg <= 1'b0;
								mem_start_reg <= 1'b1;

								instruction_count <= instruction_count + 1;
							end
							state <= S_DONE;
						end
						6'b010000: begin
							if(!mem_done) begin
								mem_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								tmp1_32 <= tmp1_32 + ({8'h00, mem_data_in, 8'h00, 8'h00} & 32'h00FF0000); 
								mem_addr_reg <= SEQUENCE_STEP_TIMEOUTS_PRE_RANGE_US + 3;
								mem_rw_reg <= 1'b0;
								mem_start_reg <= 1'b1;

								instruction_count <= instruction_count + 1;
							end
							state <= S_DONE;
						end
						6'b010001: begin
							if(!mem_done) begin
								mem_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								tmp1_32 <= tmp1_32 + ({mem_data_in, 8'h00, 8'h00, 8'h00} & 32'hFF000000); 
								instruction_count <= instruction_count + 1;
							end
							state <= S_DONE;
						end
						6'b010010: begin
							if(tmp0_8[0]) begin
								tmp0_32 <= tmp0_32 + (tmp1_32 + PreRangeOverhead);
							end
							instruction_count <= instruction_count + 1;
							state <= S_DONE;
						end
						/*
						 if (enables.final_range)
  						 {
    					  budget_us += (timeouts.final_range_us + FinalRangeOverhead);
  						 }
						*/
						6'b010011: begin
							mem_addr_reg <= SEQUENCE_STEP_ENABLE_FINAL_RANGE;
							mem_rw_reg <= 1'b0;
							mem_start_reg <= 1'b1;

							instruction_count <= instruction_count + 1;
							state <= S_DONE;
						end
						6'b010100: begin
							if(!mem_done) begin
								mem_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								tmp0_8 <= mem_data_in;
								mem_addr_reg <= SEQUENCE_STEP_TIMEOUTS_FINAL_RANGE_US;
								mem_rw_reg <= 1'b0;
								mem_start_reg <= 1'b1;

								instruction_count <= instruction_count + 1;
							end
							state <= S_DONE;
						end
						6'b010101: begin
							if(!mem_done) begin
								mem_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								tmp1_32 <= {8'h00, 8'h00, 8'h00, mem_data_in} & 32'h000000FF; 
								mem_addr_reg <= SEQUENCE_STEP_TIMEOUTS_FINAL_RANGE_US + 1;
								mem_rw_reg <= 1'b0;
								mem_start_reg <= 1'b1;

								instruction_count <= instruction_count + 1;
							end
							state <= S_DONE;
						end
						6'b010110: begin
							if(!mem_done) begin
								mem_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								tmp1_32 <= tmp1_32 + ({8'h00, 8'h00, mem_data_in, 8'h00} & 32'h0000FF00); 
								mem_addr_reg <= SEQUENCE_STEP_TIMEOUTS_FINAL_RANGE_US + 2;
								mem_rw_reg <= 1'b0;
								mem_start_reg <= 1'b1;

								instruction_count <= instruction_count + 1;
							end
							state <= S_DONE;
						end
						6'b010111: begin
							if(!mem_done) begin
								mem_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								tmp1_32 <= tmp1_32 + ({8'h00, mem_data_in, 8'h00, 8'h00} & 32'h00FF0000); 
								mem_addr_reg <= SEQUENCE_STEP_TIMEOUTS_FINAL_RANGE_US + 3;
								mem_rw_reg <= 1'b0;
								mem_start_reg <= 1'b1;

								instruction_count <= instruction_count + 1;
							end
							state <= S_DONE;
						end
						6'b011000: begin
							if(!mem_done) begin
								mem_start_reg <= 1'b0;
								instruction_count <= instruction_count;
							end
							else begin
								tmp1_32 <= tmp1_32 + ({mem_data_in, 8'h00, 8'h00, 8'h00} & 32'hFF000000); 
								instruction_count <= instruction_count + 1;
							end
							state <= S_DONE;
						end
						6'b011001: begin
							if(tmp0_8[0]) begin
								tmp0_32 <= tmp0_32 + (tmp1_32 + FinalRangeOverhead);
							end
							instruction_count <= instruction_count + 1;
							state <= S_DONE;
						end
						6'b011010: begin
							mem_addr_reg <= MEASUREMENT_TIMING_BUDGET;
							mem_data_out_reg <= tmp0_32[7:0];
							mem_rw_reg <= 1'b1;
							mem_start_reg <= 1'b1;
							
							instruction_count <= instruction_count + 1;
							state <= S_DONE;
						end
						6'b011011: begin
							if(!mem_done) begin 
								instruction_count <= instruction_count;
								mem_start_reg <= 1'b0;
							end
							else begin
								mem_addr_reg <= MEASUREMENT_TIMING_BUDGET + 1;
								mem_data_out_reg <= tmp0_32[15:8];
								mem_rw_reg <= 1'b1;
								mem_start_reg <= 1'b1;
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_DONE;
						end
						6'b011100: begin
							if(!mem_done) begin 
								instruction_count <= instruction_count;
								mem_start_reg <= 1'b0;
							end
							else begin
								mem_addr_reg <= MEASUREMENT_TIMING_BUDGET + 2;
								mem_data_out_reg <= tmp0_32[23:16];
								mem_rw_reg <= 1'b1;
								mem_start_reg <= 1'b1;
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_DONE;
						end
						6'b011101: begin
							if(!mem_done) begin 
								instruction_count <= instruction_count;
								mem_start_reg <= 1'b0;
							end
							else begin
								mem_addr_reg <= MEASUREMENT_TIMING_BUDGET + 3;
								mem_data_out_reg <= tmp0_32[31:24];
								mem_rw_reg <= 1'b1;
								mem_start_reg <= 1'b1;
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_DONE;
						end
						6'b011110: begin
							if(!mem_done) begin
								mem_start_reg <= 1'b0;
								instruction_count <= instruction_count;
								state <= S_DONE;
							end
							else begin
								timing_budget_reg <= tmp0_32;
								done_reg <= 1'b1;
								state <= S_RESET;
							end
						end
					endcase
				end
			endcase
		end
	end
	
	//assign registers to outputs 
	assign done = done_reg;
	assign timing_budget = timing_budget_reg;
	
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
	
	assign timing_budget_error = timing_budget_error_reg;
	assign instruction_count_debug = instruction_count;

endmodule
