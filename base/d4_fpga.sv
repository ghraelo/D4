// D4
// encapsulating module for FPGA segment of design
/*
   author: jc21g13
   last revision: 23 Feb' 15

*/
module d4_fpga(input logic dac_miso,n_reset, output logic tr_cs,tr_sclk,dac_mosi,dac_cs)

logic[7:0] data;
logic dac_start,dac_done;

dac_interface DAC (.data(data), .start(dac_start), .sclk(tr_sclk), .n_reset(n_reset), .dac_miso(dac_miso), .done(dac_done), .dac_mosi(dac_mosi), .dac_cs(dac_cs));

endmodule