`timescale 1ns/1ps
module mux_tb;

reg i0,i1,s;
wire y;

mux2to1 dut(
    .i0(i0),
    .i1(i1),
    .s(s),
    .y(y)
);

integer i;

initial begin
        $dumpfile("mux.vcd");
        $dumpvars(0, mux_tb);

        for (i = 0; i < 8; i = i + 1) begin
            {i0, i1, s} = i;
            #10;

            if (y !== (s ? i1 : i0))
                $display("FAIL: i0=%b i1=%b s=%b y=%b",
                         i0, i1, s, y);
            else
                $display("PASS: i0=%b i1=%b s=%b y=%b",
                         i0, i1, s, y);
        end

        $finish;
    end

endmodule