// D4
// LED adaptor
/*
   author: jc21g13
   last revision: 01 Mar' 15
*/

module led_adaptor(input logic[7:0] data, output logic led0,led1,led2,led3,led4,led5,led6,led7);

always_comb
	begin
		led0 = data[0];
		led1 = data[1];
		led2 = data[2];
		led3 = data[3];
		led4 = data[4];
		led5 = data[5];
		led6 = data[6];
		led7 = data[7];
	end
endmodule