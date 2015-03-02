// D4
// SPI slave interface
/*
   author: jc21g13
   last revision: 01 Mar' 15
*/

module spi_slave_interface(input logic clk, n_reset, sclk, mosi, ss, input logic[7:0] send_buffer, output logic[7:0] data, output logic miso);

//sample SCLK
logic[2:0] sclk_samp;
always_ff @(posedge clk or negedge n_reset)
	if(~n_reset)
		sclk_samp <= 0;
	else
		sclk_samp <= {sclk_samp[1:0],sclk};

//rising/falling edges:
logic sclk_rising,sclk_falling;

assign sclk_rising = (sclk_samp[2:1] == 2'b01);
assign sclk_falling = (sclk_samp[2:1] == 2'b10);

//sample SS
logic[2:0] ss_samp;
always_ff @(posedge clk or negedge n_reset)
	if(~n_reset)
		ss_samp <= 0;
	else
		ss_samp <= {ss_samp[1:0],ss};

//rising/falling edges:
logic ss_end,ss_start,ss_active;
assign ss_end = (ss_samp[2:1] == 2'b01); //stops @ rising edge
assign ss_start = (ss_samp[2:1] == 2'b10); //starts @ falling edge
assign ss_active = ~ss_samp[1];

//sample MOSI
logic[1:0] mosi_samp;
always_ff @(posedge clk or negedge n_reset)
	if(~n_reset)
		mosi_samp <= 0;
	else
		mosi_samp <= {mosi_samp[0],mosi};

logic mosi_data;
assign mosi_data = mosi_samp[1];

//recieve & send data
logic[2:0] counter;
logic[7:0] send;
always_ff @(posedge clk or negedge n_reset)
	begin
		if(~n_reset)
			begin
				counter <= 0;
				send <= 0;
				data <=0;
			end
		else
			if(~ss_active)
				begin
					counter <= 3'b000;
					send <= send_buffer;
				end
			else
				begin
				//recieve
				if(sclk_rising)
					begin
						counter <= counter + 3'b001;
						data <= {data[6:0], mosi_data};
					end
				//send
				if(sclk_falling)
					begin
						send <= {send[6:0],1'b0};
					end
				end

	end

assign miso = send[7];

endmodule