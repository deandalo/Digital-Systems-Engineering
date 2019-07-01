`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module SPI(
    input logic clk, sclk, spi,
	input logic [7:0] gcd_rslt,
	output logic gcd_rslt_serial, doneSPI, enaSPI
    );

    logic [7:0] shift_reg;
    logic [4:0] count = 0;
    
    typedef enum logic [1:0]
        {s0, s1, s2} statetype;
    statetype state = s0;
    
    always_ff@ (posedge clk)
        case (state) 
            s0: begin enaSPI <= 0;if (spi) state <= s1; end 
            s1: if (sclk) state <= s2;
            s2: begin enaSPI <= count > 0 & count < 9; state <= s0; end
            default: state <= s0;
        endcase
        
    always@ (posedge clk)
       begin
        doneSPI = 0;
        if (state == s2)
            begin
                if (count ==0)
                    shift_reg = gcd_rslt;
                else
                begin
                    //gcd_rslt_serial = shift_reg[0];
                    //shift_reg = {1'b0,shift_reg[7:1]};
                    gcd_rslt_serial = shift_reg[7];
                    shift_reg = {shift_reg[6:0],1'b0};
                    
                end    
                
                count++;
                if (count == 4'd10)
                    begin
                        doneSPI = 1;
                        count = 0;
                    end
            end
        end
        
        //always@ (negedge clk)
          //  enaSPI = sclk & count > 0 & count < 9;
     
endmodule
