// D4
// Hamming encoder table (8/4)
/*
   author: jc21g13
   last revision: 25 Feb' 15
*/
module hamming_encoder_table (input logic[3:0] msg, output logic[7:0] codeword);

always_comb
 begin
  case(msg)
  	4'b0000:
  		codeword = 8'b00010101;
  	4'b0001:
  		codeword = 8'b00000010;
  	4'b0010:
  		codeword = 8'b01001001;
  	4'b0011:
  		codeword = 8'b01011110;
  	4'b0100:
  		codeword = 8'b01100100;
  	4'b0101:
  		codeword = 8'b01110011;
  	4'b0110:
  		codeword = 8'b00111000;
  	4'b0111:
  		codeword = 8'b00101111;
  	4'b1000:
  		codeword = 8'b11010000;
  	4'b1001:
  		codeword = 8'b11000111;
  	4'b1010:
  		codeword = 8'b10001100;
  	4'b1011:
  		codeword = 8'b10011011;
  	4'b1100:
  		codeword = 8'b10100001;
  	4'b1101:
  		codeword = 8'b10110110;
  	4'b1110:
  		codeword = 8'b11111101;
  	4'b1111:
  		codeword = 8'b11101010; 
  	endcase;	
 end

endmodule