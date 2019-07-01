`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: fsmSPI
//////////////////////////////////////////////////////////////////////////////////

module fsmSPI(
    input logic rst, clk, done, doneSPI, 
	input logic [7:0] din,
    output logic ena, load, rst_cnt, cnt_ena, spi, cs = 1
    );

//symbolic state names as an enumerated type
typedef enum logic [3:0]
    {idle, cntrst, preload, loadx, loady, check_zero, comp, spiout, fin} statetype;
statetype state = idle;

//assign test_led = state;

// non-blocking assignments
always_ff @(posedge clk)
    case (state)
        idle: if (rst) state <= cntrst;  
        cntrst: if (~rst) state <= preload;
		preload: state <= loadx;
		loadx: state <= loady; 
		loady: if (din == 0) state <= fin; else state <= check_zero;
		check_zero: if (din == 0) state <= fin; else state <= comp;
		comp: if (done) state <= spiout;
		spiout: begin if (doneSPI) state <= preload; cs <= 0; end
		fin: cs <= 1;
        default: ;//not needed;
    endcase

//output logic - blocking assignments
always_comb
begin
    ena = 0;
	load = 0;
	rst_cnt = 0;
	cnt_ena = 0;
	spi = 0;
	if (state == cntrst)
	   begin
	       ena = 1;
	       rst_cnt = 1;
	       //load = 1;
	   end
    if (state == preload)
        begin
            ena = 1;
            cnt_ena = 1;
            //load = 1;
        end
    if (state == loadx)
        begin 
            ena = 1;
            load = 1;
            cnt_ena = 1;
        end
    if (state == loady)
        begin
            ena = 1;
        end
    if (state == check_zero)
        ena = 1;
    if (state == comp)
        ena = 1;
    if (state == spiout)
        spi = 1;
end  
 
endmodule