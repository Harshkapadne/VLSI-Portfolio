
`timescale 1ns/1ps

module uart_receiver_tb;

    reg clk;
    reg rst;
    reg rx;
    reg baud_tick;

    wire [7:0] rx_data;
    wire rx_valid;
    wire framing_error;
    wire busy;

    integer checks_passed;
    integer checks_failed;

    localparam [1:0] IDLE  = 2'b00;
    localparam [1:0] START = 2'b01;
    localparam [1:0] DATA  = 2'b10;
    localparam [1:0] STOP  = 2'b11;

    // DUT instantiation
    uart_receiver dut (
        .clk(clk),
        .rst(rst),
        .rx(rx),
        .baud_tick(baud_tick),
        .rx_data(rx_data),
        .rx_valid(rx_valid),
        .framing_error(framing_error),
        .busy(busy)
    );

    // 10 ns clock period
    always #5 clk = ~clk;


    // --------------------------------------------------
    // Task 1: Check all important receiver signals
    // --------------------------------------------------

    task check_all;

        input [1:0] expected_state;
        input [7:0] expected_data;
        input expected_valid;
        input expected_error;
        input expected_busy;
        input [7:0] expected_shift;
        input [2:0] expected_count;

        begin

            if ((dut.state !== expected_state) ||
                (rx_data !== expected_data) ||
                (rx_valid !== expected_valid) ||
                (framing_error !== expected_error) ||
                (busy !== expected_busy) ||
                (dut.shift_reg !== expected_shift) ||
                (dut.bit_count !== expected_count)) begin

                checks_failed = checks_failed + 1;

                $display("\nFAIL: Receiver check at time %0t", $time);

                $display("Expected:");
                $display("State=%b Data=%h Valid=%b Error=%b Busy=%b Shift=%h Count=%d",
                         expected_state, expected_data,
                         expected_valid, expected_error,
                         expected_busy, expected_shift,
                         expected_count);

                $display("Actual:");
                $display("State=%b Data=%h Valid=%b Error=%b Busy=%b Shift=%h Count=%d",
                         dut.state, rx_data,
                         rx_valid, framing_error,
                         busy, dut.shift_reg,
                         dut.bit_count);

            end
            else begin

                checks_passed = checks_passed + 1;

                $display("PASS: State=%b Data=%h Valid=%b Error=%b Busy=%b Shift=%h Count=%d",
                         dut.state, rx_data,
                         rx_valid, framing_error,
                         busy, dut.shift_reg,
                         dut.bit_count);

            end

        end

    endtask


    // --------------------------------------------------
    // Task 2: Generate one baud sampling pulse
    // --------------------------------------------------

    task sample_bit;

        input bit_value;

        begin

            @(negedge clk);

            rx = bit_value;
            baud_tick = 1'b1;

            @(posedge clk);
            #1;

            baud_tick = 1'b0;

        end

    endtask


    // --------------------------------------------------
    // Task 3: Receive a complete UART frame
    // --------------------------------------------------

    task receive_frame;

        input [7:0] received_byte;
        input stop_bit_value;
        input [7:0] previous_data;

        reg [7:0] expected_shift;
        reg [2:0] expected_count;
        reg [1:0] expected_state;

        integer k;

        begin

            $display("\nReceiving byte: %h", received_byte);

            // ------------------------------------------
            // Step 1: Detect the start bit
            // ------------------------------------------

            @(negedge clk);

            rx = 1'b0;
            baud_tick = 1'b0;

            @(posedge clk);
            #1;

            check_all(
                START,
                previous_data,
                1'b0,
                1'b0,
                1'b1,
                8'h00,
                3'd0
            );


            // ------------------------------------------
            // Step 2: Sample the start bit
            // ------------------------------------------

            sample_bit(1'b0);

            check_all(
                DATA,
                previous_data,
                1'b0,
                1'b0,
                1'b1,
                8'h00,
                3'd0
            );


            // ------------------------------------------
            // Step 3: Receive eight data bits
            // ------------------------------------------

            expected_shift = 8'h00;
            expected_count = 3'd0;

            // UART receives D0 first and D7 last.

            for (k = 0; k < 8; k = k + 1) begin

                // Calculate expected shift register value.

                expected_shift = {
                    received_byte[k],
                    expected_shift[7:1]
                };

                // First seven bits remain in DATA.
                // Eighth bit moves receiver into STOP.

                if (k == 7) begin
                    expected_state = STOP;
                    expected_count = 3'd7;
                end
                else begin
                    expected_state = DATA;
                    expected_count = k + 1;
                end

                // Sample the next serial data bit.

                sample_bit(received_byte[k]);

                // Verify state, counter and shift register.

                check_all(
                    expected_state,
                    previous_data,
                    1'b0,
                    1'b0,
                    1'b1,
                    expected_shift,
                    expected_count
                );

            end


            // ------------------------------------------
            // Step 4: Sample the stop bit
            // ------------------------------------------

            sample_bit(stop_bit_value);

            if (stop_bit_value == 1'b1) begin

                // Valid stop bit: accept the received byte.

                check_all(
                    IDLE,
                    received_byte,
                    1'b1,
                    1'b0,
                    1'b0,
                    received_byte,
                    3'd7
                );

                $display("Valid frame received: %h", received_byte);

            end
            else begin

                // Invalid stop bit: preserve previous data
                // and report a framing error.

                check_all(
                    IDLE,
                    previous_data,
                    1'b0,
                    1'b1,
                    1'b0,
                    received_byte,
                    3'd7
                );

                $display("Framing error correctly detected.");

            end


            // ------------------------------------------
            // Step 5: Check one-cycle status pulses
            // ------------------------------------------

            // Keep RX HIGH so receiver remains IDLE.

            @(negedge clk);

            rx = 1'b1;
            baud_tick = 1'b0;

            @(posedge clk);
            #1;

            // Both status flags should return LOW.

            if (stop_bit_value == 1'b1) begin

                check_all(
                    IDLE,
                    received_byte,
                    1'b0,
                    1'b0,
                    1'b0,
                    received_byte,
                    3'd7
                );

            end
            else begin

                check_all(
                    IDLE,
                    previous_data,
                    1'b0,
                    1'b0,
                    1'b0,
                    received_byte,
                    3'd7
                );

            end

        end

    endtask


    // --------------------------------------------------
    // Main test sequence
    // --------------------------------------------------

    initial begin

        clk = 1'b0;
        rst = 1'b1;
        rx = 1'b1;
        baud_tick = 1'b0;

        checks_passed = 0;
        checks_failed = 0;

        $dumpfile("uart_receiver.vcd");
        $dumpvars(0, uart_receiver_tb);


        // ==============================================
        // TEST 1: Reset operation
        // ==============================================

        $display("\n========== TEST 1: RESET ==========");

        repeat (2) @(posedge clk);
        #1;

        check_all(
            IDLE,
            8'h00,
            1'b0,
            1'b0,
            1'b0,
            8'h00,
            3'd0
        );

        @(negedge clk);
        rst = 1'b0;


        // ==============================================
        // TEST 2: Idle condition
        // ==============================================

        $display("\n========== TEST 2: IDLE ==========");

        repeat (3) @(posedge clk);
        #1;

        check_all(
            IDLE,
            8'h00,
            1'b0,
            1'b0,
            1'b0,
            8'h00,
            3'd0
        );


        // ==============================================
        // TEST 3: Receive 8'hA5
        // ==============================================

        $display("\n========== TEST 3: RECEIVE A5 ==========");

        receive_frame(8'hA5, 1'b1, 8'h00);


        // ==============================================
        // TEST 4: Receive 8'h3C
        // ==============================================

        $display("\n========== TEST 4: RECEIVE 3C ==========");

        receive_frame(8'h3C, 1'b1, 8'hA5);


        // ==============================================
        // TEST 5: Receive 8'h00
        // ==============================================

        $display("\n========== TEST 5: RECEIVE 00 ==========");

        receive_frame(8'h00, 1'b1, 8'h3C);


        // ==============================================
        // TEST 6: Receive 8'hFF
        // ==============================================

        $display("\n========== TEST 6: RECEIVE FF ==========");

        receive_frame(8'hFF, 1'b1, 8'h00);


        // ==============================================
        // TEST 7: False start detection
        // ==============================================

        $display("\n========== TEST 7: FALSE START ==========");

        // RX goes LOW and receiver detects a possible start.

        @(negedge clk);
        rx = 1'b0;

        @(posedge clk);
        #1;

        check_all(
            START,
            8'hFF,
            1'b0,
            1'b0,
            1'b1,
            8'h00,
            3'd0
        );

        // RX returns HIGH at the start sampling tick.
        // Receiver must reject this as a false start.

        sample_bit(1'b1);

        check_all(
            IDLE,
            8'hFF,
            1'b0,
            1'b0,
            1'b0,
            8'h00,
            3'd0
        );

        // Confirm receiver remains in IDLE.

        @(posedge clk);
        #1;

        check_all(
            IDLE,
            8'hFF,
            1'b0,
            1'b0,
            1'b0,
            8'h00,
            3'd0
        );


        // ==============================================
        // TEST 8: Framing error detection
        // ==============================================

        $display("\n========== TEST 8: FRAMING ERROR ==========");

        // Receive 8'h96, but send an INVALID LOW stop bit.
        // Previous valid rx_data must remain 8'hFF.

        receive_frame(8'h96, 1'b0, 8'hFF);


        // ==============================================
        // TEST 9: Reset during DATA reception
        // ==============================================

        $display("\n========== TEST 9: RESET DURING DATA ==========");

        // Detect a new start bit.

        @(negedge clk);
        rx = 1'b0;

        @(posedge clk);
        #1;

        check_all(
            START,
            8'hFF,
            1'b0,
            1'b0,
            1'b1,
            8'h00,
            3'd0
        );

        // Sample start bit.

        sample_bit(1'b0);

        check_all(
            DATA,
            8'hFF,
            1'b0,
            1'b0,
            1'b1,
            8'h00,
            3'd0
        );

        // Receive only the first three data bits: 1, 0, 1.

        sample_bit(1'b1);
        sample_bit(1'b0);
        sample_bit(1'b1);

        check_all(
            DATA,
            8'hFF,
            1'b0,
            1'b0,
            1'b1,
            8'b10100000,
            3'd3
        );

        // Apply synchronous reset during DATA reception.

        @(negedge clk);

        rst = 1'b1;
        rx = 1'b1;
        baud_tick = 1'b0;

        @(posedge clk);
        #1;

        check_all(
            IDLE,
            8'h00,
            1'b0,
            1'b0,
            1'b0,
            8'h00,
            3'd0
        );

        @(negedge clk);
        rst = 1'b0;


        // ==============================================
        // FINAL VERIFICATION SUMMARY
        // ==============================================

        $display("\n====================================");
        $display("       VERIFICATION SUMMARY");
        $display("====================================");

        $display("Checks Passed : %0d", checks_passed);
        $display("Checks Failed : %0d", checks_failed);

        $display("Total Checks  : %0d",
                 checks_passed + checks_failed);

        if (checks_failed == 0) begin

            $display("\nALL TESTS PASSED!");

        end
        else begin

            $display("\nTESTBENCH FAILED!");

        end

        $display("====================================\n");

        $finish;

    end

endmodule
