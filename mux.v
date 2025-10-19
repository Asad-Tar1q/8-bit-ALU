module alu8 (
    input wire [7:0] a,
    input wire [7:0] b,
    input wire [2:0] op,
    output reg [7:0]  y,
    output reg zero,
    output reg carry,
    output reg overflow
);
    always @(*) begin
        case(op)
            3'b000: {carry, y} = a + b;
            3'b001: {carry, y} = a - b;
            3'b011: y = a & b;
            3'b010: y = a | b;
            3'b100: y = a ^ b;
            3'b101: y = ~a;
            3'b110: y = a << 1;
            3'b111: y = a >> 1;
            default: y = 8'b0;
        endcase

        // Set carry and overflow for add/sub only
        if (op == 3'b000) begin
            overflow = (~a[7] & ~b[7] & y[7]) | (a[7] & b[7] & ~y[7]);
        end else if (op == 3'b001) begin
            overflow = (~a[7] & b[7] & y[7]) | (a[7] & ~b[7] & ~y[7]);
        end else begin
            carry = 0;
            overflow = 0;
        end

        zero = (y == 8'b0);
    end
endmodule