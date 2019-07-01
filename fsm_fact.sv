`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: fsm_fact
//////////////////////////////////////////////////////////////////////////////////

module fsm_fact(
    input logic rst, clk, go_sync,  
	input logic ngt0, jgt1,
    output logic inicio, whilen, whilej, fine = 1'b0
    );

//symbolic state names as an enumerated type
typedef enum logic [2:0]
    {idle, init, check_num, n, check_j, j, fin} statetype;
statetype state;

//assign test_led = state;

// non-blocking assignments
always_ff @(posedge clk)
begin

if (rst)
    state <= idle;
else
    case (state)
        idle: if (go_sync) state <= init;
        init: state <= check_num;
        check_num: if (ngt0) state <= n; else state <= fin;  
        n: state <= check_j;
        check_j: if (jgt1) state <= j; else state <= check_num;
        j: state <= check_j;
		fin: state <= fin;
        default: state <= idle;//not needed;
    endcase
    
end

//output logic - blocking assignments
always_comb
begin
    inicio = 0;
	whilen = 0;
	whilej = 0;
	fine = 0;
    case (state)
        init: inicio = 1;
        n: whilen = 1;
		j:	whilej = 1;
		fin: fine = 1;
		default: ;//not needed;
    endcase
end     
           
endmodule