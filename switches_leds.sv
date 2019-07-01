`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: switches_leds
//////////////////////////////////////////////////////////////////////////////////

module switches_leds(
    input logic sw_led_ena,
    input logic [5:0] [3:0] reg_cnt_cod,  
    input logic [2:0] sw,
    output logic [3:0] led
    );

always_comb
    if (sw_led_ena)
        case (sw)
            0: led = 1;
            7: led = 0;
            default: led = reg_cnt_cod [sw - 1];
        endcase
    else
        led = 0;

endmodule
