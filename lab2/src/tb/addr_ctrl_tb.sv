module addr_ctrl_tb();
    logic sim_clk;
    logic sim_rst;
    logic sim_playpause;
    logic sim_dir;
    logic [22:0] sim_addr;

    addr_ctrl dut
        (.clk       (sim_clk),
         .rst       (sim_rst),
         .playpause (sim_playpause),
         .dir       (sim_dir),
         .addr      (sim_addr));

    always begin
        sim_clk = 1'b0; #2;
        sim_clk = 1'b1; #2;
    end

    initial begin
        sim_rst       = 1'b1; #4;
        sim_rst       = 1'b0; #4;
        sim_playpause = 1'b1;
        sim_dir       = 1'b1; #40;
        sim_playpause = 1'b0; #20;
        sim_dir       = 1'b0; #32;
        sim_playpause = 1'b1; #10;
        sim_dir       = 1'b1; #16;
        sim_rst       = 1'b1; #4;
        sim_rst       = 1'b0; #4;
        sim_dir       = 1'b0; #8;
        sim_playpause = 1'b0; #12;
        sim_dir       = 1'b1; #24;
        sim_playpause = 1'b1; #32;
    end
endmodule