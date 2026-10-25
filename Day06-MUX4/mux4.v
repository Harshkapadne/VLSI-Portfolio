module mux4to1 (
    input wire d0,
    input wire d1,
    input wire d2,
    input wire d3,
    input wire s0,
    input wire s1,
    output wire y
);
// assign y = (~s1 & ~s0 & d0) | (~s1 & s0 & d1) | (s1 & ~s0 & d2) | (s1 & s0 & d3);
assign y = (s1 ? (s0 ? d3 : d2) : (s0 ? d1 : d0));
endmodule