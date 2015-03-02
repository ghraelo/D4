// D4
// SPI interface
/*
   author: jc21g13
   last revision: 23 Feb' 15
*/

module spi_interface #(parameter n=8) (input logic[n-1:0] pdatain, input logic miso, start, sclk, write, output logic mosi, done, output logic[n-1:0] pdataout);

 typedef enum{idle, load, shift, finish} state_type;

 state_type present_state,next_state;

logic[$clog2(n)-1:0] index,next_index;
logic r_shift,r_load;
logic[n-1:0] data;

shift_register #(.n(n)) regi (.pdatain(pdatain), .clk(sclk), .n_reset(n_reset), .sdatain(miso), .shift(r_shift), .load(r_load), .pdataout(pdataout));

assign mosi = pdataout[7]; //mosi is MSB of output of shift register

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
		done = 1'b0;
		r_load = 1'b0;
		r_shift = 1'b0;

		case(present_state)
			idle: 
				begin
					//wait for start signal to be high to begin transfer; set index to zero
					next_index = 0;
					if(start)
						if(write)
							next_state = load;
						else
							next_state = shift;
					else
						next_state = idle;
				end
			load:
				begin
					//load parallel data into shift register
					r_load = 1'b1;
					next_state = shift;
				end
			shift:
				begin
					//shift data
					r_shift = 1'b1;
					next_state = ((index <= 8) ? shift : finish);
				end
			finish:
				begin
					//assert 'done' to indicate parallel data ready to read
					done = 1'b1;
					next_state = idle;
				end
		endcase
	end
endmodule