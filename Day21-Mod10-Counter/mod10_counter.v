module mod10_counter (
    input wire clk,
    input wire rst,
    output reg [3:0] count
);

    always @(posedge clk) begin
        if(rst)
            count <= 4'b0000;
        else if (count == 4'd9)
            count <= 4'b0000;
        else
            count <= count + 4'd1;
    end

endmodule