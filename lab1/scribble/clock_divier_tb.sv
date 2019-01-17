module clock_divider_tb();
    logic       in_clk;
    logic [2:0] sel;
    logic       reset;
    logic       out_clk;

    clock_divider dut(in_clk, sel[2:0], reset, out_clk);

    initial begin
        sel = 3'b000; #10;
    end
endmodule