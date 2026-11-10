`timescale 1ns/1ps

module sequence_detector_1011 (
    input wire clk,
    input wire rst,
    input wire serial_in,
    output wire detected
);

    // State declarations
    reg [1:0] state;
    reg [1:0] next_state;

    // State encoding
    localparam [1:0] S0 = 2'b00;
    localparam [1:0] S1 = 2'b01;
    localparam [1:0] S2 = 2'b10;
    localparam [1:0] S3 = 2'b11;

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
                    next_state = S1;
                else
                    next_state = S2;
            
            default:
                next_state = S0;
            
        endcase
    end

    // Block 3: Mealy output logic
    assign detected = (state == S3) && serial_in;

endmodule