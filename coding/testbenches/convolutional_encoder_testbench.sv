module convolutional_encoder_testbench;
//signals

logic msg_in, clk, n_reset, shift,n1,n2,zeroed;

convolutional_encoder CE (.*);

//clk
initial
begin
	clk = 1'b1;
	forever #10 clk = ~clk;
end

initial
begin
	//defaults
	n_reset = 1'b0;
	msg_in = 1'b0;
	shift = 1'b0;

	//release reset
	#20 n_reset = 1'b1;
		shift = 1'b1;
	#20 msg_in = 1'b1;
	#20 msg_in = 1'b1;
	#20 msg_in = 1'b0;
	#20 msg_in = 1'b0;
	#20 msg_in = 1'b1;
	#20 msg_in = 1'b1;
	#20 msg_in = 1'b0;
	#20 msg_in = 1'b0;
	#20 msg_in = 1'b0;
end

endmodule