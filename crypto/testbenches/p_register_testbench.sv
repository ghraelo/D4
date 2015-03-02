// D1
// modular multiplier testbench
/*
   author: jc21g13
   last revision: 21 Feb' 15
*/

module p_register_testbench;
//signals
logic[8-1:0] X,Y,M,P;
logic[$clog2(n)-1:0] iter;
logic clk,reset,mult,sub;

p_register  #(.n(8)) regi (.*);

//clk
initial
begin
	clk = 1'b0;
	forever #10 clk = ~clk;
end

initial
begin
	//defaults
	reset = 1'b0;
	mult = 1'b0;
	sub = 1'b0;

	X = 8'd7;
	Y = 8'd2;
	M = 8'd10;
	iter = 4;
	
	#20
	reset = 1'b1;
	#20
	reset = 1'b0;
	#20
	mult = 1'b1;
	#20
	mult = 1'b0;
	#20
	sub = 1'b1;
	#20
	sub = 1'b0;
end

endmodule