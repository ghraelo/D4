// D4
// Hamming decoder table (8/4)
/*
   author: jc21g13
   last revision: 25 Feb' 15
*/
module hamming_decoder_table (input logic[7:0] codeword, output logic[3:0] msg);

always_comb
 begin
  case(codeword)
    8'b00010101:
      msg = 4'b0000;
    8'b00000010:
      msg = 4'b0001;
    8'b01001001:
      msg = 4'b0010;
    8'b01011110:
      msg = 4'b0011;
    8'b01100100:
      msg = 4'b0100;
    8'b01110011:
      msg = 4'b0101;
    8'b00111000:
      msg = 4'b0110;
    8'b00101111:
      msg = 4'b0111;
    8'b11010000:
      msg = 4'b1000;
    8'b11000111:
      msg = 4'b1001;
    8'b10001100:
      msg = 4'b1010;
    8'b10011011:
      msg = 4'b1011;
    8'b10100001:
      msg = 4'b1100;
    8'b10110110:
      msg = 4'b1101;
    8'b11111101:
      msg = 4'b1110;
    8'b11101010:
      msg = 4'b1111;   
    endcase;  
 end

endmodule