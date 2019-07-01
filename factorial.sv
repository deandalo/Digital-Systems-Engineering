`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: factorial
//////////////////////////////////////////////////////////////////////////////////

module factorial(
    input logic clk, rst_btn, go, 
   	input logic [31:0] n,
    output logic done,  
	output logic [31:0] rslt
    );
    
logic [31:0] temp,j;
logic inicio, whilen, whilej, fine, go_sync, ngt0, jgt1, rst;

   factorial_dp factorial_dp1 (
         .*
              ); 
   
   fsm_fact fsm_fact1 (
         .*
              );    

endmodule
