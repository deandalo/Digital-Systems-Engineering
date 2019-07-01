`timescale 1ns / 1ps

module tb_proj4;

	// Inputs
	logic clk;
	logic rst;

	// Outputs

	// Instantiate the Unit Under Test (UUT)
	AmusingLittleCircuit uut (
		.rst(rst),
		.clk(clk) 
	);

	parameter CLK_PRD = 100; // 10 MHz clock
	parameter HOLD_TIME = (CLK_PRD*0.3);
	parameter MAX_SIM_TIME = (CLK_PRD*100);
	
	initial #(MAX_SIM_TIME) $finish;
	
	initial begin
		clk <= 0;
		forever #(CLK_PRD/2) clk = ~clk;
	end
	
	initial begin
		// Initialize Inputs
		rst = 0;

		// Wait 100 ns for global reset to finish
		#100;

		// Add stimulus here
		
		@(posedge clk); // align with clock edge
		
		#HOLD_TIME; // offset a hold time
		
		repeat(2) #CLK_PRD;
		
		rst = 1; #CLK_PRD;
		
		rst = 0;
		
		repeat(2) #CLK_PRD;
		
		$finish;
			
	end
	      
endmodule
