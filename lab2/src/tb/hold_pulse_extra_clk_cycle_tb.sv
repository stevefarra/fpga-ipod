module hold_pulse_extra_clk_cycle_tb();
    logic sim_clk;
    logic sim_pulse;
    logic sim_held_pulse;

    hold_pulse_extra_clk_cycle dut(
        .clk        (sim_clk),
        .pulse      (sim_pulse),
        .held_pulse (sim_held_pulse)
    );

    always begin
        sim_clk = 1'b0; #2;
        sim_clk = 1'b1; #2;
    end

    initial begin
        sim_pulse = 1'b0; #4;
        sim_pulse = 1'b1; #4;
        sim_pulse = 1'b0; #16;
        sim_pulse = 1'b1; #4;
        sim_pulse = 1'b0;
    end
endmodule
