`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: factorial_dp
//////////////////////////////////////////////////////////////////////////////////

module factorial_dp(
    input logic clk, rst_btn, go, 
    input logic inicio, whilen, whilej, fine,
	input logic [31:0] n,
    output logic done, ngt0, jgt1, go_sync, rst, 
	output logic [31:0] rslt
    );
    
logic [31:0] temp,j,num;
logic [1:0] go_sreg=0, rst_sreg=0; //2FF synchronizer

assign go_sync = go_sreg[0];
assign rst = rst_sreg[0];

always_ff @ (posedge clk)
   begin
      // synch reset button
      go_sreg <= {go, go_sreg[1]};
      rst_sreg <= {rst_btn, rst_sreg[1]};
   
      if (rst)
         begin
            done <= 1'b0;
            rslt <= 32'b0;
         end
      else 
         begin
            if (inicio)
               begin
                  num = n;
                  if (n == 0)
                     begin
                        done <= 1;
                        rslt <= 1;
                     end
                  else
                     rslt <= n;      
               end       
            else if (whilen & num > 0)
               begin
                  num--;
                  temp = rslt;
                  j = num;
               end
            else if (whilej & j > 1)
               begin
                  j--;
                  rslt <= rslt + temp;
               end
            else if (fine)
               done <= 1;    
         end
   end
   
   always_comb
   begin
    ngt0 = 0;
    jgt1 = 0;
    if (num > 32'b0)
       ngt0 = 1;
    else
       ngt0 = 0;
    if (j > 32'b1)
       jgt1 = 1;
    end    
   
endmodule
