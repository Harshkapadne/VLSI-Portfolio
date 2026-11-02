`timescale 1ns/1ps

module piso_shift_register_4bit_tb;

    reg clk;
    reg rst;
    reg load;
    reg [3:0] parallel_in;
    wire serial_out;

    integer errors;

    piso_shift_register_4bit dut (
        .clk(clk),
        .rst(rst),
        .load(load),
        .parallel_in(parallel_in),
        .serial_out(serial_out)
    );

    // Generate the clock
    always #5 clk = ~clk;

    initial begin
        $dumpfile("piso_shift_register_4bit.vcd");
        $dumpvars(0, piso_shift_register_4bit_tb);

        clk = 0;
        rst = 0;
        load = 0;
        parallel_in = 4'b0000;
        errors = 0;

        // Test 1: Synchronous reset
        @(negedge clk);
        rst = 1;
        load = 0;
        parallel_in = 4'b0000;

        @(posedge clk);
        #1;

        // Check internal 4-bit register
        if (dut.shift_reg !== 4'b0000) begin
            $display("Fail: Reset test, dut.shift_reg=%b", dut.shift_reg);
            errors = errors + 1;
        end
        else
            $display("Pass: Internal register reset test");
        
        // Check external serial output
        if (serial_out !== 1'b0) begin
            $display("Fail: Serial output reset test, serial_out=%b", serial_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Serial output reset test");
        

        // Test 2: Parallel load 1011
        @(negedge clk);
        rst = 0;
        load = 1;
        parallel_in = 4'b1011;

        @(posedge clk);
        #1;

        // Check internal 4-bit register
        if (dut.shift_reg !== 4'b1011) begin
            $display("Fail: Parallel load test, dut.shift_reg=%b", dut.shift_reg);
            errors = errors + 1;
        end
        else
            $display("Pass: Parallel load test");
        
        // Check external serial output
        if (serial_out !== 1'b1) begin
            $display("Fail: Parallel load Serial output test, serial_out=%b", serial_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Parallel load Serial output test");
        

        // Test 3: First right shift
        @(negedge clk);
        rst = 0;
        load = 0;

        @(posedge clk);
        #1;

        // Check internal 4-bit register
        if (dut.shift_reg !== 4'b0101) begin
            $display("Fail: First right shift test, dut.shift_reg=%b", dut.shift_reg);
            errors = errors + 1;
        end
        else
            $display("Pass: First right shift test");
        
        // Check external serial output
        if (serial_out !== 1'b1) begin
            $display("Fail: First right shift Serial output test, serial_out=%b", serial_out);
            errors = errors + 1;
        end
        else
            $display("Pass: First right shift Serial output test");
        

        // Test 4: Second right shift
        @(posedge clk);
        #1;

        // Check internal 4-bit register
        if (dut.shift_reg !== 4'b0010) begin
            $display("Fail: Second right shift test, dut.shift_reg=%b", dut.shift_reg);
            errors = errors + 1;
        end
        else
            $display("Pass: Second right shift test");
        
        // Check external serial output
        if (serial_out !== 1'b0) begin
            $display("Fail: Second right shift Serial output test, serial_out=%b", serial_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Second right shift Serial output test");
        

        // Test 5: Third right shift
        @(posedge clk);
        #1;

        // Check internal 4-bit register
        if (dut.shift_reg !== 4'b0001) begin
            $display("Fail: Third right shift test, dut.shift_reg=%b", dut.shift_reg);
            errors = errors + 1;
        end
        else
            $display("Pass: Third right shift test");
        
        // Check external serial output
        if (serial_out !== 1'b1) begin
            $display("Fail: Third right shift Serial output test, serial_out=%b", serial_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Third right shift Serial output test");
        

        // Test 6: Fourth right shift
        @(posedge clk);
        #1;

        // Check internal 4-bit register
        if (dut.shift_reg !== 4'b0000) begin
            $display("Fail: Fourth right shift test, dut.shift_reg=%b", dut.shift_reg);
            errors = errors + 1;
        end
        else
            $display("Pass: Fourth right shift test");
        
        // Check external serial output
        if (serial_out !== 1'b0) begin
            $display("Fail: Fourth right shift Serial output test, serial_out=%b", serial_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Fourth right shift Serial output test");
        

        // Test 7: Parallel load 1100
        @(negedge clk);
        load = 1;
        parallel_in = 4'b1100;

        @(posedge clk);
        #1;

        // Check internal 4-bit register
        if (dut.shift_reg !== 4'b1100) begin
            $display("Fail: Again Parallel load test, dut.shift_reg=%b", dut.shift_reg);
            errors = errors + 1;
        end
        else
            $display("Pass: Again Parallel load test");
        
        // Check external serial output
        if (serial_out !== 1'b0) begin
            $display("Fail: Again Parallel load Serial output test, serial_out=%b", serial_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Again Parallel load Serial output test");
        

        // Test 8: First right shift after loading 1100
        @(negedge clk);
        load = 0;

        @(posedge clk);
        #1;

        // Check internal 4-bit register
        if (dut.shift_reg !== 4'b0110) begin
            $display("Fail: Again First right shift test, dut.shift_reg=%b", dut.shift_reg);
            errors = errors + 1;
        end
        else
            $display("Pass: Again First right shift test");
        
        // Check external serial output
        if (serial_out !== 1'b0) begin
            $display("Fail: Again First right shift Serial output test, serial_out=%b", serial_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Again First right shift Serial output test");

        // Test 9: Verify no immediate loading
        @(negedge clk);
        load = 0;
        parallel_in = 4'b1100;
        #1;

        // Check internal 4-bit register
        if (dut.shift_reg !== 4'b0110) begin
            $display("Fail: Immediate loading test, dut.shift_reg=%b", dut.shift_reg);
            errors = errors + 1;
        end
        else
            $display("Pass: Register holds value before rising edge");
        
        // Check external serial output
        if (serial_out !== 1'b0) begin
            $display("Fail: Serial output retention test, serial_out=%b", serial_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Serial output retention test");

        @(posedge clk);
        #1;

        // Check internal 4-bit register
        if (dut.shift_reg !== 4'b0011) begin
            $display("Fail: Shift with load inactive test, dut.shift_reg=%b", dut.shift_reg);
            errors = errors + 1;
        end
        else
            $display("Pass: Shift with load inactive test");
        
        // Check external serial output
        if (serial_out !== 1'b1) begin
            $display("Fail: Shift with load inactive Serial output test, serial_out=%b", serial_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Shift with load inactive Serial output test");

        // Test 10: Verify reset priority over load
        @(negedge clk);
        rst = 1;
        load = 1;
        parallel_in = 4'b1010;

        @(posedge clk);
        #1;

        // Check internal 4-bit register
        if (dut.shift_reg !== 4'b0000) begin
            $display("Fail: Reset priority over load test, dut.shift_reg=%b", dut.shift_reg);
            errors = errors + 1;
        end
        else
            $display("Pass: Reset priority over load test");
        
        // Check external serial output
        if (serial_out !== 1'b0) begin
            $display("Fail: Reset priority over load Serial output test, serial_out=%b", serial_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Reset priority over load Serial output test");

        // Display final verification result
        if (errors == 0)
            $display("ALL TESTS PASSED");
        else
            $display("TESTS FAILED: %0d errors", errors);

        $finish;
    end

endmodule