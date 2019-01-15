module test_top_tb();

logic a, b, c, y;

// instantiate device under test
test_top dut(a, b, c, y);

// apply inputs one at a time
initial begin
a = 0; b = 0; c = 0; #10;
c = 1; #10;
b = 1; c = 0; #10;
c = 1; #10;
a = 1; b = 0; c = 0; #10;
c = 1; #10;
b = 1; c = 0; #10;
c = 1; #10;
end

endmodule