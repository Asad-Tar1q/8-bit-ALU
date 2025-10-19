`timescale 1ns / 1ps

module alu8_tb;

    reg  [7:0] a, b;
    reg  [2:0] op;
    wire [7:0] y;
    wire       zero, carry, overflow;

    alu8 uut (
        .a(a),
        .b(b),
        .op(op),
        .y(y),
        .zero(zero),
        .carry(carry),
        .overflow(overflow)
    );

    initial begin
        $dumpfile("alu8.vcd");
        $dumpvars(0, alu8_tb);

        // Test Addition
        a = 8'd15; b = 8'd10; op = 3'b000; #10;
        a = 8'd200; b = 8'd100; op = 3'b000; #10;

        // Test Subtraction
        a = 8'd50; b = 8'd20; op = 3'b001; #10;
        a = 8'd20; b = 8'd50; op = 3'b001; #10;

        // Test AND
        a = 8'b10101010; b = 8'b11001100; op = 3'b011; #10;

        // Test OR
        a = 8'b10101010; b = 8'b11001100; op = 3'b010; #10;

        // Test XOR
        a = 8'b10101010; b = 8'b11001100; op = 3'b100; #10;

        // Test NOT
        a = 8'b10101010; b = 8'b00000000; op = 3'b101; #10;

        // Test Shift Left
        a = 8'b00001111; b = 8'b00000000; op = 3'b110; #10;

        // Test Shift Right
        a = 8'b11110000; b = 8'b00000000; op = 3'b111; #10;

        $finish;
    end

    initial begin
        $monitor("time=%0t a=%b b=%b op=%b | y=%b zero=%b carry=%b overflow=%b",
                 $time, a, b, op, y, zero, carry, overflow);
    end

endmodule