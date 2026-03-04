module sqrt(
    input logic [7:0] sqrt_i,
    output logic [7:0] sqrt_o
);
    logic [7:0] sqrt_table [256];
    initial begin
        $readmemh ("../src/sqrt.memh", sqrt_table);
    end
    assign sqrt_o = sqrt_table[sqrt_i];

endmodule
