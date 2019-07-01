`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: DNA sequencer aka Genomatic
//////////////////////////////////////////////////////////////////////////////////

module genomatic(
    input logic clk, rst_btn, 
    input logic [2:0] sw,
    output logic [3:0] led
    );

//internal signals
    logic rst, done_cod, done_gen, shift, rst_array, inc_cnt, read_cod_ena, count, count_ena, done_cnt, inc_addr_ena, init_data_ena, init_cnt_ena, done_fin, sw_led_ena;
    logic [4:0] addr_cod;
    logic [3:0] spo_cod, nib_gene, spo_gen;
    logic [5:0] [4:0] data;
    logic [7:0] addr_gen;
    logic [5:0] [3:0] reg_cnt_cod;

//Instantiate the reset_sync
rst_sync rst_sync1 (.*);

//Instantiate the fsm
fsm fsm1 (.*);

//Instantiate the distributed memories
codon_mem codon_mem1 (
          .a(addr_cod),      // input wire [4 : 0] a
          //.d(din_cod),      // input wire [1 : 0] d
          //.clk(clk),  // input wire clk
          //.we(we_cod),    // input wire we
          .spo(spo_cod)  // output wire [3 : 0] spo
          );


gen_mem gen_mem1 (
          .a(addr_gen),      // input wire [7 : 0] a
          //.d(din_mem),      // input wire [1 : 0] d
          //.clk(clk_mem),  // input wire clk
          //.we(we_mem),    // input wire we
          .spo(spo_gen)  // output wire [3 : 0] spo
          );


cntr_codons cntr_codons1 (.*);
                          
arrays_codons arrays_codons1 (.*);

switches_leds switches_leds1 (.*);
        
endmodule
