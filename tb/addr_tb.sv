module addr_tb();
    logic        sim_clk;
    logic        sim_rst;
    logic        sim_en;

    logic [7:0]  sim_key;

    logic        sim_playpause;
    logic        sim_dir;

    logic [22:0] sim_addr;

    `define  PLAY 8'h45; // E
    `define PAUSE 8'h44; // D
    `define   FWD 8'h46; // F
    `define   REV 8'h42; // B

    kbd_fsm kbd_fsm_inst
        (.clk       (sim_clk),
         .rst       (sim_rst),
         .key       (sim_key),
         .dir       (sim_dir),
         .playpause (sim_playpause));


    addr_ctrl addr_ctrl_inst
        (.clk       (sim_clk),
         .rst       (sim_rst),
         .en        (sim_en),
         .playpause (sim_playpause),
         .dir       (sim_dir),
         .addr      (sim_addr));

    always begin
        sim_clk = 1'b0; #2;
        sim_clk = 1'b1; #2;
    end

    initial begin
         sim_en = 1'b1;
        sim_rst = 1'b1; #4;
        sim_rst = 1'b0;

        sim_key = `PAUSE; #12;
        sim_key = `PLAY;  #8;
        sim_key = `REV;   #20;
        sim_key = `PAUSE; #16;
        sim_key = `FWD;   #20;
        sim_key = `PLAY;  #30;
    end
endmodule