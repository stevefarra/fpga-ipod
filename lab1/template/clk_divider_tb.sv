`timescale 1ns/1ns

`define SYS_CLK_FREQ 50000000
`define DO_FREQ 523
`define MI_FREQ 659
`define FA_FREQ 698
`define SO_FREQ 783

module clk_divider_tb();
    logic        sim_rst;
    logic [15:0] sim_half_num_clk_cycles;
    logic        sim_clk_in;
    logic        sim_clk_out;

    clk_divider
    dut
        (.rst                 (sim_rst),
         .half_num_clk_cycles (sim_half_num_clk_cycles),
         .clk_in              (sim_clk_in),
         .clk_out             (sim_clk_out));

    // 50 MHz clock has a period of 20 ns
    always
        begin
            sim_clk_in = 1'b0; #10;
            sim_clk_in = 1'b1; #10;
        end
    
    initial
        begin
            sim_rst = 1'b1; #20;
            sim_rst = 1'b0;

            // Do
            sim_half_num_clk_cycles[15:0] = (`SYS_CLK_FREQ/`DO_FREQ)/2;
            // Wait 3 clock cycles
            // Period is ~1.912 ms,
            // So 3 * 1.912 * 10^6 ~= 5736157 ns
            #5736157;
            $stop;
        end
endmodule