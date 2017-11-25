`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:17:45 10/14/2016 
// Design Name: 
// Module Name:    Timer 
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
module Timer(
	 input clk,
	 input reset,
    input startTimer,
    input [3:0] value,
    input enable,
    output time_expired
    );
	 
	 //define state parameters 
	 parameter S_STALL = 1'b0;
	 parameter S_COUNT = 1'b1;
	 
	 reg state;
	 reg [3:0] count = 4'b0000; //register to hold 4bit delay values
	 reg time_expired_reg = 1'b0;

	always @(posedge clk) begin
		if(reset) state <= S_STALL;
		else begin 
			case(state)
				S_STALL: begin
					if(startTimer) state <= S_COUNT;
					else state <= S_STALL;
				end
				S_COUNT: begin
					if(count >= value) state <= S_STALL;
					else state <= S_COUNT;
				end
				default state <= S_STALL;
			endcase
		end
		
		//define state outputs 
		case(state)
			S_STALL: begin
				time_expired_reg <= 1'b0;
				count <= 4'b0000;
			end
			S_COUNT: begin
				if(enable) begin 
					count <= count + 1;
					time_expired_reg <= 1'b0;
				end
				else if(count >= value) begin 
					time_expired_reg <= 1'b1;
					count <= 4'b0000;
				end
				else begin 
					time_expired_reg <= 1'b0;
					count <= count;
				end
			end
			default: begin
				time_expired_reg <= 1'b0;
				count <= 4'b0000;
			end
		endcase
	end
	
	assign time_expired = time_expired_reg;

endmodule
