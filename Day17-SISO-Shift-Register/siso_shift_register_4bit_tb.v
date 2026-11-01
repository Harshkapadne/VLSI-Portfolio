`timescale 1ns/1ps

module siso_shift_register_4bit_tb;

    reg clk;
    reg rst;
    reg serial_in;
    wire serial_out;

    integer errors;

    siso_shift_register_4bit dut (
        .clk(clk),
        .rst(rst),
        .serial_in(serial_in),
        .serial_out(serial_out)
    );

    // Generate the clock
    always #5 clk = ~clk;

    initial begin
        $dumpfile("siso_shift_register_4bit.vcd");
        $dumpvars(0, siso_shift_register_4bit_tb);

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


        // Test 2: First input bit = 1
        @(negedge clk);
        rst = 0;
        serial_in = 1'b1;

        @(posedge clk);
        #1;

        // Check internal 4-bit register
        if (dut.shift_reg !== 4'b1000) begin
            $display("Fail: First input bit test, dut.shift_reg=%b", dut.shift_reg);
            errors = errors + 1;
        end
        else
            $display("Pass: First input bit test");
        
        // Check external serial output
        if (serial_out !== 1'b0) begin
            $display("Fail: First serial output test, serial_out=%b", serial_out);
            errors = errors + 1;
        end
        else
            $display("Pass: First serial output test");


        // Test 3: Second input bit = 0
        @(negedge clk);
        serial_in = 1'b0;

        @(posedge clk);
        #1;

        // Check internal 4-bit register
        if (dut.shift_reg !== 4'b0100) begin
            $display("Fail: Second input bit test, dut.shift_reg=%b", dut.shift_reg);
            errors = errors + 1;
        end
        else
            $display("Pass: Second input bit test");
        
        // Check external serial output
        if (serial_out !== 1'b0) begin
            $display("Fail: Second serial output test, serial_out=%b", serial_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Second serial output test");


        // Test 4: Third input bit = 1
        @(negedge clk);
        serial_in = 1'b1;
        #1;

        if (dut.shift_reg !== 4'b0100) begin
            $display("Fail: Output retention test, dut.shift_reg=%b", dut.shift_reg);
            errors = errors + 1;
        end
        else
            $display("Pass: Output retention test");
        
        if (serial_out !== 1'b0) begin
            $display("Fail: Serial output retention test, serial_out=%b", serial_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Serial output retention test");

        @(posedge clk);
        #1;

        // Check internal 4-bit register
        if (dut.shift_reg !== 4'b1010) begin
            $display("Fail: Third input bit test, dut.shift_reg=%b", dut.shift_reg);
            errors = errors + 1;
        end
        else
            $display("Pass: Third input bit test");
        
        // Check external serial output
        if (serial_out !== 1'b0) begin
            $display("Fail: Third serial output test, serial_out=%b", serial_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Third serial output test");
        

        // Test 5: Fourth input bit = 1
        @(negedge clk);
        serial_in = 1'b1;

        @(posedge clk);
        #1;

        // Check internal 4-bit register
        if (dut.shift_reg !== 4'b1101) begin
            $display("Fail: Fourth input bit test, dut.shift_reg=%b", dut.shift_reg);
            errors = errors + 1;
        end
        else
            $display("Pass: Fourth input bit test");
        
        // Check external serial output
        if (serial_out !== 1'b1) begin
            $display("Fail: Fourth serial output test, serial_out=%b", serial_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Fourth serial output test");
        

        // Test 6: Fifth input bit = 0
        @(negedge clk);
        serial_in = 1'b0;

        @(posedge clk);
        #1;

        // Check internal 4-bit register
        if (dut.shift_reg !== 4'b0110) begin
            $display("Fail: Fifth input bit test, dut.shift_reg=%b", dut.shift_reg);
            errors = errors + 1;
        end
        else
            $display("Pass: Fifth input bit test");
        
        // Check external serial output
        if (serial_out !== 1'b0) begin
            $display("Fail: Fifth serial output test, serial_out=%b", serial_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Fifth serial output test");


        // Test 7: Sixth input bit = 0
        @(negedge clk);
        serial_in = 1'b0;

        @(posedge clk);
        #1;

        // Check internal 4-bit register
        if (dut.shift_reg !== 4'b0011) begin
            $display("Fail: Sixth input bit test, dut.shift_reg=%b", dut.shift_reg);
            errors = errors + 1;
        end
        else
            $display("Pass: Sixth input bit test");
        
        // Check external serial output
        if (serial_out !== 1'b1) begin
            $display("Fail: Sixth serial output test, serial_out=%b", serial_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Sixth serial output test");


        // Test 8: Seventh input bit = 0
        @(negedge clk);
        serial_in = 1'b0;

        @(posedge clk);
        #1;

        // Check internal 4-bit register
        if (dut.shift_reg !== 4'b0001) begin
            $display("Fail: Seventh input bit test, dut.shift_reg=%b", dut.shift_reg);
            errors = errors + 1;
        end
        else
            $display("Pass: Seventh input bit test");
        
        // Check external serial output
        if (serial_out !== 1'b1) begin
            $display("Fail: Seventh serial output test, serial_out=%b", serial_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Seventh serial output test");
        

        // Test 9: Eighth input bit = 0
        @(negedge clk);
        serial_in = 1'b0;

        @(posedge clk);
        #1;

        // Check internal 4-bit register
        if (dut.shift_reg !== 4'b0000) begin
            $display("Fail: Eighth input bit test, dut.shift_reg=%b", dut.shift_reg);
            errors = errors + 1;
        end
        else
            $display("Pass: Eighth input bit test");
        
        // Check external serial output
        if (serial_out !== 1'b0) begin
            $display("Fail: Eighth serial output test, serial_out=%b", serial_out);
            errors = errors + 1;
        end
        else
            $display("Pass: Eighth serial output test");

        // Display final verification result
        if (errors == 0)
            $display("ALL TESTS PASSED");
        else
            $display("TESTS FAILED: %0d errors", errors);

        $finish;
    end

endmodule