`timescale 1ns/1ps

module up_counter_4bit_tb;
    reg clk;
    reg rst;
    wire [3:0] count;

    integer errors;

    up_counter_4bit dut (
        .clk(clk),
        .rst(rst),
        .count(count)
    );

    // Generate the clock
    always #5 clk = ~clk;

    initial begin 
        $dumpfile("up_counter_4bit.vcd");
        $dumpvars(0, up_counter_4bit_tb);

        clk = 0;
        rst = 0;
        errors = 0;

        // Test 1: Synchronous reset
        @(negedge clk);
        rst = 1;

        @(posedge clk);
        #1;

        if (count !== 4'b0000) begin
            $display("Fail: Reset test, count=%b", count);
            errors = errors + 1;
        end
        else
            $display("Pass: Reset test");
        
        // Test 2: Counter increment
        @(negedge clk);
        rst = 0;

        @(posedge clk);
        #1;

        if (count !== 4'b0001) begin
            $display("Fail: Counter increment test, count=%b" , count);
            errors = errors + 1;
        end
        else
            $display("Pass: Counter increment test");
        
        // Test 3: Value retention between clock edges
        @(negedge clk);

        if (count !== 4'b0001) begin
            $display("Fail: Value retention test, count=%b" , count);
            errors = errors + 1;
        end
        else
            $display("Pass: Value retention test");
        
        // Test 4: Counter overflow
        /*
        integer i;

        for (i = 0; i < 14; i = i + 1) begin
            @(posedge clk);
            #1;

            $display("Count = %b", count);
        end
        */
        
        repeat (14) @(posedge clk);
        #1;

        if (count !== 4'b1111) begin
            $display("Fail: Counter did not reach 1111, count=%b" , count);
            errors = errors + 1;
        end
        else
            $display("Pass: Counter reached 1111");

        @(posedge clk);
        #1;

        if (count !== 4'b0000) begin
            $display("Fail: Overflow test, count=%b" , count);
            errors = errors + 1;
        end
        else
            $display("Pass: Counter overflow test");

        // Test 5: Reset during counting
        rst = 0;

        @(posedge clk);
        #1;

        if (count !== 4'b0001) begin
            $display("Fail: Counter did not start counting, count=%b", count);
            errors = errors + 1;
        end
        else
            $display("Counter is counting before reset");

        @(negedge clk);
        rst = 1;

        @(posedge clk);
        #1;

        if (count !== 4'b0000) begin
            $display("Fail: Reset during counting test, count=%b" , count);
            errors = errors + 1;
        end
        else
            $display("Pass: Reset during counting test");


        // Display the final verification result.
        if (errors == 0)
            $display("ALL TESTS PASSED");
        else
            $display("TESTS FAILED: %0d errors", errors);
        
        $finish;
    end
endmodule