`timescale 1ns/1ps

module dff_async_reset_tb;
    reg d;
    reg clk;
    reg rst_n;
    wire q;

    integer errors;
    
    diff_async_reset dut (
        .d(d),
        .q(q),
        .clk(clk),
        .rst_n(rst_n)
    );

    // Generate a clock with a 10 ns period
    always #5 clk = ~clk;

    initial begin
        $dumpfile("dff_async_reset.vcd");
        $dumpvars(0, dff_async_reset_tb);

        clk = 0;
        rst_n = 1;
        d = 0;
        errors = 0;

        // Test 1: Assert asynchronous reset
        #2;
        rst_n = 0;
        #1;

        if (q !== 0) begin
            $display("FAIL: Asynchronous reset, q=%b", q);
            errors = errors + 1;
        end
        else
            $display("PASS: Asynchronous reset");
        
        // Release reset and test capturing 1
        #2;
        rst_n = 1;
        d = 1;

        @(posedge clk);
        #1;

        if (q !== 1) begin
            $display("FAIL: Capture 1, q=%b", q);
            errors = errors + 1;
        end
        else
            $display("PASS: Capture 1");

        // Change D between clock edges.
        // Q should retain its previous value.
        @(negedge clk);
        d = 0;
        #1;

        if (q !== 1) begin
            $display("FAIL: Hold behavior, q=%b", q);
            errors = errors + 1;
        end
        else
            $display("PASS: Hold behavior");
        

        // Capture 0 on the next rising edge
        @(posedge clk);
        #1;

        if (q !== 0) begin
            $display("FAIL: Capture 0, q=%b", q);
            errors = errors + 1;
        end
        else
            $display("PASS: Capture 0");
        

        // Assert reset between clock edges
        @(negedge clk);
        #1;
        rst_n = 0;
        #1;

        if (q !== 0) begin
            $display("FAIL: Asynchronous reset during operation, q=%b", q);
            errors = errors + 1;
        end
        else
            $display("PASS: Asynchronous reset during operation");
        

        $display("------------------------------");
        $display("Total tests: 5");
        $display("Failed tests: %0d", errors);

        if (errors == 0)
            $display("FINAL RESULT: ALL TESTS PASSED");
        else
            $display("FINAL RESULT: TESTS FAILED");

        $finish;
    end

endmodule