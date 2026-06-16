`timescale 1ns/1ps

module alu_8bit_tb;

logic [7:0] a, b;
logic [2:0] opcode;
logic [7:0] result;

alu_8bit uut(
    .a(a),
    .b(b),
    .opcode(opcode),
    .result(result)
);

initial begin

    a = 8'd10;
    b = 8'd5;

    opcode = 3'b000;
    #10;
    $display("ADD Result = %d", result);

    opcode = 3'b001;
    #10;
    $display("SUB Result = %d", result);

    opcode = 3'b010;
    #10;
    $display("AND Result = %d", result);

    opcode = 3'b011;
    #10;
    $display("OR Result = %d", result);

    opcode = 3'b100;
    #10;
    $display("XOR Result = %d", result);

    opcode = 3'b101;
    #10;
    $display("Default Result = %d", result);

    $finish;

end

endmodule
