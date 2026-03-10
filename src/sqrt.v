`default_nettype none

module sqrt (
    input  wire [3:0] sqrt_i,
    output reg  [3:0] sqrt_o
);

always @(*) begin
    case (sqrt_i)
        4'd0  : sqrt_o = 0;
        4'd1  : sqrt_o = 1;
        4'd2  : sqrt_o = 1;
        4'd3  : sqrt_o = 2;
        4'd4  : sqrt_o = 2;
        4'd5  : sqrt_o = 2;
        4'd6  : sqrt_o = 2;
        4'd7  : sqrt_o = 3;
        4'd8  : sqrt_o = 3;
        4'd9  : sqrt_o = 3;
        4'd10 : sqrt_o = 3;
        4'd11 : sqrt_o = 3;
        4'd12 : sqrt_o = 3;
        4'd13 : sqrt_o = 4;
        4'd14 : sqrt_o = 4;
        4'd15 : sqrt_o = 4;
        default: sqrt_o = 0;
    endcase
end

endmodule