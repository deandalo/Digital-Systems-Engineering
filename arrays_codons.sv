`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: arrays_codons
// Four-element shift reg with each elemenbt
// consisting of a 5-bit word
//////////////////////////////////////////////////////////////////////////////////

module arrays_codons(
    input logic clk, rst, read_cod_ena, init_data_ena, 
    input logic [3:0] spo_cod,
    output logic [3:0] nib_gene, 
    output logic [4:0] addr_cod,
    output logic [5:0] [3:0] data,
    output logic done_cod = 0, done_fin = 0
    );

logic [2:0] cnt_array = 5; //5 to 0; this is the index for data

assign nib_gene = data [0] [3:0];

always_ff@(posedge clk)
begin
    if (rst)
        addr_cod <= 0;
    else
    begin
        if (init_data_ena)
           begin
              done_cod <= 0;
              data <= {3'h0,3'h0,3'h0,3'h0,3'h0};
              cnt_array <= 3'd5;
              if (spo_cod == 4'hF)
                done_fin <= 1;
                
           end
        else if (read_cod_ena)
        begin
            if (cnt_array >= 0)
                begin
                    if (cnt_array == 4'h5 | data[cnt_array + 1] != 4'hF)
                       begin
                          data[cnt_array] <= spo_cod;
                          addr_cod++;
                          cnt_array--;
                       end
                    if (spo_cod == 4'hF)
                        begin
                           done_cod <= 1;
                        end 
                end
         end
    end
end    
   
endmodule
