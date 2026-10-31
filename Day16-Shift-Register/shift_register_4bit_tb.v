`timescale 1ns/1ps

module shift_register_4bit_tb;

    reg clk;
    reg rst;
    reg serial_in;
    wire [3:0] parallel_out;

    integer errors;

    shift_register_4bit dut (
        .clk(clk),
        .rst(rst),
        .serial_in(serial_in),
        .parallel_out(parallel_out)
    );

    // Generate the clock
    always #5 clk = ~clk;

    initial begin
        $dumpfile("shift_register_4bit.vcd");
        $dumpvars(0, shift_register_4bit_tb);

        clk = 0;
        rst = 0;
        serial_in = 0;
        errors = 0;

        // Test 1: Synchronous reset
        @(negedge clk);
        rst = 1;
        serial_in = 1'b1;

        @(posedge clk);
        #1;

        if (parallel_out !== 4'b0000) begin
            $display("Fail: Synchronous reset test, parallel_out=%b", parallel_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Synchronous reset test");
        

        // Test 2: First shift
        @(negedge clk);
        rst = 0;
        serial_in = 1'b1;

        @(posedge clk);
        #1;

        if (parallel_out !== 4'b1000) begin
            $display("Fail: First shift test, parallel_out=%b", parallel_out);
            errors = errors + 1;
        end
        else
            $display("Pass: First shift test");


        // Test 3: Second shift
        @(negedge clk);
        serial_in = 1'b0;

        @(posedge clk);
        #1;

        if (parallel_out !== 4'b0100) begin
            $display("Fail: Second shift test, parallel_out=%b", parallel_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Second shift test");


        // Test 4: Third shift
        @(negedge clk);
        serial_in = 1'b1;

        // Check that output does not change immediately
        #1;

        if (parallel_out !== 4'b0100) begin
            $display("Fail: Value retention test, parallel_out=%b", parallel_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Value retention test");

        // Now wait for the rising edge
        @(posedge clk);
        #1;

        if (parallel_out !== 4'b1010) begin
            $display("Fail: Third shift test, parallel_out=%b", parallel_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Third shift test");


        // Test 5: Fourth shift
        @(negedge clk);
        serial_in = 1'b1;

        @(posedge clk);
        #1;

        if (parallel_out !== 4'b1101) begin
            $display("Fail: Fourth shift test, parallel_out=%b", parallel_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Fourth shift test");


        // Test 6: Fifth shift
        @(negedge clk);
        serial_in = 1'b0;

        @(posedge clk);
        #1;

        if (parallel_out !== 4'b0110) begin
            $display("Fail: Fifth shift test, parallel_out=%b", parallel_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Fifth shift test");


        // Display final verification result
        if(errors == 0)
            $display("ALL TESTS PASSED");
        else
            $display("TESTS FAILED: %0d errors", errors);
        
        $finish;
    end

endmodule