`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: cntr
//////////////////////////////////////////////////////////////////////////////////

module cntr(
    input logic clk, rst,
    output logic [3:0] count
    );

//internal signals 
            
always @(posedge clk) 
    if (rst)
        count = 0;
    else
        count = count + 1;

endmodule
