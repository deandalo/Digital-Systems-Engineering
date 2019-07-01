`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: fsm
//////////////////////////////////////////////////////////////////////////////////

module fsm(
    input logic rst, clk, done_cod, done_gen, done_fin,
	output logic shift, rst_array, inc_cnt, read_cod_ena, count_ena, inc_addr_ena, init_data_ena, init_cnt_ena, sw_led_ena 
    );

//symbolic state names as an enumerated type
typedef enum logic [3:0]
    {idle, init_data, read_cod, init_cnt, count, fin} statetype;
statetype state;

//assign test_led = state;

// non-blocking assignments
always_ff @(posedge clk)
begin

    case (state)
        idle: if (rst) state <= init_data;  
        init_data: if (done_fin) state <= fin; else state <= read_cod; 
        read_cod: if (done_cod) state <= init_cnt;
        init_cnt: state <= count;
        count: if (done_gen) state <= init_data;
		fin: state <= fin;
        default: state <= idle;//not needed;
    endcase
    
end

//output logic - blocking assignments
always_comb
begin
    shift = 0;
    rst_array = 0;
    inc_cnt = 0;
    read_cod_ena = 0;
    count_ena = 0;
    init_data_ena = 0;
    inc_addr_ena = 0;
    init_cnt_ena = 0;
    sw_led_ena = 0;
    case (state)
        idle: ;
		init_data: init_data_ena = 1; 
		read_cod: read_cod_ena = 1;
		init_cnt: init_cnt_ena = 1;
		count: count_ena = 1; 
		fin: sw_led_ena = 1;
        default: ;//not needed;
    endcase

end     
           
endmodule