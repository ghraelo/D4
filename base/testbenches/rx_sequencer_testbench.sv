	// D4
// rx sequencer testbench
/*
   author: jc21g13
   last revision: 23 Feb' 15
*/

module rx_sequencer_testbench;
//signals
logic[7:0] spi_data;
logic clk, n_reset, spi_ready,spi_begin,im_type,pass_data,recieve;

rx_sequencer rxs (.*);

//clk
initial
begin
	clk = 1'b0;
	forever #10 clk = ~clk;
end

initial
begin
	//defaults
	spi_ready = 1'b0;
	spi_data = 8'b00110011;
	recieve = 1'b0;
	n_reset = 1'b0;

	#50
	n_reset = 1'b1;

	//begin recieve
	#50
	recieve = 1'b1;
	#50
	recieve = 1'b0;

	//assert spi ready
	#150
	spi_ready = 1'b1;
	#50
	spi_ready = 1'b0;

	//assert spi ready - test not stop
	#150
	spi_ready = 1'b1;
	#50
	spi_ready = 1'b0;

	spi_data = 8'b11001100;

	//assert spi ready - test STOP
	#150
	spi_ready = 1'b1;
	#50
	spi_ready = 1'b0;
	
	#150
	n_reset = 1'b1;
end

endmodule