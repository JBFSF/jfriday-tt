/*
 * Copyright (c) Jackson Friday
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_jfriday (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path
    input  wire       ena,      // always 1
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n (active low)
);

    wire rst = ~rst_n;

    // Unpack inputs
    wire [3:0] a_i         = ui_in[3:0];
    wire [3:0] b_i         = ui_in[7:4];
    wire [3:0] operation_i = uio_in[3:0];

    wire [3:0] y_o;

    wire [3:0] flog2_o;
    wire [3:0] sqrt_o;

    flog2 flog2_inst (
        .ffs_i(a_i),
        .mso_o(flog2_o)
    );

    sqrt sqrt_inst (
        .sqrt_i(a_i),
        .sqrt_o(sqrt_o)
    );

    reg [3:0] y_reg;

    always @(posedge clk) begin
        if (rst) begin
            y_reg <= 4'b0000;
        end else begin
            y_reg <= (operation_i == 4'b0001) ? a_i + b_i :
                     (operation_i == 4'b0010) ? a_i - b_i :
                     (operation_i == 4'b0100) ? flog2_o :
                     (operation_i == 4'b1000) ? sqrt_o :
                     4'b0000;
        end
    end

    assign y_o = y_reg;

    // Pack outputs
    assign uo_out[3:0] = y_o;
    assign uo_out[7:4] = 4'b0000;

    // No bidirectional IO used
    assign uio_out = 8'b00000000;
    assign uio_oe  = 8'b00000000;

    // Prevent unused warnings
    wire _unused = &{ena, uio_in[7:4], 1'b0};

endmodule
