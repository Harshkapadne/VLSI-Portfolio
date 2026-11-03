`timescale 1ns/1ps

module bidirectional_shift_register_4bit_tb;

    reg clk;
    reg rst;
    reg direction;
    reg serial_in;
    wire [3:0] parallel_out;

    integer errors;

    bidirectional_shift_register_4bit dut (
        .clk(clk),
        .rst(rst),
        .direction(direction),
        .serial_in(serial_in),
        .parallel_out(parallel_out)
    );

    // Generate the clock
    always #5 clk = ~clk;

    initial begin
        $dumpfile("bidirectional_shift_register_4bit.vcd");
        $dumpvars(0, bidirectional_shift_register_4bit_tb);

        clk = 0;
        rst = 0;
        direction = 1;
        serial_in = 0;
        errors = 0;

        // Test 1: Synchronous reset
        @(negedge clk);
        rst = 1;
        serial_in = 1'b0;

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


        // Test 2: First right shift
        @(negedge clk);
        rst = 0;
        serial_in = 1'b1;

        @(posedge clk);
        #1;

        // Check internal 4-bit register
        if (dut.shift_reg !== 4'b1000) begin
            $display("Fail: First right shift test, dut.shift_reg=%b", dut.shift_reg);
            errors = errors + 1;
        end
        else
            $display("Pass: First right shift test");
        
        // Check external parallel output
        if (parallel_out !== 4'b1000) begin
            $display("Fail: Parallel output First right shift test, parallel_out=%b", parallel_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Parallel output First right shift test");


        // Test 3: Second right shift
        @(negedge clk);
        serial_in = 1'b0;

        @(posedge clk);
        #1;

        // Check internal 4-bit register
        if (dut.shift_reg !== 4'b0100) begin
            $display("Fail: Second right shift test, dut.shift_reg=%b", dut.shift_reg);
            errors = errors + 1;
        end
        else
            $display("Pass: Second right shift test");
        
        // Check external parallel output
        if (parallel_out !== 4'b0100) begin
            $display("Fail: Parallel output Second right shift test, parallel_out=%b", parallel_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Parallel output Second right shift test");


        // Test 4: Third right shift
        @(negedge clk);
        serial_in = 1'b1;

        @(posedge clk);
        #1;

        // Check internal 4-bit register
        if (dut.shift_reg !== 4'b1010) begin
            $display("Fail: Third right shift test, dut.shift_reg=%b", dut.shift_reg);
            errors = errors + 1;
        end
        else
            $display("Pass: Third right shift test");
        
        // Check external parallel output
        if (parallel_out !== 4'b1010) begin
            $display("Fail: Parallel output Third right shift test, parallel_out=%b", parallel_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Parallel output Third right shift test");


        // Test 5: First left shift
        @(negedge clk);
        direction = 0;
        serial_in = 1'b1;

        @(posedge clk);
        #1;

        // Check internal 4-bit register
        if (dut.shift_reg !== 4'b0101) begin
            $display("Fail: First left shift test, dut.shift_reg=%b", dut.shift_reg);
            errors = errors + 1;
        end
        else
            $display("Pass: First left shift test");
        
        // Check external parallel output
        if (parallel_out !== 4'b0101) begin
            $display("Fail: Parallel output First left shift test, parallel_out=%b", parallel_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Parallel output First left shift test");


        // Test 6: Second left shift
        @(negedge clk);
        serial_in = 1'b0;

        @(posedge clk);
        #1;

        // Check internal 4-bit register
        if (dut.shift_reg !== 4'b1010) begin
            $display("Fail: Second left shift test, dut.shift_reg=%b", dut.shift_reg);
            errors = errors + 1;
        end
        else
            $display("Pass: Second left shift test");
        
        // Check external parallel output
        if (parallel_out !== 4'b1010) begin
            $display("Fail: Parallel output Second left shift test, parallel_out=%b", parallel_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Parallel output Second left shift test");


        // Test 7: Switch to right shift
        @(negedge clk);
        direction = 1;
        serial_in = 1'b0;

        @(posedge clk);
        #1;

        // Check internal 4-bit register
        if (dut.shift_reg !== 4'b0101) begin
            $display("Fail: Switch to right shift test, dut.shift_reg=%b", dut.shift_reg);
            errors = errors + 1;
        end
        else
            $display("Pass: Switch to right shift test");
        
        // Check external parallel output
        if (parallel_out !== 4'b0101) begin
            $display("Fail: Parallel output Switch to right shift test, parallel_out=%b", parallel_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Parallel output Switch to right shift test");


        // Test 8: Switch to left shift
        @(negedge clk);
        direction = 0;
        serial_in = 1'b1;

        @(posedge clk);
        #1;

        // Check internal 4-bit register
        if (dut.shift_reg !== 4'b1011) begin
            $display("Fail: Switch to left shift test, dut.shift_reg=%b", dut.shift_reg);
            errors = errors + 1;
        end
        else
            $display("Pass: Switch to left shift test");
        
        // Check external parallel output
        if (parallel_out !== 4'b1011) begin
            $display("Fail: Parallel output Switch to left shift test, parallel_out=%b", parallel_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Parallel output Switch to left shift test");


        // Additional test: Direction change retention
        @(negedge clk);
        direction = 1;
        serial_in = 1'b1;
        #1;

        // Check internal 4-bit register
        if (dut.shift_reg !== 4'b1011) begin
            $display("Fail: Direction change retention test, dut.shift_reg=%b", dut.shift_reg);
            errors = errors + 1;
        end
        else
            $display("Pass: Direction change retention test");
        
        // Check external parallel output
        if (parallel_out !== 4'b1011) begin
            $display("Fail: Parallel output Direction change retention test, parallel_out=%b", parallel_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Parallel output Direction change retention test");

        @(posedge clk);
        #1;

        // Check internal 4-bit register
        if (dut.shift_reg !== 4'b1101) begin
            $display("Fail: Right shift test, dut.shift_reg=%b", dut.shift_reg);
            errors = errors + 1;
        end
        else
            $display("Pass: Right shift test");
        
        // Check external parallel output
        if (parallel_out !== 4'b1101) begin
            $display("Fail: Parallel output Right shift test, parallel_out=%b", parallel_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Parallel output Right shift test");


        // Additional test: Serial input change retention
        @(negedge clk);
        direction = 0;
        serial_in = 1'b0;
        #1;

        // Check internal 4-bit register
        if (dut.shift_reg !== 4'b1101) begin
            $display("Fail: Serial input change retention test, dut.shift_reg=%b", dut.shift_reg);
            errors = errors + 1;
        end
        else
            $display("Pass: Serial input change retention test");
        
        // Check external parallel output
        if (parallel_out !== 4'b1101) begin
            $display("Fail: Parallel output Serial input change retention test, parallel_out=%b", parallel_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Parallel output Serial input change retention test");

        @(posedge clk);
        #1;

        // Check internal 4-bit register
        if (dut.shift_reg !== 4'b1010) begin
            $display("Fail: Left shift test, dut.shift_reg=%b", dut.shift_reg);
            errors = errors + 1;
        end
        else
            $display("Pass: Left shift test");
        
        // Check external parallel output
        if (parallel_out !== 4'b1010) begin
            $display("Fail: Parallel output Left shift test, parallel_out=%b", parallel_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Parallel output Left shift test");

        // Display final verification result
        if (errors == 0)
            $display("ALL TESTS PASSED");
        else
            $display("TESTS FAILED: %0d errors", errors);

        $finish;
    end

endmodule