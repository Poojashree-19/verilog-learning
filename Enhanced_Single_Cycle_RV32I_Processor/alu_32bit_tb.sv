`timescale 1ns/1ps

module alu_32bit_tb;

    logic [31:0] operand_a;
    logic [31:0] operand_b;
    logic [3:0]  alu_control;

    logic [31:0] result;
    logic Zero;
    logic less_than;
    logic less_than_u;

    // DUT
    alu_32bit uut (
        .operand_a(operand_a),
        .operand_b(operand_b),
        .alu_control(alu_control),
        .result(result),
        .Zero(Zero),
        .less_than(less_than),
        .less_than_u(less_than_u)
    );

    initial begin

         // Generate waveform
    $dumpfile("alu_32bit_tb.vcd");
    $dumpvars(0, alu_32bit_tb);
     $display("Time\tCtrl\tA\t\tB\t\tResult\t\tZero\tLT\tLTU");
        $monitor("%0t\t%b\t%0d\t%0d\t%0d\t%b\t%b\t%b",
                 $time, alu_control, operand_a, operand_b,
                 result, Zero, less_than, less_than_u);

        // ADD
        operand_a = 20;
        operand_b = 10;
        alu_control = 4'b0000;
        #10;

        // SUB
        alu_control = 4'b0001;
        #10;

        // AND
        operand_a = 32'hF0F0F0F0;
        operand_b = 32'h0F0F0F0F;
        alu_control = 4'b0010;
        #10;

        // OR
        alu_control = 4'b0011;
        #10;

        // XOR
        alu_control = 4'b0100;
        #10;

        // SLL
        operand_a = 8;
        operand_b = 2;
        alu_control = 4'b0101;
        #10;

        // SRL
        operand_a = 32'h20;
        operand_b = 2;
        alu_control = 4'b0110;
        #10;

        // SRA
        operand_a = -32'sd16;
        operand_b = 2;
        alu_control = 4'b0111;
        #10;

        // SLT (signed)
        operand_a = -5;
        operand_b = 10;
        alu_control = 4'b1000;
        #10;

        // SLTU (unsigned)
        operand_a = 5;
        operand_b = 10;
        alu_control = 4'b1001;
        #10;

        // Equal comparison
        operand_a = 25;
        operand_b = 25;
        alu_control = 4'b0001;
        #10;

        // Signed comparison
        operand_a = -20;
        operand_b = 10;
        alu_control = 4'b0001;
        #10;

        // Unsigned comparison
        operand_a = 32'hFFFFFFFF;
        operand_b = 32'd1;
        alu_control = 4'b0001;
        #10;

        $finish;

    end

endmodule
