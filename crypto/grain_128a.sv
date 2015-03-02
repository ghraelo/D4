// D1
// Grain-128 stream cipher
/*
   author: jc21g13
   last revision: 28 Feb' 15

   inputs:
   	* clk = clock
   	* n_reset = active low asynchronous reset
   	* initialise = initialise stream cipher
   	* enable = enable state machine
   	* IV = 96-bit initialisation vector
   	* key = 128-bit key
   outputs:
   	* ready = finished initialisation
   	* key_stream = next bit of key stream
*/

module grain_128a (input logic clk,n_reset, initialise, enable, input logic[95:0] IV, input logic[127:0] key, output logic key_stream, ready);

logic[127:0] lfsr_in, nfsr_in, lfsr_out, nfsr_out;
logic lfsr_shift, nfsr_shift, lfsr_load, nfsr_load, h_func,init;

assign lfsr_in[127:0] = {IV[95:0], {30{1'b1}}, 1'b0};
assign nfsr_in = key;

//shift registers
grain_lfsr LFSR (.clk(clk), .n_reset(n_reset), .shift(lfsr_shift), .init(init), .ks_in(key_stream), .load(lfsr_load), .data_in(lfsr_in), .data(lfsr_out));
grain_nfsr NFSR (.clk(clk), .n_reset(n_reset), .shift(nfsr_shift), .init(init), .ks_in(key_stream), .load(nfsr_load), .lfsr_in(lfsr_out[0]), .data_in(nfsr_in), .data(nfsr_out));

//h(x) boolean function
assign h_func = (nfsr_out[12] & lfsr_out[8]) ^ (lfsr_out[13] & lfsr_out[20]) ^ (nfsr_out[95] & lfsr_out[42]) ^ (lfsr_out[60] & lfsr_out[79]) ^ (nfsr_out[12] & nfsr_out[95] & lfsr_out[94]);

//y(x) pre-output stream
assign key_stream = h_func ^ lfsr_out[93] ^ nfsr_out[2] ^ nfsr_out[12] ^ nfsr_out[36] ^ nfsr_out[45] ^ nfsr_out[64] ^ nfsr_out[73] ^ nfsr_out[89];

//state machine
typedef enum{begin_init, warm_up, ready_to_stream, streaming} state_type;

state_type present_state,next_state;

logic[7:0] index,next_index;

always_ff @(posedge clk or negedge n_reset)
	begin
		if(~n_reset)
			begin
				present_state <= begin_init;
				index <= 0;
			end
		else
			begin
				present_state <= next_state;
				index <= next_index;
			end
	end

always_comb
	begin
		//defaults
		ready = 1'b0;
		lfsr_load = 1'b0;
		nfsr_load = 1'b0;
		lfsr_shift = 1'b0;
		nfsr_shift = 1'b0;
		init = 1'b0;
		next_index = index;

		case(present_state)
			begin_init:
				begin
					//load key and IV into registers
					nfsr_load = 1'b1;
					lfsr_load = 1'b1;

					next_state = warm_up;
				end

			warm_up:
				begin
					init = 1'b1;
					lfsr_shift = 1'b1;
					nfsr_shift = 1'b1;

					//clock 256 times
					if(index != 255)
						begin
							next_index = index + 1;
							next_state = warm_up;
						end
					else
						next_state = (initialise ? begin_init : ready_to_stream);
				end

			ready_to_stream:
				begin
					ready = 1'b1;
					if(enable)
						next_state = (initialise ? begin_init : streaming);
					else
						next_state = ready_to_stream;
				end

			streaming:
				begin
					lfsr_shift = 1'b1;
					nfsr_shift = 1'b1;
					if(enable)
						next_state = (initialise ? begin_init : streaming);
					else
						next_state = streaming;
				end
		endcase
	end

endmodule