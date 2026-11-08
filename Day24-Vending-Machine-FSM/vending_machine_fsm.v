module vending_machine_fsm (
    input wire clk,
    input wire rst,
    input wire coin,
    output wire dispense
);

    // State declarations

    reg [1:0] state;
    reg [1:0] next_state;

    localparam IDLE     = 2'b00;
    localparam HAVE_5   = 2'b01;
    localparam DISPENSE = 2'b10;

    //Block 1 — Sequential logic - Stores the current state and updates it at the rising clock edge.
    always @(posedge clk) begin
        if (rst)
            state <= IDLE;
        else
            state <= next_state;
    end

    //Block 2 — Combinational logic - Calculates which state should come next.x
    always @(*) begin
        case(state)
            IDLE: begin
                if (coin)
                    next_state = HAVE_5;
                else
                    next_state = IDLE;
            end

            HAVE_5: begin
                if (coin)
                    next_state = DISPENSE;
                else
                    next_state = HAVE_5;
            end

            DISPENSE: 
                next_state = IDLE;
            
            default:
                next_state = IDLE;
        endcase
    end

    //Block 3 — Output logic - Generates output based only on the current state.
    assign dispense = (state == DISPENSE);

endmodule