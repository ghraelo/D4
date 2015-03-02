// D4
// communications protocol input sequencer
/*
   author: jc21g13
   last revision: 23 Feb' 15

*/
module rx_sequencer #(parameter n=16)  (input logic rx_irq, spi_ready, clk, n_reset, enable, input logic[n/2-1:0] data_in, output logic[n-1:0] spi_data, output logic rx_begin,rx_ss);

 typedef enum{idle,begin_transfer,wait_complete,begin_transfer2,wait_complete2} state_type;

 state_type present_state,next_state;

 logic[n-1:0] spi_data,spi_next_data;

 always_ff @(posedge clk or negedge n_reset) 
 	begin
 	if(~n_reset) 
 		begin
 		present_state <= idle;
 		spi_data <= 16'b0;
 	end else 
 		begin
 		present_state <= next_state;
 		spi_data = spi_next_data;
 	end
 end

 always_comb
	begin
		//defaults
		spi_begin = 1'b0;
		rx_ss = 1'b1;
		spi_next_data = spi_data;

		case(present_state)
			idle:
				begin
					//wait for data indicator
					next_state = ((rx_irq && enable) ? begin_read : idle);
				end
			begin_transfer:
				begin
					rx_ss = 1'b0;
					spi_next_data = 16'b0;
					spi_begin = 1'b1;
					next_state = wait_complete;
				end
			wait_complete:
				begin
					rx_ss = 1'b0;
					next_state = (spi_ready ? begin_transfer2 : wait_complete);
				end
			begin_transfer2:
				begin
					rx_ss = 1'b0;
					spi_data = {16'hB000);
					spi_begin = 1'b1;
					next_state = wait_complete2;
				end
			wait_complete2:
				begin
					rx_ss = 1'b0;
					next_state = (spi_ready ? idle : wait_complete);
				end
		endcase
	end
endmodule