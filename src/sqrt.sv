module sqrt(
    input logic [3:0] sqrt_i,
    output logic [3:0] sqrt_o
);
    logic [3:0] sqrt_table [16];
    initial begin
        $readmemh ("../src/sqrt.memh", sqrt_table);
    end
    assign sqrt_o = sqrt_table[sqrt_i];

endmodule
