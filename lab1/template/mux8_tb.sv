module mux8_tb();
   
    logic [2:0]  sim_sel;
    logic [15:0] sim_out;

    parameter doe =  16'hbab9;
    parameter re =   16'ha65d;
    parameter mi =   16'h9430;
    parameter fa =   16'h8be8;
    parameter so =   16'h7cb8;
    parameter la =   16'h6ef9;
    parameter ti =   16'h62f1;
    parameter doe2 = 16'h5d5c;

    mux8
    dut
        (.in1 (doe),
        .in2 (re),
        .in3 (mi),
        .in4 (fa),
        .in5 (so),
        .in6 (la),
        .in7 (ti),
        .in8 (doe2),
        .sel (sim_sel),
        .out (sim_out));

    initial begin
        sim_sel = 3'b000;
        assert (sim_out[15:0] === doe)
        else   $error(""Doe" select failed."); 
        #1;
        sim_sel = 3'b101;
        assert (sim_out[15:0] === so)
        else   $error(""So" select failed."); 
        #1;
        sim_sel = 3'b101;
        assert (sim_out[15:0] === la)
        else   $error(""La" select failed."); 
        #1;
        sim_sel = 3'b011;
        assert (sim_out[15:0] === fa)
        else   $error(""Fa" select failed."); 
        #1;
        sim_sel = 3'b111;
        assert (sim_out[15:0] === doe2)
        else   $error(""Doe2" select failed."); 
        #1;
        sim_sel = 3'b001;
        assert (sim_out[15:0] === re)
        else   $error(""Re" select failed."); 
        #1;
        sim_sel = 3'b010 
        assert (sim_out[15:0] === mi)
        else   $error(""Mi" select failed."); 
        #1;
        assert (sim_sel = 3'b110 === ti)
        else   $error(""Ti" select failed."); 
        end
endmodule