// D4
// DAC SPI interface
/*
   author: jc21g13
   last revision: 23 Feb' 15
*/

module dac_interface(input logic[7:0] data, input logic start, sclk, n_reset, dac_miso, output logic done, dac_mosi, dac_cs);

 typedef enum{idle, load, shift, finish} state_type;

 state_type present_state,next_state;

logic[$clog2(16):0] index,next_index;

logic r_load,r_shift;

logic[15:0] pdataout, data_to_write;

assign data_to_write = {4'b0111,data[7:0],4'b0000};

assign dac_mosi = pdataout[15];

shift_register #(.n(16)) regi (.pdatain(data_to_write), .clk(sclk), .n_reset(n_reset), .sdatain(dac_miso), .shift(r_shift), .load(r_load), .pdataout(pdataout));

 always_ff @(posedge sclk or negedge n_reset) 
 	begin
 	if(~n_reset) 
 		begin
 		present_state <= idle;
 		index <= 0;
 	end else 
 		begin
 		present_state <= next_state;
 		index <= next_index;
 	end
 end

always_comb
	begin
		//defaults
		dac_cs = 1'b1;
		r_load = 1'b0;
		r_shift = 1'b0;
		done = 1'b0;
		next_index = index;

		case(present_state)
			idle: 
				begin
					//wait for start signal to be asserted
					next_state = (start ? load : idle);
				end
			load:
				begin
					dac_cs = 1'b1;
					r_load = 1'b1;
					next_index = 0;
					next_state = shift;
				end
			shift:
				begin
					dac_cs = 1'b0;
					r_shift = 1'b1;
					next_index = index + 1;
					next_state = ((index < 15) ? shift : finish);
				end
			finish:
				begin
					done = 1'b1;
					next_state = idle;
				end
		endcase
	end
endmodule