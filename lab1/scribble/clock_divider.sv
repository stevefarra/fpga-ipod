// System clock: 50 MHz
// 50*10^6 is 26 bits, +1 for sign bit
// Frequencies are given in case statement

`timescale 1ns/1ps

module clock_divider(input  logic       in_clk,
                     input  logic [2:0] sel,
                     input  logic       reset,
                     output logic       out_clk);

    logic [26:0] inc;
    logic [26:0] count;
    logic [26:0] new_count;

    always_comb
        case({count[26],sel})
            4'b0_000: inc = 523  - 50000000;
            4'b0_001: inc = 587  - 50000000;
            4'b0_010: inc = 659  - 50000000;
            4'b0_011: inc = 698  - 50000000;
            4'b0_100: inc = 783  - 50000000;
            4'b0_101: inc = 880  - 50000000;
            4'b0_110: inc = 987  - 50000000;
            4'b0_111: inc = 1046 - 50000000;
            4'b1_000: inc = 523;
            4'b1_001: inc = 587;
            4'b1_010: inc = 659;
            4'b1_011: inc = 698;
            4'b1_100: inc = 783;
            4'b1_101: inc = 880;
            4'b1_110: inc = 987;
            4'b1_111: inc = 1046;
            default:  inc = 27'b0;
        endcase

    assign new_count = count + inc;

    always_ff @(posedge in_clk)
        if (reset) count <= 26'b0;
        else       count <= new_count;

    assign out_clk = ~count[26];
endmodule