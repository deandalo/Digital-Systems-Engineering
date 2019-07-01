`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: AmusingLittleCircuit
//////////////////////////////////////////////////////////////////////////////////

module AmusingLittleCircuit(
    input logic rst, clk,
    output logic [1:0] dout
    );
    
    logic [1:0] spo, din;
    logic we;
    logic [3:0] count, addr;
        
    cntr cntr1(rst,
               clk,
               count);
               
//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
    dist_mem_gen_1 mem (
              .a(addr),      // input wire [3 : 0] a
              .d(din),      // input wire [1 : 0] d
              .clk(clk),  // input wire clk
              .we(we),    // input wire we
              .spo(spo)  // output wire [1 : 0] spo
              );
// INST_TAG_END ------ End INSTANTIATION Template ---------

   always_ff @(posedge clk)
       dout <= spo;
          
   always_comb	
       begin
           addr = {count[2],count[1]};
           we = count[3] & count[0];
           din = dout - 1;
       end
               
endmodule