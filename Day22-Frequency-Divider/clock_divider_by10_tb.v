
`timescale 1ns/1ps

module clock_divider_by10_tb;

    reg clk;
    reg rst;
    wire clk_out;

    integer errors;

    clock_divider_by10 dut (
        .clk(clk),
        .rst(rst),
        .clk_out(clk_out)
    );

    // Generate the input clock
    always #5 clk = ~clk;

    initial begin
        $dumpfile("clock_divider_by10.vcd");
        $dumpvars(0, clock_divider_by10_tb);

        clk = 0;
        rst = 0;
        errors = 0;

        // Test 1: Synchronous reset
        @(negedge clk);
        rst = 1;

        @(posedge clk);
        #1;

        if (dut.count !== 3'b000) begin
            $display("Fail: Reset test, count=%b", dut.count);
            errors = errors + 1;
        end
        else
            $display("Pass: Counter synchronous reset test");

        if (clk_out !== 1'b0) begin
            $display("Fail: Reset output test, clk_out=%b", clk_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Output synchronous reset test");


        // Test 2: Counter reaches terminal count 4
        @(negedge clk);
        rst = 0;

        repeat(4) @(posedge clk);
        #1;

        if (dut.count !== 3'b100) begin
            $display("Fail: Terminal count test, expected=100 actual=%b", dut.count);
            errors = errors + 1;
        end
        else
            $display("Pass: Counter reached terminal count 4");

        if (clk_out !== 1'b0) begin
            $display("Fail: Premature output transition, clk_out=%b", clk_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Output unchanged before terminal edge");


        // Test 3: First output transition
        @(posedge clk);
        #1;

        if (dut.count !== 3'b000) begin
            $display("Fail: First transition counter test, count=%b", dut.count);
            errors = errors + 1;
        end
        else
            $display("Pass: Counter reset after terminal count");

        if (clk_out !== 1'b1) begin
            $display("Fail: First output transition test, clk_out=%b", clk_out);
            errors = errors + 1;
        end
        else
            $display("Pass: First output transition test");


        // Test 4: Second output transition
        repeat(5) @(posedge clk);
        #1;

        if (dut.count !== 3'b000) begin
            $display("Fail: Second transition counter test, count=%b", dut.count);
            errors = errors + 1;
        end
        else
            $display("Pass: Second transition counter test");

        if (clk_out !== 1'b0) begin
            $display("Fail: Second output transition test, clk_out=%b", clk_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Second output transition test");


        // Test 5: Third output transition
        repeat(5) @(posedge clk);
        #1;

        if (dut.count !== 3'b000) begin
            $display("Fail: Third transition counter test, count=%b", dut.count);
            errors = errors + 1;
        end
        else
            $display("Pass: Third transition counter test");

        if (clk_out !== 1'b1) begin
            $display("Fail: Third output transition test, clk_out=%b", clk_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Third output transition test");


        // Test 6: Value retention between clock edges
        @(negedge clk);
        #1;

        if (dut.count !== 3'b000) begin
            $display("Fail: Value retention test, count=%b", dut.count);
            errors = errors + 1;
        end
        else
            $display("Pass: Counter value retention test");

        if (clk_out !== 1'b1) begin
            $display("Fail: Output retention test, clk_out=%b", clk_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Output retention test");


        // Test 7: Reset during operation
        @(posedge clk);
        #1;

        if (dut.count !== 3'b001) begin
            $display("Fail: Counter before reset, count=%b", dut.count);
            errors = errors + 1;
        end
        else
            $display("Pass: Counter operating before reset");

        if (clk_out !== 1'b1) begin
            $display("Fail: Output before reset, clk_out=%b", clk_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Output before reset");


        // Assert reset between clock edges
        @(negedge clk);
        rst = 1;
        #1;

        if (dut.count !== 3'b001) begin
            $display("Fail: Asynchronous change in counter, count=%b", dut.count);
            errors = errors + 1;
        end
        else
            $display("Pass: Counter unchanged before reset clock edge");

        if (clk_out !== 1'b1) begin
            $display("Fail: Asynchronous change in output, clk_out=%b", clk_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Output unchanged before reset clock edge");


        // Reset takes effect at the next rising edge
        @(posedge clk);
        #1;

        if (dut.count !== 3'b000) begin
            $display("Fail: Reset during operation, count=%b", dut.count);
            errors = errors + 1;
        end
        else
            $display("Pass: Reset during operation test");

        if (clk_out !== 1'b0) begin
            $display("Fail: Output reset during operation, clk_out=%b", clk_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Output reset during operation test");


        // Display final verification result
        if (errors == 0)
            $display("ALL TESTS PASSED");
        else
            $display("TESTS FAILED: %0d errors", errors);

        $finish;
    end

endmodule
