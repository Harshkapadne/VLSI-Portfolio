`timescale 1ns/1ps

module mux4_case_tb;

    reg [3:0] d;
    reg [1:0] s;
    wire y;
    reg expected;
    integer i;
    integer errors;
    mux4_case dut (
        .d(d),
        .s(s),
        .y(y)
    );
    initial begin
        $dumpfile("mux4_case.vcd");
        $dumpvars(0, mux4_case_tb);

        errors = 0;

        for (i = 0; i < 64; i = i + 1) begin
            {d,s}=i;
            #1;

            expected = (s[1] ? (s[0] ? d[3] : d[2]) : (s[0] ? d[1] : d[0]));

            if (y !== expected) begin
                $display("Fail : inputs=%b, y=%b, expected=%b" , {d,s}, y, expected);
                errors = errors + 1;
            end

        end
        if (errors == 0)
            $display("PASS: All 64 combinations tested successfully.");
        else
            $display("Fail: %0d errors detected", errors);
        $finish;
    end
endmodule

