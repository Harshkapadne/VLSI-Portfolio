`timescale 1ns/1ps

module traffic_light_fsm (
    input wire clk,
    input wire rst,
    input wire timer_done,

    output reg ns_red,
    output reg ns_yellow,
    output reg ns_green,

    output reg ew_red,
    output reg ew_yellow,
    output reg ew_green
);

    // State declarations
    reg [1:0] state;
    reg [1:0] next_state;

    // State encoding
    localparam [1:0] NS_GREEN  = 2'b00;
    localparam [1:0] NS_YELLOW = 2'b01;
    localparam [1:0] EW_GREEN  = 2'b10;
    localparam [1:0] EW_YELLOW = 2'b11;

    // Block 1: Sequential state logic
    always @(posedge clk) begin
        if (rst)
            state <= NS_GREEN;
        else
            state <= next_state;
    end

    // Block 2: Combinational next-state logic
    always @(*) begin
        next_state = NS_GREEN;
        case(state)
            NS_GREEN:
                if (timer_done)
                    next_state = NS_YELLOW;
                else
                    next_state = NS_GREEN;
                
            NS_YELLOW:
                if (timer_done)
                    next_state = EW_GREEN;
                else
                    next_state = NS_YELLOW;
            
            EW_GREEN:
                if (timer_done)
                    next_state = EW_YELLOW;
                else
                    next_state = EW_GREEN;
                
            EW_YELLOW:
                if (timer_done)
                    next_state = NS_GREEN;
                else
                    next_state = EW_YELLOW;
            

            default:
                next_state = NS_GREEN;
        endcase
    end

    // Block 3: Output logic
    always @(*) begin
    
        // Default output values
        ns_red    = 1'b0;
        ns_yellow = 1'b0;
        ns_green  = 1'b0;

        ew_red    = 1'b0;
        ew_yellow = 1'b0;
        ew_green  = 1'b0;

        case (state)

            NS_GREEN: begin
                ns_green  = 1'b1;
                ew_red    = 1'b1;
            end

            NS_YELLOW: begin
                ns_yellow = 1'b1;
                ew_red    = 1'b1;
            end

            EW_GREEN: begin
                ns_red    = 1'b1;
                ew_green  = 1'b1;
            end

            EW_YELLOW: begin
                ns_red    = 1'b1;
                ew_yellow = 1'b1;
            end

            default: begin
                ns_red    = 1'b0;
                ns_yellow = 1'b0;
                ns_green  = 1'b0;

                ew_red    = 1'b0;
                ew_yellow = 1'b0;
                ew_green  = 1'b0;
            end

        endcase
    end
endmodule