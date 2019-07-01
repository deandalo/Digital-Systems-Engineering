`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module clk_div(
    input logic fclk,
    output logic sclk
    );


logic [1:9] lfsr = 0;

// lfsr 
always_ff@(posedge fclk)
begin        
    
    // LFSR 
    lfsr <= {(lfsr[5] ~^ lfsr[9]), lfsr[1:8]};
    if (lfsr == 0)
		sclk <= 1;
	else
		sclk <= 0;
		
end
          
endmodule
