module universal_shift_register_4bit (
    input wire clk,
    input wire rst,
    input wire [1:0] mode,
    input wire serial_right_in,
    input wire serial_left_in,
    input wire [3:0] parallel_in,
    output wire [3:0] parallel_out
);

    reg [3:0] shift_reg;

    always @(posedge clk) begin
        if (rst)
            shift_reg <= 4'b0000;
        else begin
            case(mode)
                2'b00: shift_reg <= shift_reg;
                2'b01: shift_reg <= {serial_right_in, shift_reg[3:1]};
                2'b10: shift_reg <= {shift_reg[2:0], serial_left_in};
                2'b11: shift_reg <= parallel_in;
                default: shift_reg <= shift_reg;
            endcase
        end
    end

    assign parallel_out = shift_reg;

endmodule