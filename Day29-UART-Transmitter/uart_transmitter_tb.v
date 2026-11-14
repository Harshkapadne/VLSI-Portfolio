
`timescale 1ns/1ps

module uart_transmitter_tb;

    reg clk;
    reg rst;
    reg start;
    reg baud_tick;
    reg [7:0] data_in;

    wire tx;
    wire busy;
    wire tx_done;

    integer errors;

    // State declarations for verification
    localparam [1:0] IDLE  = 2'b00;
    localparam [1:0] START = 2'b01;
    localparam [1:0] DATA  = 2'b10;
    localparam [1:0] STOP  = 2'b11;

    uart_transmitter dut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .baud_tick(baud_tick),
        .data_in(data_in),
        .tx(tx),
        .busy(busy),
        .tx_done(tx_done)
    );

    // Generate clock
    always #5 clk = ~clk;


    // =====================================================
    // TASK 1: Check complete transmitter status
    // =====================================================
    // Check:
    // 1. Internal FSM state
    // 2. Serial output
    // 3. Busy output
    // 4. Transmission completion output
    // 5. Bit counter
    // 6. Shift register

    task check_status;
        input [1:0] expected_state;
        input expected_tx;
        input expected_busy;
        input expected_done;
        input [2:0] expected_count;
        input [7:0] expected_shift;
        input integer test_no;

        begin

            if (dut.state !== expected_state) begin
                $display("FAIL Test %0d: State, expected=%b, actual=%b",
                         test_no, expected_state, dut.state);
                errors = errors + 1;
            end
            else
                $display("PASS Test %0d: FSM state", test_no);

            if (tx !== expected_tx) begin
                $display("FAIL Test %0d: TX, expected=%b, actual=%b",
                         test_no, expected_tx, tx);
                errors = errors + 1;
            end
            else
                $display("PASS Test %0d: TX output", test_no);

            if (busy !== expected_busy) begin
                $display("FAIL Test %0d: Busy, expected=%b, actual=%b",
                         test_no, expected_busy, busy);
                errors = errors + 1;
            end
            else
                $display("PASS Test %0d: Busy output", test_no);

            if (tx_done !== expected_done) begin
                $display("FAIL Test %0d: tx_done, expected=%b, actual=%b",
                         test_no, expected_done, tx_done);
                errors = errors + 1;
            end
            else
                $display("PASS Test %0d: tx_done output", test_no);

            if (dut.bit_count !== expected_count) begin
                $display("FAIL Test %0d: Bit count, expected=%d, actual=%d",
                         test_no, expected_count, dut.bit_count);
                errors = errors + 1;
            end
            else
                $display("PASS Test %0d: Bit counter", test_no);

            if (dut.shift_reg !== expected_shift) begin
                $display("FAIL Test %0d: Shift register, expected=%b, actual=%b",
                         test_no, expected_shift, dut.shift_reg);
                errors = errors + 1;
            end
            else
                $display("PASS Test %0d: Shift register", test_no);

        end
    endtask


    // =====================================================
    // TASK 2: Start a UART transmission
    // =====================================================
    // Input:
    // payload = Parallel data to transmit.
    //
    // At the positive clock edge:
    // Expected state = START
    // Expected tx = 0 (Start bit)
    // Expected busy = 1
    // Expected tx_done = 0
    // Expected shift_reg = payload
    // Expected bit_count = 0

    task start_transmission;
        input [7:0] payload;
        input integer test_no;

        begin

            @(negedge clk);
            data_in = payload;
            start = 1'b1;
            baud_tick = 1'b0;

            @(posedge clk);
            #1;

            check_status(START, 1'b0, 1'b1, 1'b0,
                         3'd0, payload, test_no);

            // Deassert start after the accepting clock edge.
            @(negedge clk);
            start = 1'b0;

        end
    endtask


    // =====================================================
    // TASK 3: Apply one baud tick and verify transmission
    // =====================================================
    // expected_tx_before = Current bit before baud tick.
    // expected_state = Expected state after the tick.
    // expected_tx_after = TX after state/register update.
    // expected_busy = Expected busy status.
    // expected_done = Expected completion pulse.
    // expected_count = Expected bit counter.
    // expected_shift = Expected shift register value.

    task baud_step;
        input expected_tx_before;
        input [1:0] expected_state;
        input expected_tx_after;
        input expected_busy;
        input expected_done;
        input [2:0] expected_count;
        input [7:0] expected_shift;
        input integer test_no;

        begin

            @(negedge clk);

            // Check current TX bit before baud tick.
            if (tx !== expected_tx_before) begin
                $display("FAIL Test %0d: TX before baud tick, expected=%b, actual=%b",
                         test_no, expected_tx_before, tx);
                errors = errors + 1;
            end
            else
                $display("PASS Test %0d: TX before baud tick", test_no);

            // Generate one baud tick.
            baud_tick = 1'b1;

            @(posedge clk);
            #1;

            // Verify state, outputs and datapath after the tick.
            check_status(expected_state, expected_tx_after,
                         expected_busy, expected_done,
                         expected_count, expected_shift, test_no);

            // Deassert baud tick.
            @(negedge clk);
            baud_tick = 1'b0;

        end
    endtask


    // =====================================================
    // TASK 4: Transmit and verify a complete UART frame
    // =====================================================
    // Frame structure:
    // Idle = 1
    // Start = 0
    // Data = 8 bits, LSB first
    // Stop = 1
    //
    // Checks all eight data bits, counter progression,
    // shift register operation, busy and tx_done.

    task transmit_frame;
        input [7:0] payload;
        input integer test_no;

        reg [7:0] expected_shift;
        reg current_bit;
        integer i;

        begin

            // Start frame and load parallel data.
            start_transmission(payload, test_no);

            // START bit duration:
            // Before tick: tx = 0.
            // After tick: FSM enters DATA and D0 appears.
            baud_step(1'b0, DATA, payload[0],
                      1'b1, 1'b0, 3'd0, payload, test_no);

            expected_shift = payload;

            // Transmit data bits D0 through D6.
            // Each baud tick shifts the next bit into bit 0.
            for (i = 0; i < 7; i = i + 1) begin

                current_bit = expected_shift[0];
                expected_shift = {1'b0, expected_shift[7:1]};

                baud_step(current_bit, DATA, expected_shift[0],
                          1'b1, 1'b0, i + 1,
                          expected_shift, test_no);

            end

            // Transmit final data bit D7.
            // Counter is already 7.
            // Next baud tick moves FSM to STOP.
            current_bit = expected_shift[0];

            baud_step(current_bit, STOP, 1'b1,
                      1'b1, 1'b0, 3'd7,
                      expected_shift, test_no);

            // STOP bit duration:
            // Before tick: tx = 1.
            // After tick: return to IDLE.
            // tx_done becomes HIGH for one clock cycle.
            baud_step(1'b1, IDLE, 1'b1,
                      1'b0, 1'b1, 3'd7,
                      expected_shift, test_no);

            // Verify tx_done returns LOW on the next system clock.
            @(posedge clk);
            #1;

            check_status(IDLE, 1'b1, 1'b0, 1'b0,
                         3'd7, expected_shift, test_no);

        end
    endtask


    // =====================================================
    // MAIN TEST SEQUENCE
    // =====================================================

    initial begin

        $dumpfile("uart_transmitter.vcd");
        $dumpvars(0, uart_transmitter_tb);

        clk = 0;
        rst = 1;
        start = 0;
        baud_tick = 0;
        data_in = 8'b00000000;
        errors = 0;


        // =================================================
        // TEST 1: Synchronous reset
        // =================================================
        // Assert reset before the first positive clock edge.
        // Expected state = IDLE.
        // Expected tx = 1.
        // Expected busy = 0.
        // Expected tx_done = 0.
        // Expected shift_reg = 0.
        // Expected bit_count = 0.

        @(posedge clk);
        #1;

        check_status(IDLE, 1'b1, 1'b0, 1'b0,
                     3'd0, 8'b00000000, 1);

        @(negedge clk);
        rst = 1'b0;


        // =================================================
        // TEST 2: Idle transmitter operation
        // =================================================
        // Keep start = 0 and baud_tick = 0.
        // Wait for one positive clock edge.
        //
        // Expected state = IDLE.
        // Expected tx = 1.
        // Expected busy = 0.
        // Expected tx_done = 0.

        @(posedge clk);
        #1;

        check_status(IDLE, 1'b1, 1'b0, 1'b0,
                     3'd0, 8'b00000000, 2);


        // =================================================
        // TEST 3: Transmit first data byte 8'hA5
        // =================================================
        // Payload = 8'b10100101.
        //
        // UART LSB-first transmission:
        // D0 = 1
        // D1 = 0
        // D2 = 1
        // D3 = 0
        // D4 = 0
        // D5 = 1
        // D6 = 0
        // D7 = 1
        //
        // Verify START, all eight DATA bits, STOP,
        // busy behavior, counter progression and tx_done.

        transmit_frame(8'hA5, 3);


        // =================================================
        // TEST 4: Transmit second data byte 8'h3C
        // =================================================
        // Payload = 8'b00111100.
        //
        // UART LSB-first transmission:
        // D0 = 0
        // D1 = 0
        // D2 = 1
        // D3 = 1
        // D4 = 1
        // D5 = 1
        // D6 = 0
        // D7 = 0
        //
        // This checks that a new byte can be loaded
        // correctly after the previous transmission completes.

        transmit_frame(8'h3C, 4);


        // =================================================
        // TEST 5: Ignore start request while transmitter
        //         is busy
        // =================================================
        // Start transmission with payload 8'h96.
        // Enter START and then DATA.
        //
        // While in DATA:
        // Assert start = 1.
        // Change data_in to 8'h3C.
        // Keep baud_tick = 0.
        //
        // Expected:
        // State remains DATA.
        // shift_reg remains 8'h96.
        // bit_count remains 0.
        // tx continues transmitting original D0.
        // busy remains 1.
        // tx_done remains 0.

        start_transmission(8'h96, 5);

        // Complete START bit and enter DATA.
        baud_step(1'b0, DATA, 1'b0,
                  1'b1, 1'b0, 3'd0,
                  8'h96, 5);

        @(negedge clk);
        start = 1'b1;
        data_in = 8'h3C;
        baud_tick = 1'b0;

        @(posedge clk);
        #1;

        check_status(DATA, 1'b0, 1'b1, 1'b0,
                     3'd0, 8'h96, 5);

        // =================================================
        // TEST 6: Reset during active transmission
        // =================================================
        // Current state = DATA.
        // Current shift_reg = 8'h96.
        //
        // Assert synchronous reset at negative clock edge.
        //
        // BEFORE next positive edge:
        // State remains DATA.
        // busy remains HIGH.
        // tx continues showing current data bit.
        //
        // AFTER next positive edge:
        // State = IDLE.
        // shift_reg = 0.
        // bit_count = 0.
        // tx = 1.
        // busy = 0.
        // tx_done = 0.

        @(negedge clk);
        start = 1'b0;
        rst = 1'b1;

        // Check synchronous reset has not acted yet.
        #1;

        check_status(DATA, 1'b0, 1'b1, 1'b0,
                     3'd0, 8'h96, 6);

        @(posedge clk);
        #1;

        check_status(IDLE, 1'b1, 1'b0, 1'b0,
                     3'd0, 8'b00000000, 6);

        @(negedge clk);
        rst = 1'b0;


        // =================================================
        // FINAL VERIFICATION RESULT
        // =================================================

        if (errors == 0)
            $display("ALL TESTS PASSED");
        else
            $display("TESTS FAILED: %0d errors", errors);

        $finish;

    end

endmodule