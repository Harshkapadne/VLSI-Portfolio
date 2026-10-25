`timescale 1ns/1ps
module mux2_proc_tb;
reg [1:0] d;
reg s;
wire y;
integer i;
integer errors;

mux2_proc dut(
    .d(d),
    .s(s),
    .y(y)
);

initial begin
    $dumpfile("mux2_proc.vcd");
    $dumpvars(0, mux2_proc_tb);

    errors = 0;
    for(i = 0;i < 8;i = i + 1) begin
        {d,s}=i;
        #1;

        if (y !== (s ? d[1] : d[0])) begin
        $display("FAIL: d0=%b d1=%b s=%b y=%b",d[0], d[1], s, y);
        errors = errors + 1;
        end
    end
    if(errors == 0)
        $display("PASS: all 8 cases passed");
    else
        $display("FAIL: %0d errors", errors);
    $finish;
    end
endmodule