`default_nettype none
`timescale 1ns / 1ps

module tb ();

  // Dump waveform
  initial begin
    $dumpfile("tb.fst");
    $dumpvars(0, tb);
    #1;
  end

  // Core Tiny Tapeout signals
  reg clk;
  reg rst_n;
  reg ena;

  reg  [7:0] ui_in;
  reg  [7:0] uio_in;

  wire [7:0] uo_out;
  wire [7:0] uio_out;
  wire [7:0] uio_oe;

`ifdef GL_TEST
  wire VPWR = 1'b1;
  wire VGND = 1'b0;
`endif

  // Convenience aliases (makes cocotb easier)
  wire [3:0] a_i         = ui_in[3:0];
  wire [3:0] b_i         = ui_in[7:4];
  wire [3:0] operation_i = uio_in[3:0];
  wire [3:0] y_o         = uo_out[3:0];

  // Instantiate DUT
  tt_um_jfriday dut (

`ifdef GL_TEST
      .VPWR(VPWR),
      .VGND(VGND),
`endif

      .ui_in(ui_in),
      .uo_out(uo_out),
      .uio_in(uio_in),
      .uio_out(uio_out),
      .uio_oe(uio_oe),
      .ena(ena),
      .clk(clk),
      .rst_n(rst_n)
  );

endmodule
