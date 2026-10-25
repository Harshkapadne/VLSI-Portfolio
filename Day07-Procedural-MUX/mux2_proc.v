module mux2_proc (
    input wire [1:0] d,
    input wire s,
    output reg y
);

    always @(*) begin
        if (s==1'b1)
            y = d[1];
        else
            y = d[0];
    end
endmodule