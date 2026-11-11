
`timescale 1ns/1ps

module sequence_detector_1011_moore (
    input wire clk,
    input wire rst,
    input wire serial_in,
    output wire detected
);

    // State declarations
    reg [2:0] state;
    reg [2:0] next_state;

    // State encoding
    localparam [2:0] S0 = 3'b000;
    localparam [2:0] S1 = 3'b001;
    localparam [2:0] S2 = 3'b010;
    localparam [2:0] S3 = 3'b011;
    localparam [2:0] S4 = 3'b100;

    // Block 1: Sequential state logic
    always @(posedge clk) begin
        if (rst)
            state <= S0;
        else
            state <= next_state;
    end

    // Block 2: Combinational next-state logic
    always @(*) begin

        next_state = S0;

        case(state)
            S0:
                if (serial_in)
                    next_state = S1;
                else
                    next_state = S0;

            S1:
                if (serial_in)
                    next_state = S1;
                else
                    next_state = S2;
            
            S2:
                if (serial_in)
                    next_state = S3;
                else
                    next_state = S0;
            
            S3:
                if (serial_in)
                    next_state = S4;
                else
                    next_state = S2;
            
            S4:
                if (serial_in)
                    next_state = S1;
                else
                    next_state = S2;
            
            default:
                next_state = S0;
            
        endcase
    end

    // Block 3: Moore output logic
    assign detected = (state == S4);

endmodule