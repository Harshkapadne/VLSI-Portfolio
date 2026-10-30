`timescale 1ns/1ps

module up_down_counter_4bit_tb;

    reg clk;
    reg rst;
    reg up_down;
    wire [3:0] count;

    integer errors;

    up_down_counter_4bit dut (
        .clk(clk),
        .rst(rst),
        .up_down(up_down),
        .count(count)
    );

    // Generate the clock
    always #5 clk = ~clk;

    initial begin
        $dumpfile("up_down_counter_4bit.vcd");
        $dumpvars(0, up_down_counter_4bit_tb);

        clk = 0;
        rst = 0;
        up_down = 1;
        errors = 0;

        //Test 1: Assert synchronous reset
        @(negedge clk);
        rst = 1;

        @(posedge clk);
        #1;

        if (count !== 4'b0000) begin
            $display("Fail: Assert synchronous reset test, count=%b", count);
            errors = errors + 1;
        end
        else
            $display("Pass: Assert synchronous reset test");
        

        //Test 2: Count upward once
        @(negedge clk);
        rst = 0;

        @(posedge clk);
        #1;

        if (count !== 4'b0001) begin
            $display("Fail: Count upward once test, count=%b", count);
            errors = errors + 1;
        end
        else
            $display("Pass: Count upward once test");
        

        //Test 3: Count upward again
        @(posedge clk);
        #1;

        if (count !== 4'b0010) begin
            $display("Fail: Count upward again test, count=%b", count);
            errors = errors + 1;
        end
        else
            $display("Pass: Count upward again test");
        

        //Test 4: Switch direction and count downward
        @(negedge clk);
        up_down = 0;

        // Verify that changing direction does not immediately change count
        #1;

        if (count !== 4'b0010) begin
            $display("Fail: Counter changed before rising edge, count=%b", count);
            errors = errors + 1;
        end
        else
            $display("Pass: Counter holds value before rising edge");

        @(posedge clk);
        #1;

        if (count !== 4'b0001) begin
            $display("Fail: Switch direction and count downward test, count=%b", count);
            errors = errors + 1;
        end
        else
            $display("Pass: Switch direction and count downward test");
        

        //Test 5: Continue downward
        @(posedge clk);
        #1;

        if (count !== 4'b0000) begin
            $display("Fail: Continue downward test, count=%b", count);
            errors = errors + 1;
        end
        else
            $display("Pass: Continue downward test");
        

        //Test 6: Count downward through zero
        @(posedge clk);
        #1;

        if (count !== 4'b1111) begin
            $display("Fail: Count downward through zero test, count=%b", count);
            errors = errors + 1;
        end
        else
            $display("Pass: Count downward through zero test");
        

        //Test 7: Switch direction and count upward
        @(negedge clk);
        up_down = 1;

        @(posedge clk);
        #1;

        if (count !== 4'b0000) begin
            $display("Fail: Switch direction and count upward test, count=%b", count);
            errors = errors + 1;
        end
        else
            $display("Pass: Switch direction and count upward test");
        

        // Display final verification result
        if (errors == 0)
            $display("ALL TESTS PASSED");
        else
            $display("TESTS FAILED: %0d errors", errors);

        $finish;
    end
endmodule