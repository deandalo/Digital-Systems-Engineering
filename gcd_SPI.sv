`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: gcd_SPI
//////////////////////////////////////////////////////////////////////////////////

module gcd_SPI(
    input logic clk,
    input logic [0:0] btn,
    output logic [2:0] je
    //output logic [0:0] led
    );

//internal signals
    logic rst, ena, load, rst_cnt, cnt_ena, sclk, gcd_rslt_serial, doneSPI, spi, cs, done;
    logic [4:0] addr;
    logic [7:0] din, gcd_rslt;
    
//Instantiate the debounce
debounce debounce1 (.rst_btn(btn[0]),
                    .*
                    );

//Instantiate the fsm
fsmSPI fsmSPI1 (.cs(je[0]),
                .*);

//Instantiate the block memory
blk_mem_gen_0 mem (
  .clka(clk),    // input wire clka
  .ena(ena),      // input wire ena
  .addra(addr),  // input wire [4 : 0] addra
  .douta(din)  // output wire [7 : 0] douta
);

//Instantiate the gcd_core
gcd_core gcd_core1 (.*);

//Instantiate the SPI module
SPI SPI1 (.enaSPI(je[1]),
          .gcd_rslt_serial(je[2]),
          .*);

//Instantiate the counter
counter counter1 (.*);

//Instantiate the clock divider
clk_div clk_div1 (
    .fclk(clk),
    .sclk(sclk)
);

//assign je[3]=1;
//always_comb
//if (btn[0]) led[0]=1;

endmodule
