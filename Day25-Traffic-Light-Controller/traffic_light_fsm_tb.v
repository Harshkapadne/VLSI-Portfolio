`timescale 1ns/1ps

module traffic_light_fsm_tb;

    reg clk;
    reg rst;
    reg timer_done;

    wire ns_red;
    wire ns_yellow;
    wire ns_green;

    wire ew_red;
    wire ew_yellow;
    wire ew_green;

    integer errors;

    // State declarations for verification
    localparam NS_GREEN  = 2'b00;
    localparam NS_YELLOW = 2'b01;
    localparam EW_GREEN  = 2'b10;
    localparam EW_YELLOW = 2'b11;

    traffic_light_fsm dut (
        .clk(clk),
        .rst(rst),
        .timer_done(timer_done),

        .ns_red(ns_red),
        .ns_yellow(ns_yellow),
        .ns_green(ns_green),

        .ew_red(ew_red),
        .ew_yellow(ew_yellow),
        .ew_green(ew_green)
    );

    // Generate clock
    always #5 clk = ~clk;

    initial begin

        $dumpfile("traffic_light_fsm.vcd");
        $dumpvars(0, traffic_light_fsm_tb);

        clk = 0;
        rst = 0;
        timer_done = 0;
        errors = 0;

        // Test 1: Synchronous reset
        @(negedge clk);
        rst = 1'b1;

        @(posedge clk);
        #1;

        // Check internal state
        if (dut.state !== NS_GREEN) begin
            $display("Fail: Internal state reset test, expected=%b, dut.state=%b", NS_GREEN, dut.state);
            errors = errors + 1;
        end
        else
            $display("Pass: Internal state reset test");
        
        // Check external output
        if ({ns_red, ns_yellow, ns_green, ew_red, ew_yellow, ew_green} !== 6'b001100) begin
            $display("Fail: External output reset test, expected=%b, output=%b", 6'b001100, {ns_red, ns_yellow, ns_green, ew_red, ew_yellow, ew_green});
            errors = errors + 1;
        end
        else
            $display("Pass: External output reset test");

        // Test 2: Timer not completed in NS_GREEN
        @(negedge clk);
        rst = 1'b0;
        timer_done = 1'b0;

        @(posedge clk);
        #1;

        // Check internal state
        if (dut.state !== NS_GREEN) begin
            $display("Fail: Internal state Timer not completed in NS_GREEN test, expected=%b, dut.state=%b", NS_GREEN, dut.state);
            errors = errors + 1;
        end
        else
            $display("Pass: Internal state Timer not completed in NS_GREEN test");
        
        // Check external output
        if ({ns_red, ns_yellow, ns_green, ew_red, ew_yellow, ew_green} !== 6'b001100) begin
            $display("Fail: External output Timer not completed in NS_GREEN test, expected=%b, output=%b", 6'b001100, {ns_red, ns_yellow, ns_green, ew_red, ew_yellow, ew_green});
            errors = errors + 1;
        end
        else
            $display("Pass: External output Timer not completed in NS_GREEN test");

        // Test 3: Timer completed in NS_GREEN
        @(negedge clk);
        timer_done = 1'b1;

        @(posedge clk);
        #1;

        // Check internal state
        if (dut.state !== NS_YELLOW) begin
            $display("Fail: Internal state Timer completed in NS_GREEN test, expected=%b, dut.state=%b", NS_YELLOW, dut.state);
            errors = errors + 1;
        end
        else
            $display("Pass: Internal state Timer completed in NS_GREEN test");
        
        // Check external output
        if ({ns_red, ns_yellow, ns_green, ew_red, ew_yellow, ew_green} !== 6'b010100) begin
            $display("Fail: External output Timer completed in NS_GREEN test, expected=%b, output=%b", 6'b010100, {ns_red, ns_yellow, ns_green, ew_red, ew_yellow, ew_green});
            errors = errors + 1;
        end
        else
            $display("Pass: External output Timer completed in NS_GREEN test");

        // Test 4: Timer not completed in NS_YELLOW
        @(negedge clk);
        timer_done = 1'b0;

        @(posedge clk);
        #1;

        // Check internal state
        if (dut.state !== NS_YELLOW) begin
            $display("Fail: Internal state Timer not completed in NS_YELLOW test, expected=%b, dut.state=%b", NS_YELLOW, dut.state);
            errors = errors + 1;
        end
        else
            $display("Pass: Internal state Timer not completed in NS_YELLOW test");
        
        // Check external output
        if ({ns_red, ns_yellow, ns_green, ew_red, ew_yellow, ew_green} !== 6'b010100) begin
            $display("Fail: External output Timer not completed in NS_YELLOW test, expected=%b, output=%b", 6'b010100, {ns_red, ns_yellow, ns_green, ew_red, ew_yellow, ew_green});
            errors = errors + 1;
        end
        else
            $display("Pass: External output Timer not completed in NS_YELLOW test");

        // Test 5: Timer completed in NS_YELLOW
        @(negedge clk);
        timer_done = 1'b1;

        @(posedge clk);
        #1;

        // Check internal state
        if (dut.state !== EW_GREEN) begin
            $display("Fail: Internal state Timer completed in NS_YELLOW test, expected=%b, dut.state=%b", EW_GREEN, dut.state);
            errors = errors + 1;
        end
        else
            $display("Pass: Internal state Timer completed in NS_YELLOW test");
        
        // Check external output
        if ({ns_red, ns_yellow, ns_green, ew_red, ew_yellow, ew_green} !== 6'b100001) begin
            $display("Fail: External output Timer completed in NS_YELLOW test, expected=%b, output=%b", 6'b100001, {ns_red, ns_yellow, ns_green, ew_red, ew_yellow, ew_green});
            errors = errors + 1;
        end
        else
            $display("Pass: External output Timer completed in NS_YELLOW test");

        // Test 6: Timer not completed in EW_GREEN
        @(negedge clk);
        timer_done = 1'b0;

        @(posedge clk);
        #1;

        // Check internal state
        if (dut.state !== EW_GREEN) begin
            $display("Fail: Internal state Timer not completed in EW_GREEN test, expected=%b, dut.state=%b", EW_GREEN, dut.state);
            errors = errors + 1;
        end
        else
            $display("Pass: Internal state Timer not completed in EW_GREEN test");
        
        // Check external output
        if ({ns_red, ns_yellow, ns_green, ew_red, ew_yellow, ew_green} !== 6'b100001) begin
            $display("Fail: External output Timer not completed in EW_GREEN test, expected=%b, output=%b", 6'b100001, {ns_red, ns_yellow, ns_green, ew_red, ew_yellow, ew_green});
            errors = errors + 1;
        end
        else
            $display("Pass: External output Timer not completed in EW_GREEN test");

        // Test 7: Timer completed in EW_GREEN
        @(negedge clk);
        timer_done = 1'b1;

        @(posedge clk);
        #1;

        // Check internal state
        if (dut.state !== EW_YELLOW) begin
            $display("Fail: Internal state Timer completed in EW_GREEN test, expected=%b, dut.state=%b", EW_YELLOW, dut.state);
            errors = errors + 1;
        end
        else
            $display("Pass: Internal state Timer completed in EW_GREEN test");
        
        // Check external output
        if ({ns_red, ns_yellow, ns_green, ew_red, ew_yellow, ew_green} !== 6'b100010) begin
            $display("Fail: External output Timer completed in EW_GREEN test, expected=%b, output=%b", 6'b100010, {ns_red, ns_yellow, ns_green, ew_red, ew_yellow, ew_green});
            errors = errors + 1;
        end
        else
            $display("Pass: External output Timer completed in EW_GREEN test");

        // Test 8: Timer not completed in EW_YELLOW
        @(negedge clk);
        timer_done = 1'b0;

        @(posedge clk);
        #1;

        // Check internal state
        if (dut.state !== EW_YELLOW) begin
            $display("Fail: Internal state Timer not completed in EW_YELLOW test, expected=%b, dut.state=%b", EW_YELLOW, dut.state);
            errors = errors + 1;
        end
        else
            $display("Pass: Internal state Timer not completed in EW_YELLOW test");
        
        // Check external output
        if ({ns_red, ns_yellow, ns_green, ew_red, ew_yellow, ew_green} !== 6'b100010) begin
            $display("Fail: External output Timer not completed in EW_YELLOW test, expected=%b, output=%b", 6'b100010, {ns_red, ns_yellow, ns_green, ew_red, ew_yellow, ew_green});
            errors = errors + 1;
        end
        else
            $display("Pass: External output Timer not completed in EW_YELLOW test");

        // Test 9: Timer completed in EW_YELLOW
        @(negedge clk);
        timer_done = 1'b1;

        @(posedge clk);
        #1;

        // Check internal state
        if (dut.state !== NS_GREEN) begin
            $display("Fail: Internal state Timer completed in EW_YELLOW test, expected=%b, dut.state=%b", NS_GREEN, dut.state);
            errors = errors + 1;
        end
        else
            $display("Pass: Internal state Timer completed in EW_YELLOW test");
        
        // Check external output
        if ({ns_red, ns_yellow, ns_green, ew_red, ew_yellow, ew_green} !== 6'b001100) begin
            $display("Fail: External output Timer completed in EW_YELLOW test, expected=%b, output=%b", 6'b001100, {ns_red, ns_yellow, ns_green, ew_red, ew_yellow, ew_green});
            errors = errors + 1;
        end
        else
            $display("Pass: External output Timer completed in EW_YELLOW test");

        // Test 10: Reset during EW_GREEN
        // NS_GREEN -> NS_YELLOW
        @(negedge clk);
        timer_done = 1'b1;

        @(posedge clk);

        // NS_YELLOW -> EW_GREEN
        @(negedge clk);
        timer_done = 1'b1;

        @(posedge clk);

        // Apply reset during EW_GREEN
        @(negedge clk);
        rst = 1'b1;
        timer_done = 1'b1;
        #1;

        // Check internal state
        if (dut.state !== EW_GREEN) begin
            $display("Fail: Internal state before clock during EW_GREEN reset test, expected=%b, dut.state=%b", EW_GREEN, dut.state);
            errors = errors + 1;
        end
        else
            $display("Pass: Internal state before clock during EW_GREEN reset test");
        
        // Check external output
        if ({ns_red, ns_yellow, ns_green, ew_red, ew_yellow, ew_green} !== 6'b100001) begin
            $display("Fail: External output before clock during EW_GREEN reset test, expected=%b, output=%b", 6'b100001, {ns_red, ns_yellow, ns_green, ew_red, ew_yellow, ew_green});
            errors = errors + 1;
        end
        else
            $display("Pass: External output before clock during EW_GREEN reset test");

        @(posedge clk);
        #1;

        // Check internal state
        if (dut.state !== NS_GREEN) begin
            $display("Fail: Internal state after clock during EW_GREEN reset test, expected=%b, dut.state=%b", NS_GREEN, dut.state);
            errors = errors + 1;
        end
        else
            $display("Pass: Internal state after clock during EW_GREEN reset test");
        
        // Check external output
        if ({ns_red, ns_yellow, ns_green, ew_red, ew_yellow, ew_green} !== 6'b001100) begin
            $display("Fail: External output after clock during EW_GREEN reset test, expected=%b, output=%b", 6'b001100, {ns_red, ns_yellow, ns_green, ew_red, ew_yellow, ew_green});
            errors = errors + 1;
        end
        else
            $display("Pass: External output after clock during EW_GREEN reset test");
        
        // Additional safety verification
        if (ns_green && ew_green) begin
            $display("FAIL: Both roads are GREEN simultaneously!");
            errors = errors + 1;
        end
        else
            $display("PASS: No simultaneous GREEN signals");

        // Final verification result
        if (errors == 0)
            $display("ALL TESTS PASSED");
        else
            $display("TESTS FAILED: %0d errors", errors);

        $finish;

    end

endmodule
