
`timescale 1ns/1ps

module uart_transmitter (
    input wire clk,
    input wire rst,
    input wire start,
    input wire baud_tick,
    input wire [7:0] data_in,

    output wire tx,
    output wire busy,
    output reg tx_done
);

    // State declarations
    reg [1:0] state;
    reg [1:0] next_state;

    // Datapath declarations
    reg [7:0] shift_reg;
    reg [2:0] bit_count;

    // State encoding
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
                if (start)
                    next_state = START;
                else
                    next_state = IDLE;
                
            START:
                if (baud_tick)
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
            tx_done <= 1'b0;
        end
        else begin
            tx_done <= 1'b0;
            if ((state == IDLE) && start) begin
                shift_reg <= data_in;
                bit_count <= 3'b000;
            end
            else if ((state == DATA) && baud_tick) begin

                if (bit_count != 3'd7) begin
                    shift_reg <= {1'b0, shift_reg[7:1]};
                    bit_count <= bit_count + 1'b1;
                end

            end
            if ((state == STOP) && baud_tick)
                tx_done <= 1'b1;

        end

    end

    // Block 4: Serial output and status logic
    assign tx = (state == START) ? 1'b0 : (state == DATA)  ? shift_reg[0] : 1'b1;
    assign busy = (state != IDLE);

endmodule