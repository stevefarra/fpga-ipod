module synchronizer_tb();
    logic sim_clk;
    logic sim_clk_async;
    logic sim_clk_sync;

    synchronizer dut
        (.clk       (sim_clk),
         .clk_async (sim_clk_async),
         .clk_sync  (sim_clk_sync));

    always begin
        sim_clk = 1'b0; #2;
        sim_clk = 1'b1; #2;
    end

    always begin
        sim_clk_async = 1'b0; #11;
        sim_clk_async = 1'b1; #11;
    end
endmodule