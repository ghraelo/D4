// D4
// Hamming encoder (8/4)
/*
   author: jc21g13
   last revision: 25 Feb' 15
*/
module hamming_encoder(output logic[15:0] codeword, input logic[7:0] msg);

hamming_encoder_table TOP (.codeword(codeword[15:8]),.msg(msg[7:4]));
hamming_encoder_table BOTTOM (.codeword(codeword[7:0]),.msg(msg[3:0]));

endmodule