module freq_ctrl_tb();
    logic        sim_speed_up;
    logic        sim_speed_down;
    logic        sim_speed_rst;
    logic [15:0] sim_half_num_clk_cycles;

    freq_ctrl dut
       (.speed_up            (sim_speed_up),
        .speed_down          (sim_speed_down),
        .speed_rst           (sim_speed_rst),
        .freq_base           (16'h2af8),
        .half_num_clk_cycles (sim_half_num_clk_cycles));

    task speed_up;
        input [4:0] num;
        for (int i = 0; i < num; i++) begin
            sim_speed_up = 1'b1; #1;
            sim_speed_up = 1'b0; #1;
        end
    endtask

    task speed_down;
        input [4:0] num;
        for (int i = 0; i < num; i++) begin
            sim_speed_down = 1'b1; #1;
            sim_speed_down = 1'b0; #1;
        end
    endtask

    task speed_rst;
        sim_speed_rst = 1'b1; #1;
        sim_speed_rst = 1'b0; #1;
    endtask

    initial begin
        speed_rst();
        speed_up(9);
        speed_down(2);
        speed_rst();
        speed_down(4);
        speed_up(2);
        speed_down(1);
    end
endmodule
