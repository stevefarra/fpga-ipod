module flash_fsm_tb();
    logic sim_clk;
    logic sim_rst;
    logic sim_start;
    logic sim_readdatavalid;
    logic sim_gen_addr;
    logic sim_read;

    flash_fsm dut(
        .clk           (sim_clk),
        .rst           (sim_rst),
        .start         (sim_start),
        .readdatavalid (sim_readdatavalid),
        .gen_addr      (sim_gen_addr),
        .read          (sim_read)
    );

    always begin
        sim_clk = 1'b0; #2;
        sim_clk = 1'b1; #2;
    end

    always begin
                          #20;
        sim_start = 1'b1; #4;
        sim_start = 1'b0;
    end

    always begin
                                  #64;
        sim_readdatavalid = 1'b1; #4;
        sim_readdatavalid = 1'b0;
    end
endmodule