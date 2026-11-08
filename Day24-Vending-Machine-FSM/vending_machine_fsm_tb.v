`timescale 1ns/1ps

module vending_machine_fsm_tb;

    reg clk;
    reg rst;
    reg coin;
    wire dispense;

    integer errors;

    // State declarations for verification
    localparam IDLE     = 2'b00;
    localparam HAVE_5   = 2'b01;
    localparam DISPENSE = 2'b10;

    vending_machine_fsm dut (
        .clk(clk),
        .rst(rst),
        .coin(coin),
        .dispense(dispense)
    );

    // Generate clock
    always #5 clk = ~clk;

    initial begin
        $dumpfile("vending_machine_fsm.vcd");
        $dumpvars(0, vending_machine_fsm_tb);

        clk = 0;
        rst = 0;
        coin = 0;
        errors = 0;

        // Test 1: Synchronous reset
        @(negedge clk);
        rst = 1'b1;

        @(posedge clk);
        #1;

        // Check internal state
        if (dut.state !== IDLE) begin
            $display("Fail: Internal state reset test, expected=%b, dut.state=%b", IDLE, dut.state);
            errors = errors + 1;
        end
        else
            $display("Pass: Internal state reset test");
        
        // Check external output
        if (dispense !== 1'b0) begin
            $display("Fail: External output reset test, dispense=%b", dispense);
            errors = errors + 1;
        end
        else
            $display("Pass: External output reset test");

        // Test 2: No coin inserted
        @(negedge clk);
        rst = 1'b0;
        coin = 1'b0;

        @(posedge clk);
        #1;

        // Check internal state
        if (dut.state !== IDLE) begin
            $display("Fail: Internal state No coin inserted test, expected=%b, dut.state=%b", IDLE, dut.state);
            errors = errors + 1;
        end
        else
            $display("Pass: Internal state No coin inserted test");
        
        // Check external output
        if (dispense !== 1'b0) begin
            $display("Fail: External output No coin inserted test, dispense=%b", dispense);
            errors = errors + 1;
        end
        else
            $display("Pass: External output No coin inserted test");

        // Test 3: First coin inserted
        @(negedge clk);
        coin = 1'b1;

        @(posedge clk);
        #1;

        // Check internal state
        if (dut.state !== HAVE_5) begin
            $display("Fail: Internal state First coin inserted test, expected=%b, dut.state=%b", HAVE_5, dut.state);
            errors = errors + 1;
        end
        else
            $display("Pass: Internal state First coin inserted test");
        
        // Check external output
        if (dispense !== 1'b0) begin
            $display("Fail: External output First coin inserted test, dispense=%b", dispense);
            errors = errors + 1;
        end
        else
            $display("Pass: External output First coin inserted test");

        // Test 4: Wait for second coin
        @(negedge clk);
        coin = 1'b0;

        @(posedge clk);
        #1;

        // Check internal state
        if (dut.state !== HAVE_5) begin
            $display("Fail: Internal state Wait for second coin test, expected=%b, dut.state=%b",  HAVE_5, dut.state);
            errors = errors + 1;
        end
        else
            $display("Pass: Internal state Wait for second coin test");
        
        // Check external output
        if (dispense !== 1'b0) begin
            $display("Fail: External output Wait for second coin test, dispense=%b", dispense);
            errors = errors + 1;
        end
        else
            $display("Pass: External output Wait for second coin test");

        // Test 5: Second coin inserted
        @(negedge clk);
        coin = 1'b1;

        @(posedge clk);
        #1;

        // Check internal state
        if (dut.state !== DISPENSE) begin
            $display("Fail: Internal state Second coin inserted test, expected=%b, dut.state=%b", DISPENSE, dut.state);
            errors = errors + 1;
        end
        else
            $display("Pass: Internal state Second coin inserted test");
        
        // Check external output
        if (dispense !== 1'b1) begin
            $display("Fail: External output Second coin inserted test, dispense=%b", dispense);
            errors = errors + 1;
        end
        else
            $display("Pass: External output Second coin inserted test");

        // Test 6: Automatic return to IDLE
        @(negedge clk);
        coin = 1'b0;

        @(posedge clk);
        #1;

        // Check internal state
        if (dut.state !== IDLE) begin
            $display("Fail: Internal state Automatic return to IDLE test, expected=%b, dut.state=%b", IDLE, dut.state);
            errors = errors + 1;
        end
        else
            $display("Pass: Internal state Automatic return to IDLE test");
        
        // Check external output
        if (dispense !== 1'b0) begin
            $display("Fail: External output Automatic return to IDLE test, dispense=%b", dispense);
            errors = errors + 1;
        end
        else
            $display("Pass: External output Automatic return to IDLE test");

        // Test 7: Another transaction
        @(negedge clk);
        coin = 1'b1;

        @(posedge clk);
        #1;

        // Check internal state
        if (dut.state !== HAVE_5) begin
            $display("Fail: Internal state Another transaction test, expected=%b, dut.state=%b", HAVE_5, dut.state);
            errors = errors + 1;
        end
        else
            $display("Pass: Internal state Another transaction test");
        
        // Check external output
        if (dispense !== 1'b0) begin
            $display("Fail: External output Another transaction test, dispense=%b", dispense);
            errors = errors + 1;
        end
        else
            $display("Pass: External output Another transaction test");

        // Test 8: Complete second transaction
        // First, deassert coin and remain in HAVE_5
        @(negedge clk);
        coin = 1'b0;

        @(posedge clk);
        #1;

        // Now insert the second coin
        @(negedge clk);
        coin = 1'b1;

        @(posedge clk);
        #1;

        // Check internal state
        if (dut.state !== DISPENSE) begin
            $display("Fail: Internal state Complete second transaction test, expected=%b, dut.state=%b", DISPENSE, dut.state);
            errors = errors + 1;
        end
        else
            $display("Pass: Internal state Complete second transaction test");
        
        // Check external output
        if (dispense !== 1'b1) begin
            $display("Fail: External output Complete second transaction test, dispense=%b", dispense);
            errors = errors + 1;
        end
        else
            $display("Pass: External output Complete second transaction test");

        // Additional test: Reset during incomplete transaction
        // First return to IDLE from DISPENSE
        @(negedge clk);
        coin = 1'b0;

        @(posedge clk);

        // Insert first coin: IDLE -> HAVE_5
        @(negedge clk);
        coin = 1'b1;

        @(posedge clk);

        // Assert reset while in HAVE_5
        @(negedge clk);
        rst = 1'b1;
        coin = 1'b0;

        @(posedge clk);
        #1;

        // Check internal state
        if (dut.state !== IDLE) begin
            $display("Fail: Internal state Reset during incomplete transaction test, expected=%b, dut.state=%b", IDLE, dut.state);
            errors = errors + 1;
        end
        else
            $display("Pass: Internal state Reset during incomplete transaction test");

        // Check external output
        if (dispense !== 1'b0) begin
            $display("Fail: External output Reset during incomplete transaction test, dispense=%b", dispense);
            errors = errors + 1;
        end
        else
            $display("Pass: External output Reset during incomplete transaction test");
        
        @(negedge clk);
        rst = 1'b0;

        // Additional test: Reset during DISPENSE state
        // Insert first coin: IDLE -> HAVE_5
        @(negedge clk);
        coin = 1'b1;

        @(posedge clk);

        // First, deassert coin and remain in HAVE_5
        @(negedge clk);
        coin = 1'b0;

        @(posedge clk);
        #1;

        // Now insert the second coin
        // Insert second coin: HAVE_5 -> DISPENSE
        @(negedge clk);
        coin = 1'b1;

        @(posedge clk);

        // Assert reset while in DISPENSE
        @(negedge clk);
        rst = 1'b1;
        coin = 1'b0;

        @(posedge clk);
        #1;

        // Check internal state
        if (dut.state !== IDLE) begin
            $display("Fail: Internal state Reset during DISPENSE state test, expected=%b, dut.state=%b", IDLE, dut.state);
            errors = errors + 1;
        end
        else
            $display("Pass: Internal state Reset during DISPENSE state test");

        // Check external output
        if (dispense !== 1'b0) begin
            $display("Fail: External output Reset during DISPENSE state test, dispense=%b", dispense);
            errors = errors + 1;
        end
        else
            $display("Pass: External output Reset during DISPENSE state test");
        
        @(negedge clk);
        rst = 1'b0;

        // Display final verification result
        if (errors == 0)
            $display("ALL TESTS PASSED");
        else
            $display("TESTS FAILED: %0d errors", errors);

        $finish;
    end

endmodule