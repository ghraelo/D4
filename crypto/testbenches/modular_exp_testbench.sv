// D1
// modular exponentiation module testbench
/*
   author: jc21g13
   last revision: 22 Feb' 15
*/

module modular_exp_testbench;
//signals
logic[8-1:0] X,Y,M,P;
logic start,done,clk,n_reset;

modular_exp  #(.n(8)) exp(.*);

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