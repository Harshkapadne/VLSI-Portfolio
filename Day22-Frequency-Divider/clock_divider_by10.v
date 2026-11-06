module clock_divider_by10 (
    input wire clk,
    input wire rst,
    output reg clk_out
);

    reg [2:0] count;

    always @(posedge clk) begin
        if (rst) begin
            count <= 3'b000;
            clk_out <= 1'b0;
        end
        else if (count == 3'd4) begin
            count <= 3'b000;
            clk_out <= ~clk_out;
        end
        else
            count <= count + 3'd1;
    end

endmodule