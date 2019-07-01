`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: reset_sync
//////////////////////////////////////////////////////////////////////////////////

module rst_sync(
    input logic clk, rst_btn,
    output logic rst
    );
    
logic [1:0] rst_sreg=0; //2FF synchronizer

assign rst = rst_sreg[0];

// synch reset button
always_ff@(posedge clk)
   rst_sreg <= {rst_btn, rst_sreg[1]};

endmodule
