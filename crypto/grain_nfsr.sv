// D1
// NFSR for Grain-128 stream cipher
/*
   author: jc21g13
   last revision: 28 Feb' 15
*/

module grain_nfsr (input logic clk,n_reset,shift,load,init,lfsr_in,ks_in,input logic[127:0] data_in, output logic[127:0] data);

assign nbit = lfsr_in ^ data[0] ^ data[26] ^ data[56] ^ data[91] ^ data[96] ^ (data[3]&data[67]) ^ (data[11]&data[13]) ^ (data[17]&data[18]) ^ (data[27]&data[59]) ^ (data[40]&data[48]) ^ (data[61]&data[65]) ^ (data[68]&data[84]);

always_ff @ (posedge clk or negedge n_reset)
	begin
		if(~n_reset)
			data <= 0;
		else if(shift)
			if(init)
				data[127:0] <= {ks_in^nbit,data[127:1]};
			else
				data[127:0] <= {nbit,data[127:1]};
		else if(load)
			data <= data_in;
	end


endmodule