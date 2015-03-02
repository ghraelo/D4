// D4
// Hamming decoder logic (8/4)
/*
   author: jc21g13
   last revision: 25 Feb' 15
*/
module hamming_decoder_logic(input logic[7:0] codeword, output logic[3:0] msg, output logic errors);

logic a,b,c,d;
logic[3:0] syndrome;
logic[7:0] corr_word;

assign a = codeword[7] & codeword[5] & codeword[1] & codeword[0];
assign b = codeword[7] & codeword[3] & codeword[2] & codeword[1];
assign c = codeword[5] & codeword[4] & codeword[3] & codeword[1];
assign d = &codeword[7:0];
assign syndrome = {a,b,c,d};

hamming_decoder_table HDT (.codeword(corrword),.msg(msg));

always_comb
 begin
 	//if D=0, correctable error detected
 	if(syndrome == 4'b1111)
 	 corr_word = codeword;
 	else 
 		if(!syndrome[0])
	 		case (syndrome[3:1])
	 			4'b0000: corr_word = 8'b00000010 ^ codeword;
	 			4'b1000: corr_word = 8'b00001000 ^ codeword;
	 			4'b0100: corr_word = 8'b00100000 ^ codeword;
	 			4'b1100: corr_word = 8'b00010000 ^ codeword;
	 			4'b0010: corr_word = 8'b10000000 ^ codeword;
	 			4'b1010: corr_word = 8'b00000100 ^ codeword;
	 			4'b0110: corr_word = 8'b00000001 ^ codeword;
	 			4'b1110: corr_word = 8'b01000000 ^ codeword;
	 		endcase
 		else
 		 begin
 			corr_word = codeword;
 			errors = 1;
 		 end
 end

endmodule