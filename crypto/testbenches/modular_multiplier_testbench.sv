// D1
// modular multiplier testbench
/*
   author: jc21g13
   last revision: 21 Feb' 15
*/

module modular_multiplier_testbench;
//signals
logic[8-1:0] X,Y,M,P;
logic start,done,clk,n_reset;

modular_multiplier  #(.n(8)) mult(.*);

//clk
initial
begin
	clk = 1'b0;
	forever #10 clk = ~clk;
end

initial
begin
	//defaults
	start = 1'b0;
	n_reset = 1'b0;
	X = 8'd7;
	Y = 8'd2;
	M = 8'd10;
	#50
	n_reset = 1'b1;
	start = 1'b1;
	#50
	start = 1'b0;
	#150
	n_reset = 1'b1;
end

endmodule