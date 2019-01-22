`timescale 1ns/1ns

`define SYS_CLK_FREQ 50000000
`define DO_FREQ  523
`define MI_FREQ  659
`define FA_FREQ  698
`define SO_FREQ  783

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
    always begin
        sim_clk_in = 1'b0; #10;
        sim_clk_in = 1'b1; #10;
    end
    
    initial begin
        sim_rst = 1'b1; #20;
        sim_rst = 1'b0;

        // Do: 523 Hz
        sim_half_num_clk_cycles[15:0] = (`SYS_CLK_FREQ/`DO_FREQ)/2;
        // Wait 1 clock cycle.
        // Period is 1/523 s,
        // so wait (1/523) * 10^9 ~= 1912046 ns
        #1912046;

        // So: 783 Hz
        sim_half_num_clk_cycles[15:0] = (`SYS_CLK_FREQ/`SO_FREQ)/2;
        // Wait 2.75 clock cycles.
        // Period is 1/783 s,
        // so wait 2.75 * (1/783) * 10^9 ~= 3512133 ns
        #3512133;

        // Mi: 659 Hz
        sim_half_num_clk_cycles[15:0] = (`SYS_CLK_FREQ/`MI_FREQ)/2;
        // Wait 2.25 clock cycles.
        // Period is 1/659 s,
        // so wait 2.25 * (1/659) * 10^9 ~= 3414265 ns
        #3414265;

        // Fa: 698 Hz
        sim_half_num_clk_cycles[15:0] = (`SYS_CLK_FREQ/`FA_FREQ)/2;
        // Wait 1 clock cycle.
        // Period is 1/698 s,
        // so wait (1/698) * 10^9 ~= 1432665 ns
        #1432665;

        sim_rst = 1'b1;
        $stop;
    end
endmodule