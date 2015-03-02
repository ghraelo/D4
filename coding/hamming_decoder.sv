// D4
// Hamming decoder (8/4)
/*
   author: jc21g13
   last revision: 25 Feb' 15
*/
module hamming_decoder(input logic[15:0] codeword, output logic[7:0] msg, output logic errors);

logic top_e,bottom_e;

assign errors = top_e | bottom_e;

hamming_decoder_logic TOP (.codeword(codeword[15:8]), .msg(msg[7:4]), .errors(top_e));
hamming_decoder_logic BOTTOM (.codeword(codeword[7:0]), .msg(msg[3:0]), .errors(top_e));

endmodule