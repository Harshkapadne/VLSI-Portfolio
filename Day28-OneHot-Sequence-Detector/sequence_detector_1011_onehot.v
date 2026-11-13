
`timescale 1ns/1ps

module sequence_detector_1011_onehot (
    input wire clk,
    input wire rst,
    input wire serial_in,
    output wire detected
);

    // State declarations
    reg [4:0] state;
    reg [4:0] next_state;

    // One-Hot state encoding
    localparam [4:0] S0 = 5'b00001;
    localparam [4:0] S1 = 5'b00010;
    localparam [4:0] S2 = 5'b00100;
    localparam [4:0] S3 = 5'b01000;
    localparam [4:0] S4 = 5'b10000;

    // Block 1: Sequential state logic
    always @(posedge clk) begin
        if (rst)
            state <= S0;
        else
            state <= next_state;
    end

    // Block 2: Combinational next-state logic
    // Implement all 10 transitions.
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
