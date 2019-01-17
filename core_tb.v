`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
module core_tb;

	// Inputs
	reg clk;
	reg rst;

	// Outputs


	// Instantiate the Unit Under Test (UUT)
	core uut (
		.clk(clk), 
		.rst(rst)
	);
parameter half_cycle = 5;
	initial begin
		// Initialize clk
		clk = 0;
		forever 
		clk = #half_cycle ~clk;
	end
	
	initial begin
		// Initialize rst
		rst = 1;
		#(1.5*half_cycle) rst = 0;
		#(2*half_cycle) rst = 1;
	end

initial
#(50*half_cycle) $finish;
      
endmodule

