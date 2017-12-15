`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:01:12 12/11/2017 
// Design Name: 
// Module Name:    clock_divider 
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
module clock_divider(
    input clk_54mhz,
    input restart,
    output reg clk_27mhz
    );
    reg counter = 0;
    always @(posedge clk_54mhz) begin
       counter <= counter + 1;
       if (restart) counter <= 0;
       else if (counter == 1 ) begin
          clk_27mhz <= 1;
       end
       else clk_27mhz <= 0;
       end
endmodule
