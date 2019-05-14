module counter
    #(parameter n=16) 
     (input  logic         clk,
      input  logic         en,
      input  logic         rst,
      output logic [n-1:0] count);

    always_ff @(posedge clk)
        if      (rst) count = {n{1'b0}};
        else if (en)  count = count + 1;
endmodule