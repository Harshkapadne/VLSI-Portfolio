module mux2to1 (
    input wire i0,
    input wire i1,
    input wire s,
    output wire y
);
    assign y = (~s & i0) | (s & i1);
endmodule