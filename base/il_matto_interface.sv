// D4
// Il Matto SPI interface
/*
   author: jc21g13
   last revision: 01 Mar' 15
*/

module il_matto_interface(input logic sclk, n_reset, im_mosi, im_cs, output logic done, im_miso, output logic[7:0] data);

 typedef enum{idle,shift, finish} state_type;

 state_type present_state,next_state;

logic[$clog2(8):0] index,next_index;

logic r_load,r_shift;

logic[7:0] data_to_write;

assign im_miso = data[7];
assign data_to_write = 8'b000000; //0

shift_register #(.n(8)) regi (.pdatain(data_to_write), .clk(sclk), .n_reset(n_reset), .sdatain(im_mosi), .shift(r_shift), .load(r_load), .pdataout(data));

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
		r_load = 1'b0;
		r_shift = 1'b0;
		done = 1'b0;
		next_index = index;

		case(present_state)
			idle: 
				begin
					//wait for chip select to be asserted
					next_index = 0;
					r_load = 1'b1;
					next_state = (~im_cs ? shift : idle);
				end
			shift:
				begin
					r_shift = 1'b1;
					next_index = index + 1;
					next_state = ((index < 7) ? shift : finish);
				end
			finish:
				begin
					done = 1'b1;
					next_state = idle;
				end
		endcase
	end
endmodule