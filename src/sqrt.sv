module sqrt(
    input logic [7:0] sqrt_i,
    output logic [7:0] sqrt_o
);
    logic [7:0] sqrt_table [256]; //properly reading in from the memh file helped by ChatGPT
    initial begin
        $readmemh ("sqrt.memh", sqrt_table);
    end
    assign sqrt_o = sqrt_table[sqrt_i];

endmodule
