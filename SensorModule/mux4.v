`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:07:33 11/20/2017 
// Design Name: 
// Module Name:    mux4 
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
module mux4(sel, signal0, signal1, signal2, signal3, out);
	 parameter SIGNAL_WIDTH = 1;
    input [1:0] sel;
    input [SIGNAL_WIDTH-1:0] signal0;
    input [SIGNAL_WIDTH-1:0] signal1;
    input [SIGNAL_WIDTH-1:0] signal2;
    input [SIGNAL_WIDTH-1:0] signal3;
    output [SIGNAL_WIDTH-1:0] out;
	 
	 reg [SIGNAL_WIDTH-1:0] out_reg = 0;
	 
	 always @(*) begin
		case(sel)
			2'b00: out_reg = signal0;
			2'b01: out_reg = signal1;
			2'b10: out_reg = signal2;
			2'b11: out_reg = signal3;
			default: out_reg = signal0;
		endcase
	 end
	 
	 assign out = out_reg;

endmodule
