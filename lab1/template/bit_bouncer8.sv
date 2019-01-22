module bit_bouncer8
    (input  logic       clk,
     output logic [7:0] bits);

    logic dir;

    always @(posedge clk)
        case({dir,bits[7:0]})
            9'b0_00000001: {dir,bits[7:0]} = 9'b0_00000010;
            9'b0_00000010: {dir,bits[7:0]} = 9'b0_00000100;
            9'b0_00000100: {dir,bits[7:0]} = 9'b0_00001000;
            9'b0_00001000: {dir,bits[7:0]} = 9'b0_00010000;
            9'b0_00010000: {dir,bits[7:0]} = 9'b0_00100000;
            9'b0_00100000: {dir,bits[7:0]} = 9'b0_01000000;
            9'b0_01000000: {dir,bits[7:0]} = 9'b0_10000000;
            9'b0_10000000: {dir,bits[7:0]} = 9'b1_01000000;
            9'b1_01000000: {dir,bits[7:0]} = 9'b1_00100000;
            9'b1_00100000: {dir,bits[7:0]} = 9'b1_00010000;
            9'b1_00010000: {dir,bits[7:0]} = 9'b1_00001000;
            9'b1_00001000: {dir,bits[7:0]} = 9'b1_00000100;
            9'b1_00000100: {dir,bits[7:0]} = 9'b1_00000010;
            9'b1_00000010: {dir,bits[7:0]} = 9'b0_00000001;
            default:       {dir,bits[7:0]} = 9'b0_00000001;
        endcase
endmodule