	// D4
// spi_slave_interface testbench
/*
   author: jc21g13
   last revision: 01 Mar' 15
*/

module spi_slave_interface_testbench;
//signals

logic clk,n_reset,sclk,miso,mosi,ss;
logic[7:0] data,send_buffer;
spi_slave_interface SSI (.*);

//clk
initial
begin
	clk = 1'b1;
	forever #10 clk = ~clk;
end

//sclk
initial
begin
	#15
	sclk = 1'b1;
	forever #20 sclk = ~sclk;
end

initial
begin
	//defaults
	n_reset = 1'b0;
	ss = 1'b1;
	send_buffer = 8'b11100011;
	mosi = 0'b0;
	//release reset
	#15 n_reset = 1'b1;

	//fake miso
	#40 mosi = 1'b1;
		ss = 1'b0;
	#40 mosi = 1'b1;
	#40 mosi = 1'b0;
	#40 mosi = 1'b0;
	#40 mosi = 1'b0;
	#40 mosi = 1'b0;
	#40 mosi = 1'b1;
	#40 mosi = 1'b0;
	#40 mosi = 1'b1;
		ss = 1'b1;
	#40 mosi = 1'b0;

end

endmodule