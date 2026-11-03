module bidirectional_shift_register_4bit (
    input wire clk,
    input wire rst,
    input wire direction,
    input wire serial_in,
    output wire [3:0] parallel_out
);

    reg [3:0] shift_reg;

    always @(posedge clk) begin
        if (rst)
            shift_reg <= 4'b0000;
        else if (direction)
            shift_reg <= {serial_in, shift_reg[3:1]};
        else
            shift_reg <= {shift_reg[2:0], serial_in};
    end

    assign parallel_out = shift_reg;

endmodule