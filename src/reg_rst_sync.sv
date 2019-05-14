module reg_rst_sync 
   #(parameter n=1) 
    (input  logic         clk,
     input  logic         rst,
     input  logic [n-1:0] d,
     output logic [n-1:0] q);

    always_ff @(posedge clk, posedge rst)
        if   (rst) q = {n{1'b0}};
        else       q = d;
endmodule