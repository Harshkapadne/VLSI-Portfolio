module up_down_counter_4bit (
    input wire clk,
    input wire rst,
    input wire up_down,
    output reg [3:0] count
);

    always @(posedge clk) begin
        if (rst)
            count <= 4'b0000;
        else begin
            if (up_down)
                count <= count + 1'b1;
            else
                count <= count - 1'b1;
        end
    end

endmodule