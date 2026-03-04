// Copyright (c) 2024 Ethan Sifferman.
// All rights reserved. Distribution Prohibited.

module alu (
    input  logic clk,
    input  logic rst,
    input  logic [7:0] a_i,
    input  logic [7:0] b_i,
    input  logic [3:0] operation_i,
    output logic [7:0] y_o
);
    logic [7:0] flog2_o;
    logic [7:0] sqrt_o;

    flog2 flog2(
        .ffs_i(a_i),
        .mso_o(flog2_o)
    );

    sqrt sqrt(
        .sqrt_i(a_i),
        .sqrt_o(sqrt_o)
    );

    always @(posedge clk) begin
        if (rst) begin
            y_o = '0;
        end else begin
            y_o = (operation_i == 4'b0001) ? a_i + b_i :
                    (operation_i == 4'b0010) ? a_i - b_i :
                    (operation_i == 4'b0100) ? flog2_o :
                    (operation_i == 4'b1000) ? sqrt_o : 0;
        end
    end 
endmodule
