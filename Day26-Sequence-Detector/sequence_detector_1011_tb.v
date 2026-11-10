
`timescale 1ns/1ps

module sequence_detector_1011_tb;

    reg clk;
    reg rst;
    reg serial_in;
    wire detected;

    integer errors;

    // State declarations for verification
    localparam S0 = 2'b00;
    localparam S1 = 2'b01;
    localparam S2 = 2'b10;
    localparam S3 = 2'b11;

    sequence_detector_1011 dut (
        .clk(clk),
        .rst(rst),
        .serial_in(serial_in),
        .detected(detected)
    );

    // Generate clock
    always #5 clk = ~clk;

    initial begin
        $dumpfile("sequence_detector_1011.vcd");
        $dumpvars(0, sequence_detector_1011_tb);

        clk = 0;
        rst = 1;
        serial_in = 0;
        errors = 0;

        // TEST 1: Synchronous Reset
        @(posedge clk);
        #1;

        // Check internal state
        if (dut.state !== S0) begin
            $display("Fail: Internal state reset test, expected=%b, dut.state=%b", S0, dut.state);
            errors = errors + 1;
        end
        else
            $display("Pass: Internal state reset test");
        
        // Check external output
        if (detected !== 1'b0) begin
            $display("Fail: External output reset test, expected=0, output=%b", detected);
            errors = errors + 1;
        end
        else
            $display("Pass: External output reset test");


        // TEST 2: Detect sequence 1011
        @(negedge clk);
        rst = 1'b0;
        serial_in = 1'b1;
        #1;

        if (detected !== 1'b0) begin
            $display("Fail: Detection for first bit, expected=0, detected=%b", detected);
            errors = errors + 1;
        end
        else
            $display("Pass: Detection for first bit");

        @(posedge clk);
        #1;

        if (dut.state !== S1) begin
            $display("Fail: State after first bit, expected=%b, actual=%b", S1, dut.state);
            errors = errors + 1;
        end
        else
            $display("Pass: State after first bit");


        // Second bit: serial_in = 0
        // Expected detected = 0
        // Expected state after posedge = S2

        @(negedge clk);
        serial_in = 1'b0;
        #1;

        if (detected !== 1'b0) begin
            $display("Fail: Detection for second bit, expected=0, detected=%b", detected);
            errors = errors + 1;
        end
        else
            $display("Pass: Detection for second bit");

        @(posedge clk);
        #1;

        if (dut.state !== S2) begin
            $display("Fail: State after second bit, expected=%b, actual=%b", S2, dut.state);
            errors = errors + 1;
        end
        else
            $display("Pass: State after second bit");


        // Third bit: serial_in = 1
        // Expected detected = 0
        // Expected state after posedge = S3

        @(negedge clk);
        serial_in = 1'b1;
        #1;

        if (detected !== 1'b0) begin
            $display("Fail: Detection for third bit, expected=0, detected=%b", detected);
            errors = errors + 1;
        end
        else
            $display("Pass: Detection for third bit");

        @(posedge clk);
        #1;

        if (dut.state !== S3) begin
            $display("Fail: State after third bit, expected=%b, actual=%b", S3, dut.state);
            errors = errors + 1;
        end
        else
            $display("Pass: State after third bit");


        // Fourth bit: serial_in = 1
        // Expected detected = 1 BEFORE posedge
        // Expected state after posedge = S1
        // S1 preserves the overlapping sequence possibility.

        @(negedge clk);
        serial_in = 1'b1;
        #1;

        if (detected !== 1'b1) begin
            $display("Fail: Detection for fourth bit, expected=1, detected=%b", detected);
            errors = errors + 1;
        end
        else
            $display("Pass: Sequence 1011 detected");

        @(posedge clk);
        #1;

        if (dut.state !== S1) begin
            $display("Fail: State after fourth bit, expected=%b, actual=%b", S1, dut.state);
            errors = errors + 1;
        end
        else
            $display("Pass: State after fourth bit");

        // Check that detected returns LOW after the state changes to S1.
        if (detected !== 1'b0) begin
            $display("Fail: Detection output after sequence, expected=0, detected=%b", detected);
            errors = errors + 1;
        end
        else
            $display("Pass: Detection output returned LOW");
        

        // TEST 3: Input sequence 0000
        // Return FSM to S0 before Test 3
        @(negedge clk);
        rst = 1'b1;
        serial_in = 1'b0;

        @(posedge clk);
        #1;

        // Verify reset
        if (dut.state !== S0) begin
            $display("Fail: Reset before Test 3, expected=%b, actual=%b", S0, dut.state);
            errors = errors + 1;
        end
        else
            $display("Pass: Reset before Test 3");

        @(negedge clk);
        rst = 1'b0;
        serial_in = 1'b0;
        #1;

        if (detected !== 1'b0) begin
            $display("Fail: Detection for first bit, expected=0, detected=%b", detected);
            errors = errors + 1;
        end
        else
            $display("Pass: Detection for first bit");

        @(posedge clk);
        #1;

        if (dut.state !== S0) begin
            $display("Fail: State after first bit, expected=%b, actual=%b", S0, dut.state);
            errors = errors + 1;
        end
        else
            $display("Pass: State after first bit");


        // Second bit: serial_in = 0
        // Expected detected = 0
        // Expected state after posedge = S0

        @(negedge clk);
        serial_in = 1'b0;
        #1;

        if (detected !== 1'b0) begin
            $display("Fail: Detection for second bit, expected=0, detected=%b", detected);
            errors = errors + 1;
        end
        else
            $display("Pass: Detection for second bit");

        @(posedge clk);
        #1;

        if (dut.state !== S0) begin
            $display("Fail: State after second bit, expected=%b, actual=%b", S0, dut.state);
            errors = errors + 1;
        end
        else
            $display("Pass: State after second bit");


        // Third bit: serial_in = 0
        // Expected detected = 0
        // Expected state after posedge = S0

        @(negedge clk);
        serial_in = 1'b0;
        #1;

        if (detected !== 1'b0) begin
            $display("Fail: Detection for third bit, expected=0, detected=%b", detected);
            errors = errors + 1;
        end
        else
            $display("Pass: Detection for third bit");

        @(posedge clk);
        #1;

        if (dut.state !== S0) begin
            $display("Fail: State after third bit, expected=%b, actual=%b", S0, dut.state);
            errors = errors + 1;
        end
        else
            $display("Pass: State after third bit");


        // Fourth bit: serial_in = 0
        // Expected detected = 0 BEFORE posedge
        // Expected state after posedge = S0

        @(negedge clk);
        serial_in = 1'b0;
        #1;

        if (detected !== 1'b0) begin
            $display("Fail: Detection for fourth bit, expected=0, detected=%b", detected);
            errors = errors + 1;
        end
        else
            $display("Pass: Detection for fourth bit");

        @(posedge clk);
        #1;

        if (dut.state !== S0) begin
            $display("Fail: State after fourth bit, expected=%b, actual=%b", S0, dut.state);
            errors = errors + 1;
        end
        else
            $display("Pass: State after fourth bit");

        // Check that detected is LOW after the state changes to S0.
        if (detected !== 1'b0) begin
            $display("Fail: Detection output after sequence, expected=0, detected=%b", detected);
            errors = errors + 1;
        end
        else
            $display("Pass: Detection output is LOW");


        // TEST 4: Input sequence 1010
        @(negedge clk);
        serial_in = 1'b1;
        #1;

        if (detected !== 1'b0) begin
            $display("Fail: Detection for first bit, expected=0, detected=%b", detected);
            errors = errors + 1;
        end
        else
            $display("Pass: Detection for first bit");

        @(posedge clk);
        #1;

        if (dut.state !== S1) begin
            $display("Fail: State after first bit, expected=%b, actual=%b", S1, dut.state);
            errors = errors + 1;
        end
        else
            $display("Pass: State after first bit");


        // Second bit: serial_in = 0
        // Expected detected = 0
        // Expected state after posedge = S2

        @(negedge clk);
        serial_in = 1'b0;
        #1;

        if (detected !== 1'b0) begin
            $display("Fail: Detection for second bit, expected=0, detected=%b", detected);
            errors = errors + 1;
        end
        else
            $display("Pass: Detection for second bit");

        @(posedge clk);
        #1;

        if (dut.state !== S2) begin
            $display("Fail: State after second bit, expected=%b, actual=%b", S2, dut.state);
            errors = errors + 1;
        end
        else
            $display("Pass: State after second bit");


        // Third bit: serial_in = 1
        // Expected detected = 0
        // Expected state after posedge = S3

        @(negedge clk);
        serial_in = 1'b1;
        #1;

        if (detected !== 1'b0) begin
            $display("Fail: Detection for third bit, expected=0, detected=%b", detected);
            errors = errors + 1;
        end
        else
            $display("Pass: Detection for third bit");

        @(posedge clk);
        #1;

        if (dut.state !== S3) begin
            $display("Fail: State after third bit, expected=%b, actual=%b", S3, dut.state);
            errors = errors + 1;
        end
        else
            $display("Pass: State after third bit");


        // Fourth bit: serial_in = 0
        // Expected detected = 0 BEFORE posedge
        // Expected state after posedge = S2

        @(negedge clk);
        serial_in = 1'b0;
        #1;

        if (detected !== 1'b0) begin
            $display("Fail: Detection for fourth bit, expected=0, detected=%b", detected);
            errors = errors + 1;
        end
        else
            $display("Pass: Detection for fourth bit");

        @(posedge clk);
        #1;

        if (dut.state !== S2) begin
            $display("Fail: State after fourth bit, expected=%b, actual=%b", S2, dut.state);
            errors = errors + 1;
        end
        else
            $display("Pass: State after fourth bit");

        // Check that detected is LOW after the state changes to S2.
        if (detected !== 1'b0) begin
            $display("Fail: Detection output after sequence, expected=0, detected=%b", detected);
            errors = errors + 1;
        end
        else
            $display("Pass: Detection output is LOW");


        // TEST 5: Overlapping sequence detection
        // Return FSM to S0 before Test 5
        @(negedge clk);
        rst = 1'b1;
        serial_in = 1'b0;

        @(posedge clk);
        #1;

        // Verify reset
        if (dut.state !== S0) begin
            $display("Fail: Reset before Test 5, expected=%b, actual=%b", S0, dut.state);
            errors = errors + 1;
        end
        else
            $display("Pass: Reset before Test 5");
        
        @(negedge clk);
        rst = 1'b0;
        serial_in = 1'b1;
        #1;

        if (detected !== 1'b0) begin
            $display("Fail: Detection for first bit, expected=0, detected=%b", detected);
            errors = errors + 1;
        end
        else
            $display("Pass: Detection for first bit");

        @(posedge clk);
        #1;

        if (dut.state !== S1) begin
            $display("Fail: State after first bit, expected=%b, actual=%b", S1, dut.state);
            errors = errors + 1;
        end
        else
            $display("Pass: State after first bit");


        // Second bit: serial_in = 0
        // Expected detected = 0
        // Expected state after posedge = S2

        @(negedge clk);
        serial_in = 1'b0;
        #1;

        if (detected !== 1'b0) begin
            $display("Fail: Detection for second bit, expected=0, detected=%b", detected);
            errors = errors + 1;
        end
        else
            $display("Pass: Detection for second bit");

        @(posedge clk);
        #1;

        if (dut.state !== S2) begin
            $display("Fail: State after second bit, expected=%b, actual=%b", S2, dut.state);
            errors = errors + 1;
        end
        else
            $display("Pass: State after second bit");


        // Third bit: serial_in = 1
        // Expected detected = 0
        // Expected state after posedge = S3

        @(negedge clk);
        serial_in = 1'b1;
        #1;

        if (detected !== 1'b0) begin
            $display("Fail: Detection for third bit, expected=0, detected=%b", detected);
            errors = errors + 1;
        end
        else
            $display("Pass: Detection for third bit");

        @(posedge clk);
        #1;

        if (dut.state !== S3) begin
            $display("Fail: State after third bit, expected=%b, actual=%b", S3, dut.state);
            errors = errors + 1;
        end
        else
            $display("Pass: State after third bit");


        // Fourth bit: serial_in = 1
        // Expected detected = 1 BEFORE posedge
        // Expected state after posedge = S1
        // S1 preserves the overlapping sequence possibility.

        @(negedge clk);
        serial_in = 1'b1;
        #1;

        if (detected !== 1'b1) begin
            $display("Fail: Detection for fourth bit, expected=1, detected=%b", detected);
            errors = errors + 1;
        end
        else
            $display("Pass: Sequence 1011 detected");

        @(posedge clk);
        #1;

        if (dut.state !== S1) begin
            $display("Fail: State after fourth bit, expected=%b, actual=%b", S1, dut.state);
            errors = errors + 1;
        end
        else
            $display("Pass: State after fourth bit");

        // Check that detected returns LOW after the state changes to S1.
        if (detected !== 1'b0) begin
            $display("Fail: Detection output after sequence, expected=0, detected=%b", detected);
            errors = errors + 1;
        end
        else
            $display("Pass: Detection output returned LOW");

        // Fifth bit: serial_in = 0
        // Expected detected = 0
        // Expected state after posedge = S2

        @(negedge clk);
        serial_in = 1'b0;
        #1;

        if (detected !== 1'b0) begin
            $display("Fail: Detection for fifth bit, expected=0, detected=%b", detected);
            errors = errors + 1;
        end
        else
            $display("Pass: Detection for fifth bit");

        @(posedge clk);
        #1;

        if (dut.state !== S2) begin
            $display("Fail: State after fifth bit, expected=%b, actual=%b", S2, dut.state);
            errors = errors + 1;
        end
        else
            $display("Pass: State after fifth bit");


        // Sixth bit: serial_in = 1
        // Expected detected = 0
        // Expected state after posedge = S3

        @(negedge clk);
        serial_in = 1'b1;
        #1;

        if (detected !== 1'b0) begin
            $display("Fail: Detection for sixth bit, expected=0, detected=%b", detected);
            errors = errors + 1;
        end
        else
            $display("Pass: Detection for sixth bit");

        @(posedge clk);
        #1;

        if (dut.state !== S3) begin
            $display("Fail: State after sixth bit, expected=%b, actual=%b", S3, dut.state);
            errors = errors + 1;
        end
        else
            $display("Pass: State after sixth bit");


        // Seventh bit: serial_in = 1
        // Expected detected = 1 BEFORE posedge
        // Expected state after posedge = S1
        // S1 preserves the overlapping sequence possibility.

        @(negedge clk);
        serial_in = 1'b1;
        #1;

        if (detected !== 1'b1) begin
            $display("Fail: Detection for seventh bit, expected=1, detected=%b", detected);
            errors = errors + 1;
        end
        else
            $display("Pass: Sequence 1011 detected");

        @(posedge clk);
        #1;

        if (dut.state !== S1) begin
            $display("Fail: State after seventh bit, expected=%b, actual=%b", S1, dut.state);
            errors = errors + 1;
        end
        else
            $display("Pass: State after seventh bit");

        // Check that detected returns LOW after the state changes to S1.
        if (detected !== 1'b0) begin
            $display("Fail: Detection output after sequence, expected=0, detected=%b", detected);
            errors = errors + 1;
        end
        else
            $display("Pass: Detection output returned LOW");

        // TEST 6: Reset during partial sequence
        // Return FSM to S0 before Test 6
        @(negedge clk);
        rst = 1'b1;
        serial_in = 1'b0;

        @(posedge clk);
        #1;

        // Verify reset
        if (dut.state !== S0) begin
            $display("Fail: Reset before Test 6, expected=%b, actual=%b", S0, dut.state);
            errors = errors + 1;
        end
        else
            $display("Pass: Reset before Test 6");
        
        @(negedge clk);
        rst = 1'b0;
        serial_in = 1'b1;
        #1;

        if (detected !== 1'b0) begin
            $display("Fail: Detection for first bit, expected=0, detected=%b", detected);
            errors = errors + 1;
        end
        else
            $display("Pass: Detection for first bit");

        @(posedge clk);
        #1;

        if (dut.state !== S1) begin
            $display("Fail: State after first bit, expected=%b, actual=%b", S1, dut.state);
            errors = errors + 1;
        end
        else
            $display("Pass: State after first bit");


        // Second bit: serial_in = 0
        // Expected detected = 0
        // Expected state after posedge = S2

        @(negedge clk);
        serial_in = 1'b0;
        #1;

        if (detected !== 1'b0) begin
            $display("Fail: Detection for second bit, expected=0, detected=%b", detected);
            errors = errors + 1;
        end
        else
            $display("Pass: Detection for second bit");

        @(posedge clk);
        #1;

        if (dut.state !== S2) begin
            $display("Fail: State after second bit, expected=%b, actual=%b", S2, dut.state);
            errors = errors + 1;
        end
        else
            $display("Pass: State after second bit");
        
        // Assert reset after first two bits: 1, 0.
        @(negedge clk);
        rst = 1'b1;

        @(posedge clk);
        #1;

        // Verify reset
        if (dut.state !== S0) begin
            $display("Fail: Reset after first two bits: 1, 0, expected=%b, actual=%b", S0, dut.state);
            errors = errors + 1;
        end
        else
            $display("Pass: Reset after first two bits: 1, 0");
        
        
        // Third bit: serial_in = 1
        // Expected detected = 0
        // Expected state after posedge = S1

        @(negedge clk);
        rst = 1'b0;
        serial_in = 1'b1;
        #1;

        if (detected !== 1'b0) begin
            $display("Fail: Detection for third bit, expected=0, detected=%b", detected);
            errors = errors + 1;
        end
        else
            $display("Pass: Detection for third bit");

        @(posedge clk);
        #1;

        if (dut.state !== S1) begin
            $display("Fail: State after third bit, expected=%b, actual=%b", S1, dut.state);
            errors = errors + 1;
        end
        else
            $display("Pass: State after third bit");


        // Fourth bit: serial_in = 1
        // Expected detected = 0 BEFORE posedge
        // Expected state after posedge = S1
        // S1 preserves the overlapping sequence possibility.

        @(negedge clk);
        serial_in = 1'b1;
        #1;

        if (detected !== 1'b0) begin
            $display("Fail: Detection for fourth bit, expected=0, detected=%b", detected);
            errors = errors + 1;
        end
        else
            $display("Pass:  Detection for fourth bit");

        @(posedge clk);
        #1;

        if (dut.state !== S1) begin
            $display("Fail: State after fourth bit, expected=%b, actual=%b", S1, dut.state);
            errors = errors + 1;
        end
        else
            $display("Pass: State after fourth bit");

        // Check that detected is LOW after the state changes to S1.
        if (detected !== 1'b0) begin
            $display("Fail: Detection output after sequence, expected=0, detected=%b", detected);
            errors = errors + 1;
        end
        else
            $display("Pass: Detection output is LOW");
        

        // FINAL VERIFICATION RESULT
        if (errors == 0)
            $display("ALL TESTS PASSED");
        else
            $display("TESTS FAILED: %0d errors", errors);

        $finish;

    end

endmodule