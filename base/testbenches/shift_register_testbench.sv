// D4
// shift register testbench
/*
   author: jc21g13
   last revision: 23 Feb' 15
*/

module shift_register_testbench;
//signals
logic[7:0] pdatain, pdataout;
logic clk, n_reset, sdatain, shift, load;

shift_register  #(.n(8)) exp(.*);

//clk
initial
begin
	clk = 1'b0;
	forever #10 clk = ~clk;
end

initial
begin
	//defaults
	pdatain = 8'b11001100;
	n_reset = 1'b0;
	shift = 1'b0;
	load = 1'b0;

	#50
	n_reset = 1'b1;

	//test load
	#50
	load = 1'b1;
	#50
	load = 1'b0;

	sdatain = 1'b0;
	//test shift
	#50
	shift = 1'b1;

	#50
	sdatain = 1'b1;
	#50
	shift = 1'b1;
	#50
	shift = 1'b1;
	#50
	shift = 1'b0;

	//test load again
	#50
	load = 1'b1;
	#50
	load = 1'b0;
	
	#150
	n_reset = 1'b1;
end

endmodule