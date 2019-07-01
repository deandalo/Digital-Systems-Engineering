`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: dp
//////////////////////////////////////////////////////////////////////////////////

module dp(
    input logic xhold, xload, yhold, yload, clk,
    input logic [7:0] din,  
    output logic x_eq_y, x_gt_y, 
    output logic [7:0] gcd_rslt = 0
    );
    
    logic [7:0] x = 0,y = 0;
    logic [7:0] x_minus_y = 0, y_minus_x = 0;
    
    //comparators
    assign x_eq_y = (x==y);
    assign x_gt_y = (x>y);
    
    always_comb
    begin
    
    gcd_rslt = 0;
    x_minus_y = 0;
    y_minus_x = 0;
    
    if (x==y)
               gcd_rslt = x;
    
    if (x>y)
       begin 
           x_minus_y = x - y;
           gcd_rslt = x - y;
       end
    
    if (x<y) 
       begin
           y_minus_x = y - x;
           gcd_rslt = y - x;
       end
   
   end     

            
    // x and y registers with cascaded muxes
    always_ff @(posedge clk)
    
    begin
    
    if (xload)
        x <= x_minus_y;
    else if (~xhold)
        x <= din;
        
    if (yload)
        y <= y_minus_x;
    else if (~yhold)
        y <= din;
   
    end
     
endmodule
