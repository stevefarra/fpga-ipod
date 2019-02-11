module flash_fsm(
    input  logic clk,
    input  logic rst,
    input  logic start,
    input  logic readdatavalid,
    output logic gen_addr,
    output logic read
    );

    logic [1:0]  state;

    parameter [1:0] IDLE = 2'b00;
    parameter [1:0] UPDATE_ADDR = 2'b01;
    parameter [1:0] FETCH_DATA = 2'b10;

    always_ff @(posedge clk)
        if (rst) state = IDLE;
        else
            case (state)
                       IDLE: if (start)         state = UPDATE_ADDR;
                UPDATE_ADDR:                    state = FETCH_DATA;
                 FETCH_DATA: if (readdatavalid) state = IDLE;
                    default:                    state = IDLE;
            endcase

    assign gen_addr = state[0];
    assign     read = state[1];
endmodule