module kbd_fsm
    (input  logic       clk,
     input  logic       rst,
     input  logic [7:0] key,
     output logic       playpause,
     output logic       dir);

    // {dir, playpause}
    logic [1:0] state;

    parameter [1:0]  PLAY_FWD = 2'b11;
    parameter [1:0] PAUSE_FWD = 2'b10;
    parameter [1:0]  PLAY_REV = 2'b01;
    parameter [1:0] PAUSE_REV = 2'b00;

    parameter [7:0]  PLAY = 8'h45; // E
    parameter [7:0] PAUSE = 8'h44; // D
    parameter [7:0]   FWD = 8'h46; // F
    parameter [7:0]   REV = 8'h42; // B

    always_ff @(posedge clk)
        if (rst)
            state = PLAY_FWD;
        else
            case (state)
                PLAY_FWD: if      (key == PAUSE) state = PAUSE_FWD;
                          else if (key == REV)   state = PLAY_REV;
                          else                   state = PLAY_FWD;

                PAUSE_FWD: if      (key == PLAY) state = PLAY_FWD;
                           else if (key == REV)  state = PAUSE_REV;
                           else                  state = PAUSE_FWD;

                PLAY_REV: if      (key == PAUSE) state = PAUSE_REV;
                          else if (key == FWD)   state = PLAY_FWD;
                          else                   state = PLAY_REV;

                PAUSE_REV: if      (key == PLAY) state = PLAY_REV;
                           else if (key == FWD)  state = PAUSE_FWD;
                           else                  state = PAUSE_REV;

                  default:                       state = PLAY_FWD;
            endcase

    assign playpause = state[0];
    assign       dir = state[1];
endmodule