module synchronizer
    (input  logic clk,
     input  logic clk_async,
     output logic clk_sync);

    logic a, b, c, d, e;

    reg_rst_sync #(1) reg1
        (.clk (clk_async),
         .rst (~clk_async & c),
         .d   (1'b1),
         .q   (a));

    reg_rst_sync #(1) reg2
        (.clk (clk),
         .rst (1'b0),
         .d   (a),
         .q   (b));

    reg_rst_sync #(1) reg3
        (.clk (clk),
         .rst (1'b0),
         .d   (b),
         .q   (c));

    reg_rst_sync #(1) reg4
        (.clk (clk),
         .rst (1'b0),
         .d   (c),
         .q   (d));

    assign clk_sync = c & ~d; 
endmodule