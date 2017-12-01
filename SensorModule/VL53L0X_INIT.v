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
	 output [7:0] ram_addr,
	 output [7:0] ram_data_out,
	 input [7:0] ram_data_in,
	 output ram_wr_en,
	 
	 //status
	 output init_error
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
	parameter STOP_VARIABLE = 8'h00;
	parameter SPAD_COUNT = 8'h01;
	parameter SPAD_TYPE_IS_APERTURE = 8'h02;
	

	//define state parameters
	parameter S_RESET = 2'b00;
	parameter S_DATA_INIT = 2'b01;
	parameter S_STATIC_INIT = 2'b10;
	parameter S_PERFORM_REF_CALIBRATION = 2'b11;
	
	//define state register and counters
	reg [1:0] state = 2'b00;
	reg [3:0] instruction_count = 4'b0000;
	
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
	
	reg [7:0] ram_addr_reg = 8'h00;
	reg [7:0] ram_data_out_reg = 8'h00;
	reg ram_wr_en_reg = 1'b0;
	
	reg init_error_reg = 1'b0;
	
	////////////////////////////////////////////////////////////////////////////
	// Local ROM to store large number of register writes
	///////////////////////////////////////////////////////////////////////////
	wire [15:0] rom_data;
	reg [7:0] rom_addr_reg = 8'h00; 
	
	ROM INIT_ROM (
		.clka(clk),
		.addra(rom_addr_reg),
		.douta(rom_data)
	);
	
	////////////////////////////////////////////////////////////////////////////
	// Sub-FSM GetSPADInfo
	///////////////////////////////////////////////////////////////////////////
	wire spad_start;
	wire spad_done;
	
	wire write_start_spad;
	wire write_done_spad;
	wire write_multi_start_spad;
	wire write_multi_done_spad;
	wire read_start_spad;
	wire read_done_spad;
	
	wire timer_exp_spad;
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
	wire fifo_full_spad;
	wire fifo_write_ack_spad;
	wire fifo_overflow_spad;
		
	wire [7:0] fifo_data_in_spad;
	wire fifo_read_en_spad;
	wire fifo_empty_spad;
	wire fifo_read_valid_spad;
	wire fifo_underflow_spad;
	
	wire [7:0] ram_addr_spad;
	wire [7:0] ram_data_out_spad;
	wire [7:0] ram_data_in_spad;
	wire ram_wr_en_spad;
	
	wire spad_error;
	
	get_spad_info get_spad_info(
		.reset(reset),
		.clk(clk),
		.start(spad_start),
		.done(spad_done),
		
		.write_start(write_start_spad),
		.write_done(write_done_spad),
		.write_multi_start(write_multi_start_spad),
		.write_multi_done(write_multi_done_spad),
		.read_start(read_start_spad),
		.read_done(read_done_spad),
		
		.timer_exp(timer_exp_spad),
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
	   .fifo_full(fifo_full_spad),
	   .fifo_write_ack(fifo_write_ack_spad),
	   .fifo_overflow(fifo_overflow_spad),
		
		.fifo_data_in(fifo_data_in_spad),
	   .fifo_read_en(fifo_read_en_spad),
	   .fifo_empty(fifo_empty_spad),
	   .fifo_read_valid(fifo_read_valid_spad),
	   .fifo_underflow(fifo_underflow_spad),
		
		.ram_addr(ram_addr_spad),
	   .ram_data_out(ram_data_out_spad),
	   .ram_data_in(ram_data_in_spad),
	   .ram_wr_en(ram_wr_en_spad),
		
		.spad_error(spad_error)
		
	);
	
	//main FSM implementation
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
					ram_addr_reg <= 8'h00;
					ram_data_out_reg <= 8'h00;
					ram_wr_en_reg <= 1'b0;
					
					init_error_reg <= 1'b0;
					
					instruction_count <= 4'b0000;
				end
				S_DATA_INIT: begin
					case(instruction_count)
						///////////////////////////////////////////////////////////////
						// Setting IO voltage to 2.8 V
						///////////////////////////////////////////////////////////////
						4'b0000: begin
							//setup register read
							read_start_reg <= 1'b1;
							fnc_sel_reg <= 2'b01; //sel read
							n_bytes_reg <= 4'b0001;
							reg_address_out_reg <= VHV_CONFIG_PAD_SCL_SDA__EXTSUP_HV;
							
							state <= S_DATA_INIT;
							instruction_count <= instruction_count + 1;
						end
						4'b0001: begin
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
						4'b0010: begin
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
						4'b0011: begin
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
								reg_address_out_reg <= 8'h91;
								
								instruction_count <= instruction_count + 1;
							end
							state <= S_DATA_INIT;
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
							state <= S_DATA_INIT;
						end
						4'b0110: begin
							if(!fifo_read_valid) begin
								instruction_count <= instruction_count;
								fifo_read_en_reg <= 1'b0;
							end
							else begin
								ram_addr_reg <= STOP_VARIABLE;
								ram_data_out_reg <= fifo_data_in;
								ram_wr_en_reg <= 1'b1;
								
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
						4'b0111: begin
							if(!write_done) begin
								instruction_count <= instruction_count;
								write_start_reg <= 1'b0;
								ram_wr_en_reg <= 1'b0;
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
						// disable SIGNAL_RATE_MSRC (bit 1) 
						//and SIGNAL_RATE_PRE_RANGE (bit 4) limit checks
						4'b1000: begin
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
						4'b1001: begin
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
						4'b1010: begin
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
						//SET SIGNAL RATE LIMIT
						4'b1011: begin
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
						4'b1100: begin
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
						4'b1101: begin
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
						4'b1110: begin
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
						4'b1111: begin
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
					endcase
				end
				S_STATIC_INIT: begin
					case(instruction_count)
						4'b0000: begin
							
						end
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
	
	assign init_error = init_error_reg;

endmodule
