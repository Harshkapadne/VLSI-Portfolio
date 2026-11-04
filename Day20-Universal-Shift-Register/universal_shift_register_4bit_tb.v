`timescale 1ns/1ps

module universal_shift_register_4bit_tb;

    reg clk;
    reg rst;
    reg [1:0] mode;
    reg serial_right_in;
    reg serial_left_in;
    reg [3:0] parallel_in;

    wire [3:0] parallel_out;

    integer errors;

    universal_shift_register_4bit dut (
        .clk(clk),
        .rst(rst),
        .mode(mode),
        .serial_right_in(serial_right_in),
        .serial_left_in(serial_left_in),
        .parallel_in(parallel_in),
        .parallel_out(parallel_out)
    );

    // Generate the clock
    always #5 clk = ~clk;

    initial begin
        $dumpfile("universal_shift_register_4bit.vcd");
        $dumpvars(0, universal_shift_register_4bit_tb);

        clk = 0;
        rst = 0;
        mode = 2'b00;
        serial_right_in = 0;
        serial_left_in = 0;
        parallel_in = 4'b0000;
        errors = 0;

        // Test 1: Synchronous reset
        @(negedge clk);
        rst = 1;

        @(posedge clk);
        #1;

        // Check internal 4-bit register
        if (dut.shift_reg !== 4'b0000) begin
            $display("Fail: Reset test, dut.shift_reg=%b", dut.shift_reg);
            errors = errors + 1;
        end
        else
            $display("Pass: Internal register reset test");
        
        // Check external parallel output
        if (parallel_out !== 4'b0000) begin
            $display("Fail: Parallel output reset test, parallel_out=%b", parallel_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Parallel output reset test");


        // Test 2: Parallel load 1010
        @(negedge clk);
        rst = 0;
        mode = 2'b11;
        parallel_in = 4'b1010;

        @(posedge clk);
        #1;

        // Check internal 4-bit register
        if (dut.shift_reg !== 4'b1010) begin
            $display("Fail: Parallel load test, dut.shift_reg=%b", dut.shift_reg);
            errors = errors + 1;
        end
        else
            $display("Pass: Internal register Parallel load test");
        
        // Check external parallel output
        if (parallel_out !== 4'b1010) begin
            $display("Fail: Parallel output Parallel load test, parallel_out=%b", parallel_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Parallel output Parallel load test");


        // Test 3: Hold operation
        @(negedge clk);
        mode = 2'b00;
        parallel_in = 4'b1100;

        @(posedge clk);
        #1;

        // Check internal 4-bit register
        if (dut.shift_reg !== 4'b1010) begin
            $display("Fail: Hold operation test, dut.shift_reg=%b", dut.shift_reg);
            errors = errors + 1;
        end
        else
            $display("Pass: Internal register Hold operation test");
        
        // Check external parallel output
        if (parallel_out !== 4'b1010) begin
            $display("Fail: Parallel output Hold operation test, parallel_out=%b", parallel_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Parallel output Hold operation test");


        // Test 4: Right shift with input 1
        @(negedge clk);
        mode = 2'b01;
        serial_right_in = 1'b1;

        @(posedge clk);
        #1;

        // Check internal 4-bit register
        if (dut.shift_reg !== 4'b1101) begin
            $display("Fail: Right shift with input 1 test, dut.shift_reg=%b", dut.shift_reg);
            errors = errors + 1;
        end
        else
            $display("Pass: Internal register Right shift with input 1 test");
        
        // Check external parallel output
        if (parallel_out !== 4'b1101) begin
            $display("Fail: Parallel output Right shift with input 1 test, parallel_out=%b", parallel_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Parallel output Right shift with input 1 test");


        // Test 5: Right shift with input 0
        @(negedge clk);
        mode = 2'b01;
        serial_right_in = 1'b0;

        @(posedge clk);
        #1;

        // Check internal 4-bit register
        if (dut.shift_reg !== 4'b0110) begin
            $display("Fail: Right shift with input 0 test, dut.shift_reg=%b", dut.shift_reg);
            errors = errors + 1;
        end
        else
            $display("Pass: Internal register Right shift with input 0 test");
        
        // Check external parallel output
        if (parallel_out !== 4'b0110) begin
            $display("Fail: Parallel output Right shift with input 0 test, parallel_out=%b", parallel_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Parallel output Right shift with input 0 test");


        // Test 6: Left shift with input 0
        @(negedge clk);
        mode = 2'b10;
        serial_left_in = 1'b0;

        @(posedge clk);
        #1;

        // Check internal 4-bit register
        if (dut.shift_reg !== 4'b1100) begin
            $display("Fail: Left shift with input 0 test, dut.shift_reg=%b", dut.shift_reg);
            errors = errors + 1;
        end
        else
            $display("Pass: Internal register Left shift with input 0 test");
        
        // Check external parallel output
        if (parallel_out !== 4'b1100) begin
            $display("Fail: Parallel output Left shift with input 0 test, parallel_out=%b", parallel_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Parallel output Left shift with input 0 test");


        // Test 7: Left shift with input 1
        @(negedge clk);
        mode = 2'b10;
        serial_left_in = 1'b1;

        @(posedge clk);
        #1;

        // Check internal 4-bit register
        if (dut.shift_reg !== 4'b1001) begin
            $display("Fail: Left shift with input 1 test, dut.shift_reg=%b", dut.shift_reg);
            errors = errors + 1;
        end
        else
            $display("Pass: Internal register Left shift with input 1 test");
        
        // Check external parallel output
        if (parallel_out !== 4'b1001) begin
            $display("Fail: Parallel output Left shift with input 1 test, parallel_out=%b", parallel_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Parallel output Left shift with input 1 test");


        // Test 8: Parallel load 1100
        @(negedge clk);
        mode = 2'b11;
        parallel_in = 4'b1100;

        @(posedge clk);
        #1;

        // Check internal 4-bit register
        if (dut.shift_reg !== 4'b1100) begin
            $display("Fail: Again Parallel load test, dut.shift_reg=%b", dut.shift_reg);
            errors = errors + 1;
        end
        else
            $display("Pass: Again Internal register Parallel load test");
        
        // Check external parallel output
        if (parallel_out !== 4'b1100) begin
            $display("Fail: Again Parallel output Parallel load test, parallel_out=%b", parallel_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Again Parallel output Parallel load test");


        // Additional test: Direction/mode change retention
        @(negedge clk);
        mode = 2'b01;
        serial_right_in = 1'b1;
        #1;

        // Check internal 4-bit register
        if (dut.shift_reg !== 4'b1100) begin
            $display("Fail: Direction/mode change retention test, dut.shift_reg=%b", dut.shift_reg);
            errors = errors + 1;
        end
        else
            $display("Pass: Internal register Direction/mode change retention test");
        
        // Check external parallel output
        if (parallel_out !== 4'b1100) begin
            $display("Fail: Parallel output Direction/mode change retention test, parallel_out=%b", parallel_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Parallel output Direction/mode change retention test");

        @(posedge clk);
        #1;

        // Check internal 4-bit register
        if (dut.shift_reg !== 4'b1110) begin
            $display("Fail: After Direction/mode change retention test, dut.shift_reg=%b", dut.shift_reg);
            errors = errors + 1;
        end
        else
            $display("Pass: After Internal register Direction/mode change retention test");
        
        // Check external parallel output
        if (parallel_out !== 4'b1110) begin
            $display("Fail: After Parallel output Direction/mode change retention test, parallel_out=%b", parallel_out);
            errors = errors + 1;
        end
        else
            $display("Pass: After Parallel output Direction/mode change retention test");


        // Additional test: Reset priority
        @(negedge clk);
        rst = 1;
        mode = 2'b11;
        parallel_in = 4'b1111;

        @(posedge clk);
        #1;

        // Check internal 4-bit register
        if (dut.shift_reg !== 4'b0000) begin
            $display("Fail: Reset priority test, dut.shift_reg=%b", dut.shift_reg);
            errors = errors + 1;
        end
        else
            $display("Pass: Internal register Reset priority test");
        
        // Check external parallel output
        if (parallel_out !== 4'b0000) begin
            $display("Fail: Parallel output Reset priority test, parallel_out=%b", parallel_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Parallel output Reset priority test");


        // Display final verification result
        if (errors == 0)
            $display("ALL TESTS PASSED");
        else
            $display("TESTS FAILED: %0d errors", errors);

        $finish;
    end

endmodule