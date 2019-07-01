`timescale 1ns / 1ps

module tb_proj7;

	// Inputs
	logic clk;
	logic rst_btn;
	logic [2:0] sw;
    
	// Outputs
	logic [3:0] led;

	// Instantiate the Unit Under Test (UUT)
	genomatic uut (
		.*
	);

	parameter CLK_PRD = 100; // 10 MHz clock
	parameter HOLD_TIME = (CLK_PRD*0.3);
	parameter MAX_SIM_TIME = (CLK_PRD*10000);
	
	initial #(MAX_SIM_TIME) $finish;
	
	initial begin
		clk <= 0;
		forever #(CLK_PRD/2) clk = ~clk;
	end
	
	initial begin
		// Initialize Inputs
		rst_btn = 0;
		sw = 0;

		// Wait 100 ns for global reset to finish
		#100;

		// Add stimulus here
		
		@(posedge clk); // align with clock edge
		
		#HOLD_TIME; // offset a hold time
		
		repeat(2) #CLK_PRD;
		
		rst_btn = 1; #CLK_PRD;
		
		rst_btn = 0;
		
		repeat(2) #CLK_PRD;
		
		$finish;
			
	end
	      
endmodule
