// D1
// Grain 128a module testbench
/*
   author: jc21g13
   last revision: 22 Feb' 15
*/

module grain_128_testbench;
//signals
logic clk,n_reset, initialise, enable;
logic[95:0] IV;
logic[127:0] key;
logic key_stream,ready;

grain_128a G128 (.*);


//clk
initial
begin
	clk = 1'b0;
	forever #10 clk = ~clk;
end

initial
begin
	//defaults
	IV = 96'h32a4ba0884bd27d3120878f2;
	key = 128'h786477e1dc256ca0f2d71da33e3a6042;
	n_reset = 1'b0;
	initialise = 1'b0;
	enable = 1'b0;

	#20
	n_reset = 1'b1;

	#5120
	enable = 1'b1;

	#2560
	initialise = 1'b1;
	enable = 1'b0;
	#20
	initialise = 1'b0;
end
endmodule