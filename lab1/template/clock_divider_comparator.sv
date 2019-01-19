module clock_divider_comparator
    #(parameter n=16) 
     (input  logic [n-1:0] in1, in2,
      output logic         out);

    always_comb
        if (in1 >= in2) out = 1'b1;
        else out = 1'b0;
endmodule