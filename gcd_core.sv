`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: gcd_core
//////////////////////////////////////////////////////////////////////////////////

module gcd_core(
    input logic clk,
    input logic rst,
    input logic load,
    input logic [7:0] din,
    output logic [7:0] gcd_rslt,
    output logic done
    );

//internal signals
logic xhold, xload, yhold, yload;
logic x_eq_y, x_gt_y;
logic [7:0] x_minus_y, y_minus_x;

//Instantiate the datapath - couuld have used .name or .*
dp dp1 (
    .clk(clk),
    .xhold(xhold),
    .xload(xload),
    .yhold(yhold),
    .yload(yload),
    .din(din),
    .x_eq_y(x_eq_y),
    .x_gt_y(x_gt_y),
    .gcd_rslt(gcd_rslt)
    );
 
 //Instantiate the controller
 fsm fsm1 (
    .clk(clk),
    .rst(rst),
    .load(load),
    .x_eq_y(x_eq_y),
    .x_gt_y(x_gt_y),
    .xhold(xhold),
    .xload(xload),
    .yhold(yhold),
    .yload(yload),
    .done(done)
    );
           
endmodule
