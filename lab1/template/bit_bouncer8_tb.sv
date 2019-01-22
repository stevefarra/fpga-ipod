module bit_bouncer8_tb();
    logic       sim_clk;
    logic [7:0] sim_bits;

    bit_bouncer8
    dut
        (.clk  (sim_clk),
         .bits (sim_bits[7:0]));

    always begin
        sim_clk = 1'b0; #1;
        sim_clk = 1'b1; #1;
    end

    initial begin
        #2;
        assert (sim_bits[7:0] === 8'b00000001)
        else   $error("Bit 0 failed on the ascent.");
        #2;
        assert (sim_bits[7:0] === 8'b00000010)
        else   $error("Bit 1 failed on the ascent.");
        #2;
        assert (sim_bits[7:0] === 8'b00000100)
        else   $error("Bit 2 failed on the ascent.");
        #2;
        assert (sim_bits[7:0] === 8'b00001000)
        else   $error("Bit 3 failed on the ascent.");
        #2;
        assert (sim_bits[7:0] === 8'b00010000)
        else   $error("Bit 4 failed on the ascent.");
        #2;
        assert (sim_bits[7:0] === 8'b00100000)
        else   $error("Bit 5 failed on the ascent.");
        #2;
        assert (sim_bits[7:0] === 8'b01000000)
        else   $error("Bit 6 failed on the ascent.");
        #2;
        assert (sim_bits[7:0] === 8'b10000000)
        else   $error("Bit 7 failed on the ascent.");
        #2;
        assert (sim_bits[7:0] === 8'b01000000)
        else   $error("Bit 6 failed on the descent.");
        #2;
        assert (sim_bits[7:0] === 8'b00100000)
        else   $error("Bit 5 failed on the descent.");
        #2;
        assert (sim_bits[7:0] === 8'b00010000)
        else   $error("Bit 4 failed on the descent.");
        #2;
        assert (sim_bits[7:0] === 8'b00001000)
        else   $error("Bit 3 failed on the descent.");
        #2;
        assert (sim_bits[7:0] === 8'b00000100)
        else   $error("Bit 2 failed on the descent.");
        #2;
        assert (sim_bits[7:0] === 8'b00000010)
        else   $error("Bit 1 failed on the descent.");
        #2;
        assert (sim_bits[7:0] === 8'b00000001)
        else   $error("Bit 0 failed on the ascent.");
        #2;
        assert (sim_bits[7:0] === 8'b00000010)
        else   $error("Bit 1 failed on the re-ascent.");
        $stop;
    end
endmodule