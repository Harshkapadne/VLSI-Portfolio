`timescale 1ns/1ps

module clock_enable_register_4bit_tb;

    reg clk;
    reg rst;
    reg en;
    reg [3:0] d;
    wire [3:0] q;

    integer errors;

    clock_enable_register_4bit dut (
        .clk(clk),
        .rst(rst),
        .en(en),
        .d(d),
        .q(q)
    );

    // Generate the clock
    always #5 clk = ~clk;

    initial begin
        $dumpfile("clock_enable_register_4bit.vcd");
        $dumpvars(0, clock_enable_register_4bit_tb);

        clk = 0;
        rst = 0;
        en = 0;
        d = 4'b0000;
        errors = 0;

        // Test 1: Synchronous reset
        @(negedge clk);
        rst = 1;

        @(posedge clk);
        #1;

        if(q !== 4'b0000) begin
            $display("Fail: Synchronous reset test, q=%b", q);
            errors = errors + 1;
        end
        else
            $display("Pass: Synchronous reset test");

        // Test 2: Load data with enable = 1
        @(negedge clk);
        rst = 0;
        en = 1;
        d = 4'b1010;

        @(posedge clk);
        #1;

        if(q !== 4'b1010) begin
            $display("Fail: Load data with enable = 1 test, q=%b", q);
            errors = errors + 1;
        end
        else
            $display("Pass: Load data with enable = 1 test");

        // Test 3: Hold data with enable = 0
        @(negedge clk);
        en = 0;
        d = 4'b1100;

        @(posedge clk);
        #1;

        if(q !== 4'b1010) begin
            $display("Fail: Hold data with enable = 0 test, q=%b", q);
            errors = errors + 1;
        end
        else
            $display("Pass: Hold data with enable = 0 test");

        // Test 4: Change input while enable = 0
        @(negedge clk);
        d = 4'b0101;

        @(posedge clk);
        #1;

        if(q !== 4'b1010) begin
            $display("Fail: Change input while enable = 0 test, q=%b", q);
            errors = errors + 1;
        end
        else
            $display("Pass: Change input while enable = 0 test");

        // Test 5: Enable again and load new data
        @(negedge clk);
        en = 1;
        d = 4'b0101;

        @(posedge clk);
        #1;

        if(q !== 4'b0101) begin
            $display("Fail: Enable again and load new data test, q=%b", q);
            errors = errors + 1;
        end
        else
            $display("Pass: Enable again and load new data test");

        // Test 6: Reset priority over enable
        @(negedge clk);
        rst = 1;
        en = 1;
        d = 4'b1111;

        @(posedge clk);
        #1;

        if(q !== 4'b0000) begin
            $display("Fail: Reset priority over enable test, q=%b", q);
            errors = errors + 1;
        end
        else
            $display("Pass: Reset priority over enable test");

        // Additional test: Check value retention between clock edges
        @(negedge clk);
        rst = 0;
        en = 1;
        d = 4'b1111;
        #1;

        if(q !== 4'b0000) begin
            $display("Fail: Value retention before positive clock edge test, q=%b", q);
            errors = errors + 1;
        end
        else
            $display("Pass: Value retention before positive clock edge test");

        @(posedge clk);
        #1;

        if(q !== 4'b1111) begin
            $display("Fail: Value retention after positive clock edge test, q=%b", q);
            errors = errors + 1;
        end
        else
            $display("Pass: Value retention after positive clock edge test");

        // Display final verification result
        if(errors == 0)
            $display("ALL TESTS PASSED");
        else
            $display("TESTS FAILED: %0d errors", errors);

        $finish;
    end

endmodule