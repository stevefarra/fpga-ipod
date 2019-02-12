module freq_ctrl
   (input  logic        speed_up,
    input  logic        speed_down,
    input  logic        speed_rst,
    input  logic [15:0] freq_base,
    output logic [15:0] half_num_clk_cycles);

    logic [31:0] calc_half_num_clk_cycles;

    logic [15:0] freq_new;
    logic [12:0] inc_counter;
    logic [12:0] dec_counter;

    `define SYS_CLK_FREQ_HALF 28'h17d7840
    `define       FREQ_CHANGE 8'h64

    always_ff @(posedge speed_up, posedge speed_rst) begin
        if   (speed_rst) inc_counter = 0;
        else             inc_counter = inc_counter + `FREQ_CHANGE;
    end

    always_ff @(posedge speed_down, posedge speed_rst) begin
        if   (speed_rst) dec_counter = 0;
        else             dec_counter = dec_counter + `FREQ_CHANGE;
    end

    assign freq_new = freq_base + inc_counter - dec_counter;

    assign calc_half_num_clk_cycles = `SYS_CLK_FREQ_HALF/freq_new;
    assign      half_num_clk_cycles = calc_half_num_clk_cycles[15:0];

endmodule