// D1
// implementation of interleaved modular multiplication from
//http://www.academia.edu/5281356/EFFICIENT_HARDWARE_ARCHITECTURES_FOR_MODULAR_MULTIPLICATION_ON_FPGAS
/*
   author: jc21g13
   last revision: 20 Feb' 15
*/

module modular_multiplier #(parameter n=1024) (input logic[n-1:0] X,Y,M,input logic start, n_reset,clk, output logic[n-1:0] P, output logic done);
 // P = X * Y (mod M)

 typedef enum{idle,op,decrement, subtract1, subtract2, finish} state_type;

 state_type present_state,next_state;

logic[$clog2(n)-1:0] iter,next_iter;
logic r_reset,r_mult,r_sub;

p_register #(.n(n)) REGI (.X(X), .Y(Y), .M(M), .iter(iter), .clk(clk), .n_reset(r_reset), .mult(r_mult), .sub(r_sub), .P(P));

 always_ff @(posedge clk or negedge n_reset) 
 	begin
 	if(~n_reset) 
 		begin
 		present_state <= idle;
 		iter <= 0;
 	end else 
 		begin
 		present_state <= next_state;
 		iter <= next_iter;
 	end
 end

always_comb
	begin
		//defaults
		done = 1'b0;
		r_reset = 1'b0;
		r_mult = 1'b0;
		r_sub = 1'b0;
		next_iter = iter;
		case(present_state)
			idle: 
				begin			
					r_reset = 1'b1;
					next_iter = {n{1'd1}};
					next_state = (start ? op: idle);
				end
			op:
				begin
					r_mult = 1'b1;	
					next_state = ((P >= M) ? subtract1 : subtract2);
				end
			subtract1:
				begin
					r_sub = 1'b1;
					next_state =  ((P >= M) ? subtract2 : decrement);
				end
			subtract2:
				begin
					r_sub = 1'b1;
					next_state = decrement;
				end
			decrement:
				begin
					next_iter = iter - 1;
					next_state = ((iter > 0) ? op: finish);
				end
			finish:
				begin
					done = 1'b1;
					next_state = (start ? idle: finish);
				end
		endcase
	end
endmodule