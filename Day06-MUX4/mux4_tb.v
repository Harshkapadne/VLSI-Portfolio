`timescale 1ns/1ps
module mux4_tb;

reg d0,d1,d2,d3,s1,s0;
wire y;

mux4to1 dut (
    .d0(d0),
    .d1(d1),
    .d2(d2),
    .d3(d3),
    .s0(s0),
    .s1(s1),
    .y(y)
);

integer i;

initial begin
    $dumpfile("mux4.vcd");
    $dumpvars(0, mux4_tb);
    for (i = 0; i < 64; i = i + 1) 
    begin
        {d3,d2,d1,d0,s1,s0} = i;
        #1;
        
        if (y !== (s1 ? (s0 ? d3 : d2) : (s0 ? d1 : d0)))
        $display("FAIL at i=%0d", i);
    end
        $display("Simulation complete: 64 cases checked.");
        $finish;
end
endmodule