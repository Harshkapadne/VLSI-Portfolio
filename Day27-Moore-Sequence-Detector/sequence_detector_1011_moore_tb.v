
`timescale 1ns/1ps

module sequence_detector_1011_moore_tb;

    reg clk;
    reg rst;
    reg serial_in;
    wire detected;

    integer errors;

    // State declarations for verification
    localparam [2:0] S0 = 3'b000;
    localparam [2:0] S1 = 3'b001;
    localparam [2:0] S2 = 3'b010;
    localparam [2:0] S3 = 3'b011;
    localparam [2:0] S4 = 3'b100;

    sequence_detector_1011_moore dut (
        .clk(clk),
        .rst(rst),
        .serial_in(serial_in),
        .detected(detected)
    );

    // Generate clock
    always #5 clk = ~clk;


    // =====================================================
    // TASK 1: Apply one input bit and verify the FSM
    // =====================================================
    // Inputs:
    // bit_value       = Serial input bit
    // expected_state  = Expected state after positive edge
    // expected_before = Expected detected before positive edge
    // expected_after  = Expected detected after positive edge
    // test_no         = Test identification number

    task apply_bit;
        input bit_value;
        input [2:0] expected_state;
        input expected_before;
        input expected_after;
        input integer test_no;

        begin
            @(negedge clk);
            serial_in = bit_value;
            #1;

            // Check Moore output BEFORE positive edge
            if (detected !== expected_before) begin
                $display("FAIL Test %0d: Output before edge, expected=%b, actual=%b",
                         test_no, expected_before, detected);
                errors = errors + 1;
            end
            else
                $display("PASS Test %0d: Output before edge", test_no);

            @(posedge clk);
            #1;

            // Check internal state AFTER positive edge
            if (dut.state !== expected_state) begin
                $display("FAIL Test %0d: State, expected=%b, actual=%b",
                         test_no, expected_state, dut.state);
                errors = errors + 1;
            end
            else
                $display("PASS Test %0d: Internal state", test_no);

            // Check Moore output AFTER positive edge
            if (detected !== expected_after) begin
                $display("FAIL Test %0d: Output after edge, expected=%b, actual=%b",
                         test_no, expected_after, detected);
                errors = errors + 1;
            end
            else
                $display("PASS Test %0d: Output after edge", test_no);

        end
    endtask


    // =====================================================
    // TASK 2: Apply synchronous reset
    // =====================================================
    // Assert reset at negative edge.
    // Expected state after positive edge = S0.
    // Expected detected output after positive edge = 0.

    task apply_reset;
        input integer test_no;

        begin
            @(negedge clk);
            rst = 1'b1;
            serial_in = 1'b0;

            @(posedge clk);
            #1;

            if (dut.state !== S0) begin
                $display("FAIL Test %0d: Reset state, expected=%b, actual=%b",
                         test_no, S0, dut.state);
                errors = errors + 1;
            end
            else
                $display("PASS Test %0d: Reset state", test_no);

            if (detected !== 1'b0) begin
                $display("FAIL Test %0d: Reset output, expected=0, actual=%b",
                         test_no, detected);
                errors = errors + 1;
            end
            else
                $display("PASS Test %0d: Reset output", test_no);

            // Deassert reset after the reset clock edge.
            rst = 1'b0;

        end
    endtask


    // =====================================================
    // MAIN TEST SEQUENCE
    // =====================================================

    initial begin

        $dumpfile("sequence_detector_1011_moore.vcd");
        $dumpvars(0, sequence_detector_1011_moore_tb);

        clk = 0;
        rst = 1;
        serial_in = 0;
        errors = 0;


        // =================================================
        // TEST 1: Synchronous Reset
        // =================================================
        // Reset is already HIGH.
        // Check after the first positive clock edge.
        // Expected state = S0
        // Expected detected = 0

        @(posedge clk);
        #1;

        if (dut.state !== S0) begin
            $display("FAIL Test 1: Reset state, expected=%b, actual=%b",
                     S0, dut.state);
            errors = errors + 1;
        end
        else
            $display("PASS Test 1: Reset state");

        if (detected !== 1'b0) begin
            $display("FAIL Test 1: Reset output, expected=0, actual=%b",
                     detected);
            errors = errors + 1;
        end
        else
            $display("PASS Test 1: Reset output");

        @(negedge clk);
        rst = 1'b0;


        // =================================================
        // TEST 2: Detect sequence 1011
        // =================================================
        // Input: 1, 0, 1, 1
        // Expected state progression:
        // S0 -> S1 -> S2 -> S3 -> S4
        //
        // Expected detected:
        // Before edge: 0, 0, 0, 0
        // After edge:  0, 0, 0, 1

        apply_bit(1'b1, S1, 1'b0, 1'b0, 2);
        apply_bit(1'b0, S2, 1'b0, 1'b0, 2);
        apply_bit(1'b1, S3, 1'b0, 1'b0, 2);
        apply_bit(1'b1, S4, 1'b0, 1'b1, 2);


        // =================================================
        // TEST 3: Input sequence 0000
        // =================================================
        // Reset before starting.
        // Input: 0, 0, 0, 0
        // Expected state: S0 for all four bits.
        // Expected detected before and after every edge = 0.

        apply_reset(3);

        apply_bit(1'b0, S0, 1'b0, 1'b0, 3);
        apply_bit(1'b0, S0, 1'b0, 1'b0, 3);
        apply_bit(1'b0, S0, 1'b0, 1'b0, 3);
        apply_bit(1'b0, S0, 1'b0, 1'b0, 3);


        // =================================================
        // TEST 4: Input sequence 1010
        // =================================================
        // Reset before starting.
        // Input: 1, 0, 1, 0
        // Expected state progression:
        // S0 -> S1 -> S2 -> S3 -> S2
        // Expected detected before and after every edge = 0.

        apply_reset(4);

        apply_bit(1'b1, S1, 1'b0, 1'b0, 4);
        apply_bit(1'b0, S2, 1'b0, 1'b0, 4);
        apply_bit(1'b1, S3, 1'b0, 1'b0, 4);
        apply_bit(1'b0, S2, 1'b0, 1'b0, 4);


        // =================================================
        // TEST 5: Overlapping sequence detection
        // =================================================
        // Reset before starting.
        // Input: 1, 0, 1, 1, 0, 1, 1
        //
        // Expected state progression:
        // S0 -> S1 -> S2 -> S3 -> S4 -> S2 -> S3 -> S4
        //
        // Expected detected AFTER positive edges:
        // 0, 0, 0, 1, 0, 0, 1
        //
        // Expected total detections = 2.
        //
        // Notice:
        // In S4, detected remains HIGH before the next edge.
        // It becomes LOW after the FSM transitions to S2 or S1.

        apply_reset(5);

        apply_bit(1'b1, S1, 1'b0, 1'b0, 5);
        apply_bit(1'b0, S2, 1'b0, 1'b0, 5);
        apply_bit(1'b1, S3, 1'b0, 1'b0, 5);
        apply_bit(1'b1, S4, 1'b0, 1'b1, 5);
        apply_bit(1'b0, S2, 1'b1, 1'b0, 5);
        apply_bit(1'b1, S3, 1'b0, 1'b0, 5);
        apply_bit(1'b1, S4, 1'b0, 1'b1, 5);


        // =================================================
        // TEST 6: Reset during partial sequence
        // =================================================
        // Reset before starting.
        // First apply: 1, 0
        // Expected states: S1 -> S2.
        //
        // Assert reset while in S2.
        // Expected state after reset edge = S0.
        //
        // Apply remaining bits: 1, 1.
        // Expected states: S1 -> S1.
        // Expected detected = 0 throughout.
        //
        // Reason:
        // Reset clears the partial sequence 10.
        // The remaining bits 11 cannot complete 1011.

        apply_reset(6);

        apply_bit(1'b1, S1, 1'b0, 1'b0, 6);
        apply_bit(1'b0, S2, 1'b0, 1'b0, 6);

        apply_reset(6);

        apply_bit(1'b1, S1, 1'b0, 1'b0, 6);
        apply_bit(1'b1, S1, 1'b0, 1'b0, 6);


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
