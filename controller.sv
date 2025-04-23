package controller_fsm_pkg;
    typedef enum logic { RESET, TEST } state_t;
endpackage

module controller(
    input logic start, rst, clk, cout,
    output logic NbarT, ld
);

import controller_fsm_pkg::*;

state_t state, next_state;

always_ff @(posedge clk) begin
    if (rst) state <= RESET;
    else state <= next_state;
end

always_comb begin
    next_state = RESET;
    NbarT = 0;
    ld = 0;

    case (state)
        RESET : begin
            ld = 1;
            if (start) next_state = TEST;
            else next_state = RESET;
        end
        TEST : begin
            NbarT = 1;
            if (cout) next_state = RESET;
            else next_state = TEST;
        end
    endcase
end

endmodule