module clk_divider
    (input  logic rst,
     input  logic [15:0] half_num_clk_cycles,
     input  logic clk_in,
     output logic clk_out);
    
    logic [15:0] curr_clk_cycle;
    logic        clk_en;

    counter 
    clk_counter
        (.clk   (clk_in),
         .rst   (rst | clk_en),
         .count (curr_clk_cycle));
    
    geq_comparator
    clk_comparator
        (.in1 (curr_clk_cycle),
         .in2 (half_num_clk_cycles),
         .out (clk_en));

    always_ff @(posedge clk_in)
        if      (rst)    clk_out = 1'b0;
        else if (clk_en) clk_out = ~clk_out;
endmodule
