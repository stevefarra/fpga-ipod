module addr_ctrl
    (input  logic clk,
     input  logic rst,
     input  logic playpause,
     input  logic dir,
     output logic [22:0] addr);

    always_ff @(posedge clk) begin
        if (rst) 
            addr = 23'b0;
        else if (playpause)
            if (dir)
                if (addr[19:0] == 20'h7FFFF)
                    addr = 23'b0;
                else
                    addr = addr + 1'b1;
            else
                if (addr[19:0] == 20'b0)
                    addr = 20'h7FFFF;
                else
                    addr = addr - 1'b1;
    end
endmodule