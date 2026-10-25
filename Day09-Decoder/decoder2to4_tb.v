`timescale 1ns/1ps

module decoder2to4_tb;
    reg a1, a0;
    wire [3:0] y;

    reg [3:0] expected;
    integer i;
    integer errors;

    decoder2to4 dut (
        .a1(a1),
        .a0(a0),
        .y(y)
    );

    initial begin 
        $dumpfile("decoder2to4.vcd");
        $dumpvars(0, decoder2to4_tb);

        errors = 0;

        for (i = 0; i < 4; i = i + 1) begin
            {a1,a0} = i;
            #1;

            expected = 4'b0001 << i;
            if (y !== expected) begin 
                $display("Fail: input = %b, y = %b, expected = %b", {a1,a0}, y, expected);
                errors = errors + 1;
            end
            else begin
                $display("PASS: input=%b, output=%b",{a1, a0}, y);
            end
        end
        $display("--------------------------------");
        $display("Total test cases: 4");
        $display("Failed test cases: %0d", errors);

        if(errors == 0)
            $display("FINAL RESULT: ALL TESTS PASSED");
        else
            $display("FINAL RESULT: TESTS FAILED");
        $finish;
    end
endmodule
