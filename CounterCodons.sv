`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: cntr_codons
//////////////////////////////////////////////////////////////////////////////////

module cntr_codons(
    input logic clk, rst, count_ena, init_cnt_ena,
    input logic [5:0] [3:0] data,
    input logic [3:0] spo_gen,
    output logic [7:0] addr_gen,
    output logic done_gen,
    output logic [5:0] [3:0] reg_cnt_cod
    );

//internal signals 
logic [2:0] reg_index = 3'd5; //index for data goes from 5 to 0
logic [2:0] cnt_reg = 3'd0; //number of register being processed, from 0 up to 5
logic [3:0] count;  //count of matches
logic f = 1'b0;
            
always_ff@(posedge clk)
begin 
    done_gen = 0;
    if (init_cnt_ena)
       begin
          count = 4'd0;
          addr_gen = 8'd0;
          reg_index <= 5;
       end
    if (rst)
       addr_gen <= 0;
    else
       if (count_ena)
       begin
          if (spo_gen == 4'hF & f == 0)
              f <= 1;
          else if (spo_gen == 4'hF & f == 1)
              begin
                 done_gen <= 1;
                 reg_cnt_cod [cnt_reg] <= count;
                 cnt_reg <= cnt_reg + 1;
                 f <= 0;
              end
          else
             begin 
             if (spo_gen == data [reg_index])
                if (data[reg_index - 1] == 4'hF)
                    begin
                        count <= count + 1;
                        reg_index <= 5;
                    end
                else
                    reg_index <= reg_index - 1;
              f <= 0;
              end
          addr_gen <= addr_gen + 1;
          if (addr_gen == 256)
              begin
                  done_gen <= 1;
                  reg_cnt_cod [cnt_reg] <= count;
                  cnt_reg <= cnt_reg + 1;
              end
      end                       
end
    
endmodule
