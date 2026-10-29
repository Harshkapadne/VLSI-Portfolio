`timescale 1ns/1ps

module down_counter_4bit_tb;
    reg clk;
    reg rst;
    wire [3:0] count;

    integer errors;
    integer i;

    down_counter_4bit dut (
        .clk(clk),
        .rst(rst),
        .count(count)
    );

    // Generate the clock
    always #5 clk = ~clk;

    initial begin
        $dumpfile("down_counter_4bit.vcd");
        $dumpvars(0, down_counter_4bit_tb);

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
        
        //Test 2: First decrement after reset
        @(negedge clk);
        rst = 0;

        @(posedge clk);
        #1;

        if (count !== 4'b1111) begin
            $display("Fail: First decrement after reset test, count=%b", count);
            errors = errors + 1;
        end
        else
            $display("Pass: First decrement after reset test");
        
        //Test 3: Second decrement
        @(posedge clk);
        #1;

        if (count !== 4'b1110) begin
            $display("Fail: Second decrement test, count=%b", count);
            errors = errors + 1;
        end
        else
            $display("Pass: Second decrement test");
        
        //Test 4: Underflow
        repeat(14) @(posedge clk);
        #1;

        if (count !== 4'b0000) begin
            $display("Fail: Counter did not reach 0000, count=%b", count);
            errors = errors + 1;
        end
        else
            $display("Pass: Counter reached 0000");
        
        // Test underflow: 0000 -> 1111
        @(posedge clk);
        #1;

        if (count !== 4'b1111) begin
            $display("Fail: Underflow test, count=%b", count);
            errors = errors + 1;
        end
        else
            $display("Pass: Underflow test");
        
        //Test 5: Multiple decrements
        if (count !== 4'b1111) begin
            $display("Fail: Starting value before multiple decrements, expected = 1111, actual=%b", count);
            errors = errors + 1;
        end
        else
            $display("Pass: Starting value before multiple decrements, count=%b", count);
                            
        for(i = 1; i <= 15; i = i + 1) begin
            @(posedge clk);
            #1;

            case (i)
                1: begin
                        if (count !== 4'b1110) begin
                            $display("Fail: Iteration 1, expected = 1110, actual=%b", count);
                            errors = errors + 1;
                        end
                        else
                            $display("Pass: Iteration 1, count=%b", count);
                    end
                2: begin
                        if (count !== 4'b1101) begin
                            $display("Fail: Iteration 2, expected = 1101, actual=%b", count);
                            errors = errors + 1;
                        end
                        else
                            $display("Pass: Iteration 2, count=%b", count);
                    end
                3: begin
                        if (count !== 4'b1100) begin
                            $display("Fail: Iteration 3, expected = 1100, actual=%b", count);
                            errors = errors + 1;
                        end
                        else
                            $display("Pass: Iteration 3, count=%b", count);
                    end
                4: begin
                        if (count !== 4'b1011) begin
                            $display("Fail: Iteration 4, expected = 1011, actual=%b", count);
                            errors = errors + 1;
                        end
                        else
                            $display("Pass: Iteration 4, count=%b", count);
                    end
                5: begin
                        if (count !== 4'b1010) begin
                            $display("Fail: Iteration 5, expected = 1010, actual=%b", count);
                            errors = errors + 1;
                        end
                        else
                            $display("Pass: Iteration 5, count=%b", count);
                    end
                6: begin
                        if (count !== 4'b1001) begin
                            $display("Fail: Iteration 6, expected = 1001, actual=%b", count);
                            errors = errors + 1;
                        end
                        else
                            $display("Pass: Iteration 6, count=%b", count);
                    end
                7: begin
                        if (count !== 4'b1000) begin
                            $display("Fail: Iteration 7, expected = 1000, actual=%b", count);
                            errors = errors + 1;
                        end
                        else
                            $display("Pass: Iteration 7, count=%b", count);
                    end
                8: begin
                        if (count !== 4'b0111) begin
                            $display("Fail: Iteration 8, expected = 0111, actual=%b", count);
                            errors = errors + 1;
                        end
                        else
                            $display("Pass: Iteration 8, count=%b", count);
                    end
                9: begin
                        if (count !== 4'b0110) begin
                            $display("Fail: Iteration 9, expected = 0110, actual=%b", count);
                            errors = errors + 1;
                        end
                        else
                            $display("Pass: Iteration 9, count=%b", count);
                    end
                10: begin
                        if (count !== 4'b0101) begin
                            $display("Fail: Iteration 10, expected = 0101, actual=%b", count);
                            errors = errors + 1;
                        end
                        else
                            $display("Pass: Iteration 10, count=%b", count);
                    end
                11: begin
                        if (count !== 4'b0100) begin
                            $display("Fail: Iteration 11, expected = 0100, actual=%b", count);
                            errors = errors + 1;
                        end
                        else
                            $display("Pass: Iteration 11, count=%b", count);
                    end
                12: begin
                        if (count !== 4'b0011) begin
                            $display("Fail: Iteration 12, expected = 0011, actual=%b", count);
                            errors = errors + 1;
                        end
                        else
                            $display("Pass: Iteration 12, count=%b", count);
                    end
                13: begin
                        if (count !== 4'b0010) begin
                            $display("Fail: Iteration 13, expected = 0010, actual=%b", count);
                            errors = errors + 1;
                        end
                        else
                            $display("Pass: Iteration 13, count=%b", count);
                    end
                14: begin
                        if (count !== 4'b0001) begin
                            $display("Fail: Iteration 14, expected = 0001, actual=%b", count);
                            errors = errors + 1;
                        end
                        else
                            $display("Pass: Iteration 14, count=%b", count);
                    end
                15: begin
                        if (count !== 4'b0000) begin
                            $display("Fail: Iteration 15, expected = 0000, actual=%b", count);
                            errors = errors + 1;
                        end
                        else
                            $display("Pass: Iteration 15, count=%b", count);
                    end
                default: begin
                        $display("Fail: Unexpected iteration value: %0d", i);
                        errors = errors + 1;
                    end
            endcase
        end

        // Display the final verification result
        if(errors == 0)
            $display("ALL TESTS PASSED");
        else
            $display("TESTS FAILED: %0d errors", errors);
        
        $finish;
    end
endmodule