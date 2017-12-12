`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:43:35 11/20/2017 
// Design Name: 
// Module Name:    ready_generator 
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
module ready_generator 

(input clk,
	 input restart,
	 input shift,
    input [16:0] key_num,
    output reg ready
    );
	 reg [11:0] divider_num = 0;
	 
	 reg [11:0] counter = 0;
        always @(posedge clk) begin
			  //casex allows x's to be don't cares
           casex (key_num)
				   /*
				   17'b1_xxxx_xxxx_xxxx_xxxx: divider_num <= 1612; //C
				   17'b0_1xxx_xxxx_xxxx_xxxx: divider_num <= 1522; //C#
					17'b0_01xx_xxxx_xxxx_xxxx: divider_num <= 1437; //D
					17'b0_001x_xxxx_xxxx_xxxx: divider_num <= 1356; //Eb
				   17'b0_0001_xxxx_xxxx_xxxx: divider_num <= 1280; //E
					17'b0_0000_1xxx_xxxx_xxxx: divider_num <= 1208; //F
			
					17'b0_0000_01xx_xxxx_xxxx: divider_num <= 1140; //F#
				   17'b0_0000_001x_xxxx_xxxx: divider_num <= 1076; //G
					17'b0_0000_0001_xxxx_xxxx: divider_num <= 1016; //G#
					
					17'b0_0000_0000_1xxx_xxxx: divider_num <= 959; //A
				   17'b0_0000_0000_01xx_xxxx: divider_num <= 905; //Bb
					17'b0_0000_0000_001x_xxxx: divider_num <= 854; //B
					17'b0_0000_0000_0001_xxxx: divider_num <= 806; //C high
					
					17'b0_0000_0000_0000_1xxx: divider_num <= 761; //C#
					17'b0_0000_0000_0000_01xx: divider_num <= 718; //D
					17'b0_0000_0000_0000_001x: divider_num <= 678; //Eb
				   17'b0_0000_0000_0000_0001: divider_num <= 640; //E
					*/
					17'b1_xxxx_xxxx_xxxx_xxxx: divider_num <= 1612 >> shift; //C
				   17'b0_1xxx_xxxx_xxxx_xxxx: divider_num <= 1522 >> shift; //C#
					17'b0_01xx_xxxx_xxxx_xxxx: divider_num <= 1437 >> shift; //D
					17'b0_001x_xxxx_xxxx_xxxx: divider_num <= 1356 >> shift; //Eb
				   17'b0_0001_xxxx_xxxx_xxxx: divider_num <= 1280 >> shift; //E
					17'b0_0000_1xxx_xxxx_xxxx: divider_num <= 1208 >> shift; //F
			
					17'b0_0000_01xx_xxxx_xxxx: divider_num <= 1140 >> shift; //F#
				   17'b0_0000_001x_xxxx_xxxx: divider_num <= 1076 >> shift; //G
					17'b0_0000_0001_xxxx_xxxx: divider_num <= 1016 >> shift; //G#
					
					17'b0_0000_0000_1xxx_xxxx: divider_num <= 959 >> shift; //A
				   17'b0_0000_0000_01xx_xxxx: divider_num <= 905 >> shift; //Bb
					17'b0_0000_0000_001x_xxxx: divider_num <= 854 >> shift; //B
					17'b0_0000_0000_0001_xxxx: divider_num <= 806 >> shift; //C high
					
					17'b0_0000_0000_0000_1xxx: divider_num <= 761 >> shift; //C#
					17'b0_0000_0000_0000_01xx: divider_num <= 718 >> shift; //D
					17'b0_0000_0000_0000_001x: divider_num <= 678 >> shift; //Eb
				   17'b0_0000_0000_0000_0001: divider_num <= 640 >> shift; //E
				endcase
            counter <= counter + 1;
            if (restart) counter <= 0;
            else if (counter >= divider_num) begin
                ready <= 1;
                counter <= 0;
            end
            else ready <= 0;
         end
endmodule





