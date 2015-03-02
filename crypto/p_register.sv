// D4
// implementation of interleaved modular multiplication from
//http://www.academia.edu/5281356/EFFICIENT_HARDWARE_ARCHITECTURES_FOR_MODULAR_MULTIPLICATION_ON_FPGAS
/*
   author: jc21g13
   last revision: 20 Feb' 15
*/

module p_register #(parameter n=1024) (input logic[n-1:0] X,Y,M, input logic[$clog2(n)-1:0] iter, input logic clk, n_reset, mult, sub, output logic[n-1:0] P);
 // P = X * Y (mod M)

 always_ff @(posedge clk or negedge n_reset)
	if(~n_reset)
		P <= 0;
	else
		if(mult)
			P <= 2 * P + X[iter-1] * Y;
		else if(sub)
			P <= P - M;
endmodule