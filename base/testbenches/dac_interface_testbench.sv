	// D4
// DAC interface testbench
/*
   author: jc21g13
   last revision: 24 Feb' 15
*/

module dac_interface_testbench;
//signals

logic[7:0] data;
logic start, sclk, n_reset, dac_miso, done, dac_mosi, dac_cs;

dac_interface DI (.*);

//clk
initial
begin
	sclk = 1'b1;
	forever #10 sclk = ~sclk;
end

initial
begin
	//defaults
	start = 1'b0;
	data = 8'b00110011;
	n_reset = 1'b0;

	//release reset
	#25 n_reset = 1'b1;

	//start
	#25 start = 1'b1;
	#25 start = 1'b0;

	//fake miso
	#25 dac_miso = 1'b1;
	#25 dac_miso = 1'b0;
	#25 dac_miso = 1'b1;
	#25 dac_miso = 1'b0;
	#25 dac_miso = 1'b1;
	#25 dac_miso = 1'b0;
	#25 dac_miso = 1'b1;
	#25 dac_miso = 1'b0;
	#25 dac_miso = 1'b1;
	#25 dac_miso = 1'b0;
	#25 dac_miso = 1'b1;
	#25 dac_miso = 1'b0;
	#25 dac_miso = 1'b1;
	#25 dac_miso = 1'b0;
	#25 dac_miso = 1'b1;
	#25 dac_miso = 1'b0;

end

endmodule