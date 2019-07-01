`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: debounce
//////////////////////////////////////////////////////////////////////////////////

module debounce(
    input logic clk, rst_btn,
    output logic rst
    );
    
logic [1:0] rst_sreg=0; //2FF synchronizer

assign rst = rst_sreg[0];

always_ff@(posedge clk)
begin
   // synch reset button
   rst_sreg <= {rst_btn, rst_sreg[1]};
   
end    

endmodule
