`timescale 1ns / 1ps

module tb;

	// Inputs
	logic clk;
	logic rst;
	logic load;
	logic [7:0] din;

	// Outputs
	logic [7:0] gcd_rslt;
	logic done;

	// Instantiate the Unit Under Test (UUT)
	gcd_core uut (
		.clk(clk), 
		.rst(rst), 
		.load(load), 
		.din(din), 
		.gcd_rslt(gcd_rslt), 
		.done(done)
	);

	parameter CLK_PRD = 100; // 10 MHz clock
	parameter HOLD_TIME = (CLK_PRD*0.3);
	parameter MAX_SIM_TIME = (CLK_PRD*30);
	
	initial #(MAX_SIM_TIME) $finish;
	
	initial begin
		clk <= 0;
		forever #(CLK_PRD/2) clk = ~clk;
	end
	
	initial begin
		// Initialize Inputs
		rst = 0;
		load = 0;
		din = 8'bx;

		// Wait 100 ns for global reset to finish
		#100;

		// Add stimulus here
		
		@(posedge clk); // align with clock edge
		
		#HOLD_TIME; // offset a hold time
		
		repeat(2) #CLK_PRD;
		
		rst = 1; #CLK_PRD;
		
		rst = 0;
		
		repeat(2) #CLK_PRD;
		
		load = 1; #CLK_PRD;
		
		load = 0; din = 8'd27; #CLK_PRD;
		
		din = 8'd18; #CLK_PRD;
		
		din = 8'bx; #CLK_PRD;
		
		begin : run_loop
			forever
				begin
					@(posedge clk);
					if (done) disable run_loop;
				end
		end // run_loop
		
		$finish;
			
	end
	      
endmodule
