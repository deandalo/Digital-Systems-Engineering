`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: cntr
//////////////////////////////////////////////////////////////////////////////////

module cntr(
    input logic rst, clk,
    output logic [3:0] count
    );

//internal signals 
            
always @(posedge clk) 
    begin
		if (count < 16)
			count = count + 1;
		else
			count = 0;
    end

endmodule
