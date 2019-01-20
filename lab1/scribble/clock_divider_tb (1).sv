`timescale 1ns/1ps

module clock_divider_tb();
    logic       in_clk;
    logic [2:0] sel;
    logic       reset;
    logic       out_clk;

    clock_divider dut(in_clk, sel[2:0], reset, out_clk);

    always 
        begin
            in_clk = 1'b0; #10;
            in_clk = 1'b1; #10;
        end

    initial
        begin
            reset = 1'b1; #40;
            reset = 1'b0;
            sel = 3'b000; #100; 
        end
endmodule