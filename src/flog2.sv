module flog2(
  input logic [7:0] ffs_i,
  output logic [7:0] mso_o
);
  assign mso_o = (ffs_i[7] == 1) ? 7 :
                 (ffs_i[6] == 1) ? 6 :
                 (ffs_i[5] == 1) ? 5 :
                 (ffs_i[4] == 1) ? 4 :
                 (ffs_i[3] == 1) ? 3 :
                 (ffs_i[2] == 1) ? 2 :
                 (ffs_i[1] == 1) ? 1 : 0;
endmodule
