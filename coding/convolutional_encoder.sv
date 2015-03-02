// D4
// convolutional encoder
/*
   author: jc21g13
   last revision: 25 Feb' 15
*/
module convolutional_encoder (input logic msg_in, clk, n_reset, shift, output logic n1,n2,zeroed);
//generators: 11111001,10100111
logic[7:0] register;

logic[7:0] gen1 = 8'b11111001;
logic[7:0] gen2 = 8'b10100111;

assign n1 = ^(gen1 & register);
assign n2 = ^(gen2 & register);
assign zeroed = |register;

 always_ff @(posedge clk or negedge n_reset) 
 	begin
 	if(~n_reset) 
 		begin
 		register <= 0;
 	end else 
 		begin
 		if(shift)
 			register <= {msg_in,register[7:1]};
 	end
 end
endmodule