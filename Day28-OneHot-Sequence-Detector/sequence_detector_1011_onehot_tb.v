
`timescale 1ns/1ps

module sequence_detector_1011_onehot_tb;

    reg clk;
    reg rst;
    reg serial_in;
    wire detected;

    integer errors;
    integer detection_count;

    // One-Hot state declarations for verification
    localparam [4:0] S0 = 5'b00001;
    localparam [4:0] S1 = 5'b00010;
    localparam [4:0] S2 = 5'b00100;
    localparam [4:0] S3 = 5'b01000;
    localparam [4:0] S4 = 5'b10000;

    sequence_detector_1011_onehot dut (
        .clk(clk),
        .rst(rst),
        .serial_in(serial_in),
        .detected(detected)
    );

    // Generate clock
    always #5 clk = ~clk;


    // =====================================================
    // TASK 1: Check One-Hot state validity
    // =====================================================
    // Exactly one state bit must be HIGH.
    // Valid states: S0, S1, S2, S3, S4.

    task check_onehot;
        input [4:0] checked_state;
        input integer test_no;

        begin
            if ((checked_state !== S0) &&
                (checked_state !== S1) &&
                (checked_state !== S2) &&
                (checked_state !== S3) &&
                (checked_state !== S4)) begin

                $display("FAIL Test %0d: Invalid One-Hot state = %b",
                         test_no, checked_state);
                errors = errors + 1;
            end
            else
                $display("PASS Test %0d: Valid One-Hot state = %b",
                         test_no, checked_state);
        end
    endtask


    // =====================================================
    // TASK 2: Apply one serial input bit and verify FSM
    // =====================================================
    // bit_value       = Serial input bit
    // expected_state  = Expected state after positive edge
    // expected_before = Expected detected before positive edge
    // expected_after  = Expected detected after positive edge
    // test_no         = Test identification number

    task apply_bit;
        input bit_value;
        input [4:0] expected_state;
        input expected_before;
        input expected_after;
        input integer test_no;

        begin
            @(negedge clk);
            serial_in = bit_value;
            #1;

            // Check Moore output before positive edge
            if (detected !== expected_before) begin
                $display("FAIL Test %0d: Output before edge, expected=%b, actual=%b",
                         test_no, expected_before, detected);
                errors = errors + 1;
            end
            else
                $display("PASS Test %0d: Output before edge", test_no);

            // Verify next_state is a valid One-Hot encoding
            check_onehot(dut.next_state, test_no);

            @(posedge clk);
            #1;

            // Check internal state after positive edge
            if (dut.state !== expected_state) begin
                $display("FAIL Test %0d: State, expected=%b, actual=%b",
                         test_no, expected_state, dut.state);
                errors = errors + 1;
            end
            else
                $display("PASS Test %0d: Internal state", test_no);

            // Verify current state has valid One-Hot encoding
            check_onehot(dut.state, test_no);

            // Check Moore output after positive edge
            if (detected !== expected_after) begin
                $display("FAIL Test %0d: Output after edge, expected=%b, actual=%b",
                         test_no, expected_after, detected);
                errors = errors + 1;
            end
            else
                $display("PASS Test %0d: Output after edge", test_no);

            // Count successful detections
            if (detected === 1'b1)
                detection_count = detection_count + 1;

        end
    endtask


    // =====================================================
    // TASK 3: Apply synchronous reset
    // =====================================================
    // expected_before_state = State before reset clock edge
    // test_no = Test identification number
    //
    // Check that state does not change immediately
    // when synchronous reset is asserted.
    //
    // After positive edge:
    // Expected state = S0 (00001)
    // Expected detected = 0

    task apply_reset;
        input [4:0] expected_before_state;
        input integer test_no;

        begin
            @(negedge clk);
            rst = 1'b1;
            serial_in = 1'b0;
            #1;

            // Check state before positive clock edge
            if (dut.state !== expected_before_state) begin
                $display("FAIL Test %0d: State before reset edge, expected=%b, actual=%b",
                         test_no, expected_before_state, dut.state);
                errors = errors + 1;
            end
            else
                $display("PASS Test %0d: State held before reset edge", test_no);

            // Check Moore output before reset edge
            if (detected !== (expected_before_state == S4)) begin
                $display("FAIL Test %0d: Output before reset edge, actual=%b",
                         test_no, detected);
                errors = errors + 1;
            end
            else
                $display("PASS Test %0d: Output before reset edge", test_no);

            @(posedge clk);
            #1;

            // Check state after synchronous reset
            if (dut.state !== S0) begin
                $display("FAIL Test %0d: Reset state, expected=%b, actual=%b",
                         test_no, S0, dut.state);
                errors = errors + 1;
            end
            else
                $display("PASS Test %0d: Reset state", test_no);

            check_onehot(dut.state, test_no);

            // Check reset output
            if (detected !== 1'b0) begin
                $display("FAIL Test %0d: Reset output, expected=0, actual=%b",
                         test_no, detected);
                errors = errors + 1;
            end
            else
                $display("PASS Test %0d: Reset output", test_no);

            rst = 1'b0;

        end
    endtask


    // =====================================================
    // MAIN TEST SEQUENCE
    // =====================================================

    initial begin

        $dumpfile("sequence_detector_1011_onehot.vcd");
        $dumpvars(0, sequence_detector_1011_onehot_tb);

        clk = 0;
        rst = 1;
        serial_in = 0;
        errors = 0;
        detection_count = 0;


        // =================================================
        // TEST 1: Synchronous Reset
        // =================================================
        // Reset is HIGH before the first positive clock edge.
        // Expected state after edge = S0 (00001).
        // Expected detected = 0.

        @(posedge clk);
        #1;

        if (dut.state !== S0) begin
            $display("FAIL Test 1: Reset state, expected=%b, actual=%b",
                     S0, dut.state);
            errors = errors + 1;
        end
        else
            $display("PASS Test 1: Reset state");

        check_onehot(dut.state, 1);

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
        //
        // Expected state progression:
        // S0 -> S1 -> S2 -> S3 -> S4
        //
        // Expected detected BEFORE positive edges:
        // 0, 0, 0, 0
        //
        // Expected detected AFTER positive edges:
        // 0, 0, 0, 1
        //
        // Expected total detections = 1.

        detection_count = 0;

        apply_bit(1'b1, S1, 1'b0, 1'b0, 2);
        apply_bit(1'b0, S2, 1'b0, 1'b0, 2);
        apply_bit(1'b1, S3, 1'b0, 1'b0, 2);
        apply_bit(1'b1, S4, 1'b0, 1'b1, 2);

        if (detection_count != 1) begin
            $display("FAIL Test 2: Expected 1 detection, actual=%0d",
                     detection_count);
            errors = errors + 1;
        end
        else
            $display("PASS Test 2: Exactly 1 detection");


        // =================================================
        // TEST 3: Input sequence 0000
        // =================================================
        // Reset before starting.
        // Input: 0, 0, 0, 0
        // Expected state: S0 for all four bits.
        // Expected detected before and after every edge = 0.
        // Expected total detections = 0.

        apply_reset(S4, 3);
        detection_count = 0;

        apply_bit(1'b0, S0, 1'b0, 1'b0, 3);
        apply_bit(1'b0, S0, 1'b0, 1'b0, 3);
        apply_bit(1'b0, S0, 1'b0, 1'b0, 3);
        apply_bit(1'b0, S0, 1'b0, 1'b0, 3);

        if (detection_count != 0) begin
            $display("FAIL Test 3: Expected 0 detections, actual=%0d",
                     detection_count);
            errors = errors + 1;
        end
        else
            $display("PASS Test 3: No detection");


        // =================================================
        // TEST 4: Input sequence 1010
        // =================================================
        // Reset before starting.
        // Input: 1, 0, 1, 0
        //
        // Expected state progression:
        // S0 -> S1 -> S2 -> S3 -> S2
        //
        // Expected detected before and after every edge = 0.
        // Expected total detections = 0.

        apply_reset(S0, 4);
        detection_count = 0;

        apply_bit(1'b1, S1, 1'b0, 1'b0, 4);
        apply_bit(1'b0, S2, 1'b0, 1'b0, 4);
        apply_bit(1'b1, S3, 1'b0, 1'b0, 4);
        apply_bit(1'b0, S2, 1'b0, 1'b0, 4);

        if (detection_count != 0) begin
            $display("FAIL Test 4: Expected 0 detections, actual=%0d",
                     detection_count);
            errors = errors + 1;
        end
        else
            $display("PASS Test 4: No detection");


        // =================================================
        // TEST 5: Overlapping sequence detection
        // =================================================
        // Reset before starting.
        // Input: 1, 0, 1, 1, 0, 1, 1
        //
        // Expected state progression:
        // S0 -> S1 -> S2 -> S3 -> S4 -> S2 -> S3 -> S4
        //
        // Expected detected BEFORE positive edges:
        // 0, 0, 0, 0, 1, 0, 0
        //
        // Expected detected AFTER positive edges:
        // 0, 0, 0, 1, 0, 0, 1
        //
        // Expected total detections = 2.

        apply_reset(S2, 5);
        detection_count = 0;

        apply_bit(1'b1, S1, 1'b0, 1'b0, 5);
        apply_bit(1'b0, S2, 1'b0, 1'b0, 5);
        apply_bit(1'b1, S3, 1'b0, 1'b0, 5);
        apply_bit(1'b1, S4, 1'b0, 1'b1, 5);
        apply_bit(1'b0, S2, 1'b1, 1'b0, 5);
        apply_bit(1'b1, S3, 1'b0, 1'b0, 5);
        apply_bit(1'b1, S4, 1'b0, 1'b1, 5);

        if (detection_count != 2) begin
            $display("FAIL Test 5: Expected 2 detections, actual=%0d",
                     detection_count);
            errors = errors + 1;
        end
        else
            $display("PASS Test 5: Exactly 2 overlapping detections");


        // =================================================
        // TEST 6: Reset during partial sequence
        // =================================================
        // Reset before starting.
        //
        // First input bits: 1, 0
        // Expected progression: S0 -> S1 -> S2.
        //
        // Assert reset while in S2.
        // Expected state after reset edge = S0.
        //
        // Apply remaining bits: 1, 1.
        // Expected progression: S0 -> S1 -> S1.
        //
        // Expected detected = 0 throughout.
        // Expected total detections = 0.
        //
        // Reason:
        // Reset clears the partial sequence 10.
        // Remaining bits 11 cannot complete 1011.

        apply_reset(S4, 6);
        detection_count = 0;

        apply_bit(1'b1, S1, 1'b0, 1'b0, 6);
        apply_bit(1'b0, S2, 1'b0, 1'b0, 6);

        apply_reset(S2, 6);

        apply_bit(1'b1, S1, 1'b0, 1'b0, 6);
        apply_bit(1'b1, S1, 1'b0, 1'b0, 6);

        if (detection_count != 0) begin
            $display("FAIL Test 6: Expected 0 detections, actual=%0d",
                     detection_count);
            errors = errors + 1;
        end
        else
            $display("PASS Test 6: Partial sequence cleared by reset");


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
