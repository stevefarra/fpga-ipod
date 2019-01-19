module mux8
   #(parameter n=16)
    (input  logic [n-1:0] in1, in2, in3, in4, in5, in6, in7, in8
     input  logic [2:0] sel,
     output logic [n-1:0] out);

    always_comb
        case(sel)
            3'b000:  out = in1;
            3'b001:  out = in2;
            3'b010:  out = in3;
            3'b011:  out = in4;
            3'b100:  out = in5;
            3'b101:  out = in6;
            3'b110:  out = in7;
            3'b111:  out = in8;
            default: out = {n{1'b0}};
        endcase
endmodule