`timescale 1ns/1ps

module mod10_counter_tb;

    reg clk;
    reg rst;
    wire [3:0] count;

    integer errors;

    mod10_counter dut (
        .clk(clk),
        .rst(rst),
        .count(count)
    );

    // Generate the clock
    always #5 clk = ~clk;

    initial begin
        $dumpfile("mod10_counter.vcd");
        $dumpvars(0, mod10_counter_tb);

        clk = 0;
        rst = 0;
        errors = 0;

        // Test 1: Synchronous reset
        @(negedge clk);
        rst = 1;

        @(posedge clk);
        #1;

        if (count !== 4'b0000) begin
            $display("Fail: Synchronous reset test, expected=0000 count=%b", count);
            errors = errors + 1;
        end
        else
            $display("Pass: Synchronous reset test");

        // Test 2: First increment
        @(negedge clk);
        rst = 0;

        @(posedge clk);
        #1;

        if (count !== 4'b0001) begin
            $display("Fail: First increment test, expected=0001 count=%b", count);
            errors = errors + 1;
        end
        else
            $display("Pass: First increment test");

        // Test 3: Multiple increments
        repeat(4) @(posedge clk);
        #1;

        if (count !== 4'b0101) begin
            $display("Fail: Multiple increments test, expected=0101 count=%b", count);
            errors = errors + 1;
        end
        else
            $display("Pass: Multiple increments test");

        // Test 4: Reach terminal count 9
        repeat(4) @(posedge clk);
        #1;

        if (count !== 4'b1001) begin
            $display("Fail: Reach terminal count 9 test, expected=1001 count=%b", count);
            errors = errors + 1;
        end
        else
            $display("Pass: Reach terminal count 9 test");

        // Test 5: Mod-10 rollover
        @(posedge clk);
        #1;

        if (count !== 4'b0000) begin
            $display("Fail: Mod-10 rollover test, expected=0000 count=%b", count);
            errors = errors + 1;
        end
        else
            $display("Pass: Mod-10 rollover test");

        // Test 6: Continue counting after rollover
        @(posedge clk);
        #1;

        if (count !== 4'b0001) begin
            $display("Fail: Continue counting after rollover test, expected=0001 count=%b", count);
            errors = errors + 1;
        end
        else
            $display("Pass: Continue counting after rollover test");

        // Test 7: Reset during counting
        @(negedge clk);
        rst = 1;

        @(posedge clk);
        #1;

        if (count !== 4'b0000) begin
            $display("Fail: Reset during counting test, expected=0000 count=%b", count);
            errors = errors + 1;
        end
        else
            $display("Pass: Reset during counting test");

        // Additional test: Value retention between clock edges
        @(negedge clk);
        rst = 0;
        #1;

        if (count !== 4'b0000) begin
            $display("Fail: Value retention before clock edge test, expected=0000 count=%b", count);
            errors = errors + 1;
        end
        else
            $display("Pass: Value retention before clock edge test");

        @(posedge clk);
        #1;

        if (count !== 4'b0001) begin
            $display("Fail: Value retention after clock edge test, expected=0001 count=%b", count);
            errors = errors + 1;
        end
        else
            $display("Pass: Value retention after clock edge test");

        // Display final verification result
        if(errors == 0)
            $display("ALL TESTS PASSED");
        else
            $display("TESTS FAILED: %0d errors", errors);

        $finish;
    end

endmodule