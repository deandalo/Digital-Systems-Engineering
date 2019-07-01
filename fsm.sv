`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: fsm
//////////////////////////////////////////////////////////////////////////////////

module fsm(
    input clk, rst, load,
    input logic x_eq_y, x_gt_y,
    output logic xload, yload, xhold, yhold, done
    );
    
    //symbolic state names as an enumerated type
    typedef enum logic [2:0]
        {idle, loadx, loady, comp, fine} statetype;
    statetype state;
    
    // NSL and state register -non-blocking assignment
    always_ff @(posedge clk)
    begin
    if (rst)
        state <= idle;
    else
        case (state)
            idle : if (load) state <= loadx;
            loadx: state <= loady;
            loady: state <= comp;
            comp: if (x_eq_y) state <= fine;
            fine : casez ({load, rst})
                      2'b00    :   state <= idle;
                      2'b?1    :   state <= idle;
                      2'b10    :   state <= loadx;
                   endcase
            default: ;//not needed;
        endcase
    end
    
    //output logic - blocking assignments
    always_comb
    begin
        //default outputs
        xload = 1; xhold = 1; yload = 1; yhold = 1;
        done = 0;
            case (state)
                idle  :
                    begin
                    end
                loadx :
                    begin
                        xload = 0; xhold = 0;
                    end
                loady :
                    begin
                        yload = 0; yhold = 0;
                    end
                comp :
                    if (x_gt_y)
                       begin
                          xload = 1;
                          yload = 0;
                       end
                    else
                       begin
                          yload = 1;
                          xload = 0;
                       end  
                fine : done = 1;
                default : ;
            endcase
    end     
            
endmodule
