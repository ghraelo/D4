// D4
// shift register for SPI
/*
   author: jc21g13
   last revision: 23 Feb' 15
*/
module shift_register #(parameter n=8) (input logic[n-1:0] pdatain,input logic clk,n_reset,sdatain,shift,load,output logic[n-1:0] pdataout);

 always_ff @(posedge clk or negedge n_reset) 
 	begin
 	if(~n_reset) 
 		begin
 		pdataout <= 0;
 	end else 
 		begin
 		if(load)
 			pdataout <= pdatain;
 		else if(shift)
 			pdataout <= {pdataout[n-2:0],sdatain};
 	end
 end
endmodule