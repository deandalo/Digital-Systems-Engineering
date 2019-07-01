`timescale 1ns / 1ps

module proj5_tb;

	// Inputs
	logic clk;
	logic rst_btn;
	
	//Outputs
	logic [2:0] je;
	
	// Outputs
	//logic [7:0] gcd_rslt;
	//logic done;

	// Instantiate the Unit Under Test (UUT)
	gcd_SPI uut (
		.clk(clk), 
		.btn(rst_btn), 
		.je(je)
	);

	parameter CLK_PRD = 100; // 10 MHz clock
	parameter HOLD_TIME = (CLK_PRD*0.3);
	parameter MAX_SIM_TIME = (CLK_PRD*100000);
	
	initial #(MAX_SIM_TIME) $finish;
	
	initial begin
		clk <= 0;
		forever #(CLK_PRD/2) clk = ~clk;
	end
	
	initial begin
		// Initialize Inputs
		rst_btn = 0;

		// Wait 100 ns for global reset to finish
		#100;

		// Add stimulus here
		
		@(posedge clk); // align with clock edge
		
		#HOLD_TIME; // offset a hold time
		
		repeat(2) #CLK_PRD;
		
		//rst_btn = 1; #CLK_PRD;
		
		//rst_btn = 0;
		
		repeat(2) #CLK_PRD;
		
		begin : run_loop
			forever
				begin
					@(posedge clk);
					//if (done) disable run_loop;
				end
		end // run_loop
		
		$finish;
			
	end
	      
endmodule
