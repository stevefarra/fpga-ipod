module flash_fsm
    (input  logic clk,
     input  logic rst,
     input  logic start,
     input  logic readdatavalid,
     output logic gen_addr,
     output logic read,
     output logic data_en);

    // {data_en, read, gen_addr}
    logic [2:0] state;

    parameter [2:0] IDLE = 3'b000;
    parameter [2:0] UPDATE_ADDR = 3'b001;
    parameter [2:0] READ_DATA = 3'b010;
    parameter [2:0] STORE_DATA = 3'b100;

    always_ff @(posedge clk)
        if (rst) state = IDLE;
        else
            case (state)
                       IDLE: if (start)         state = UPDATE_ADDR;
                UPDATE_ADDR:                    state = READ_DATA;
                  READ_DATA: if (readdatavalid) state = STORE_DATA;
                 STORE_DATA:                    state = IDLE;
                    default:                    state = IDLE;
            endcase

    assign gen_addr = state[0];
    assign     read = state[1];
    assign  data_en = state[2];
endmodule