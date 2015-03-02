// D1
// LFSR for Grain-128 stream cipher
/*
   author: jc21g13
   last revision: 28 Feb' 15
*/

module grain_lfsr (input logic clk,n_reset,shift,load,init,ks_in,input logic[127:0] data_in, output logic[127:0] data);

assign lbit = data[0] ^ data[7] ^ data[38] ^ data[70] ^ data[81] ^ data[96];

	
always_ff @ (posedge clk or negedge n_reset)
	begin
		if(~n_reset)
			data <= 0;
		else if(shift)
			if(init)
				data[127:0] <= {ks_in^lbit,data[127:1]};
			else
				data[127:0] <= {lbit,data[127:1]};
		else if(load)
			data <= data_in;
	end


endmodule