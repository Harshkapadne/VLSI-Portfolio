`timescale 1ns/1ps

module register_4bit_tb;
    reg clk;
    reg rst;
    reg [3:0] d;
    wire [3:0] q;

    integer errors;

    register_4bit dut (
        .clk(clk),
        .rst(rst),
        .d(d),
        .q(q)
    );

    // Generate a clock with a 10 ns period
    always #5 clk = ~clk;

    initial begin 
        $dumpfile("register_4bit.vcd");
        $dumpvars(0, register_4bit_tb);

        clk = 0;
        rst = 0;
        d = 4'b0000;
        errors = 0;
        
         // Test 1: Synchronous reset
         @(negedge clk);
         rst = 1;
         d = 4'b1010;

         @(posedge clk);
         #1;
         if (q !== 4'b0000) begin
            $display("FAIL: Reset test, q=%b", q);
            errors = errors + 1;
        end
        else
            $display("PASS: Reset test");
        
        // Test 2: Capture 1010
         @(negedge clk);
         rst = 0;
         d = 4'b1010;

         @(posedge clk);
         #1;
         if (q !== 4'b1010) begin
            $display("FAIL: Capture 1010, q=%b", q);
            errors = errors + 1;
        end
        else
            $display("PASS: Capture 1010");
        
        // Test 3: Capture 0101
        @(negedge clk);
         d = 4'b0101;

         @(posedge clk);
         #1;
         if (q !== 4'b0101) begin
            $display("FAIL: Capture 0101, q=%b", q);
            errors = errors + 1;
        end
        else
            $display("PASS: Capture 0101");
        
        // Test 4: Hold value between rising edges
        @(negedge clk);
         d = 4'b1111;
         #1;

         if (q !== 4'b0101) begin
            $display("FAIL: Hold test, q=%b", q);
            errors = errors + 1;
        end
        else
            $display("PASS: Hold test");
        
        // Test 5: Capture 1111
        @(posedge clk);
         #1;
         if (q !== 4'b1111) begin
            $display("FAIL: Capture 1111, q=%b", q);
            errors = errors + 1;
        end
        else
            $display("PASS: Capture 1111");
        
        // Final result
        if (errors == 0)
            $display("ALL TESTS PASSED");
        else
            $display("TESTS FAILED: %0d errors", errors);
        
        $finish;
    end
endmodule