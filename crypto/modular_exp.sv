// D1
// implementation of modular exponentiation
//http://en.wikipedia.org/wiki/Modular_exponentiation
/*
   author: jc21g13
   last revision: 22 Feb' 15
*/

module modular_exp #(parameter n=1024) (input logic[n-1:0] X,Y,M, input logic start, n_reset,clk, output logic[n-1:0] P, output logic done);
 // P = X^Y (mod M)


 typedef enum{idle,multiply, waiting, decrement, finish} state_type;

 state_type present_state,next_state;

 logic[$clog2(n)-1:0] iter,next_iter;
 logic in_start,in_done;
 logic[n-1:0] Q, next_P;

 modular_multiplier #(.n(n)) mult (.X(P), .Y(X), .M(M), .start(in_start), .n_reset(n_reset), .clk(clk), .P(Q), .done(in_done));

 always_ff @(posedge clk or negedge n_reset) 
 	begin
 	if(~n_reset) 
 		begin
 		present_state <= idle;
 		iter <= 0;
 	end else 
 		begin
		P <= next_P;
 		present_state <= next_state;
 		iter <= next_iter;
 	end
 end

 always_comb
	begin
		//defaults
		done = 1'b0;
		in_start = 1'b0;
		next_P = P;
		next_iter = iter;
		case(present_state)
			idle: 
				begin			
					next_P = 1;
					next_iter = 1;
					next_state = (start ? multiply: idle);
				end
			multiply:
				begin
					in_start = 1'b1;
					next_state = waiting;
				end
			waiting:
				begin
					next_state = (in_done ? decrement : waiting);
				end
			decrement:
				begin
					next_P = Q;
					next_iter = iter + 1;
					in_start = 1'b1;
					next_state = ((iter <= Y) ? multiply: finish);
				end
			finish:
				begin
					done = 1'b1;
					next_state = (start ? idle: finish);
				end
		endcase
	end
endmodule