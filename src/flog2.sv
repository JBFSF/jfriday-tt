module flog2(
  input logic [3:0] ffs_i,
  output logic [3:0] mso_o
);
  assign mso_o = (ffs_i[3] == 1) ? 3 :
                 (ffs_i[2] == 1) ? 2 :
                 (ffs_i[1] == 1) ? 1 : 0;
endmodule
