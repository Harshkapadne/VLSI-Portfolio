`timescale 1ns/1ps

module uart_receiver (
    input wire clk,
    input wire rst,
    input wire rx,
    input wire baud_tick,

    output reg [7:0] rx_data,
    output reg rx_valid,
    output reg framing_error,
    output wire busy
);

    reg [1:0] state;
    reg [1:0] next_state;

    reg [7:0] shift_reg;
    reg [2:0] bit_count;

    localparam [1:0] IDLE  = 2'b00;
    localparam [1:0] START = 2'b01;
    localparam [1:0] DATA  = 2'b10;
    localparam [1:0] STOP  = 2'b11;

    // Block 1: Sequential state logic
    always @(posedge clk) begin
        if (rst)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Block 2: Combinational next-state logic
    always @(*) begin

        next_state = IDLE;

        case(state)
            IDLE:
                if (rx)
                    next_state = IDLE;
                else
                    next_state = START;
                
            START:
                if (baud_tick && (rx == 1'b1))
                    next_state = IDLE;
                else if (baud_tick && (rx == 1'b0))
                    next_state = DATA;
                else
                    next_state = START;

            DATA:
                if (baud_tick && (bit_count == 3'd7))
                    next_state = STOP;
                else
                    next_state = DATA;

            STOP:
                if (baud_tick)
                    next_state = IDLE;
                else
                    next_state = STOP;

            default:
                next_state = IDLE;

        endcase

    end

    // Block 3: Shift register and bit counter
    always @(posedge clk) begin

        if (rst) begin
            shift_reg <= 8'b00000000;
            bit_count <= 3'b000;
        end
        else begin
            if ((state == IDLE) && !rx) begin
                shift_reg <= 8'b00000000;
                bit_count <= 3'b000;
            end
            else if ((state == DATA) && baud_tick) begin

                shift_reg <= {rx, shift_reg[7:1]};

                if (bit_count != 3'd7)
                    bit_count <= bit_count + 1'b1;

            end

        end

    end

    // Block 4: Receiver output logic
    always @(posedge clk) begin

        if (rst) begin
            rx_data       <= 8'b00000000;
            rx_valid      <= 1'b0;
            framing_error <= 1'b0;
        end
        else begin

            // Default: both status flags remain LOW
            rx_valid      <= 1'b0;
            framing_error <= 1'b0;

            if ((state == STOP) && baud_tick) begin

                if (rx == 1'b1) begin

                    // Valid stop bit: accept received byte
                    rx_data  <= shift_reg;
                    rx_valid <= 1'b1;

                end
                else begin

                    // Invalid stop bit: report framing error
                    framing_error <= 1'b1;

                end

            end
        end

    end

    assign busy = (state != IDLE);

endmodule