`timescale 1ns/1ps

module alu_8bit_tb;

    logic [7:0] a;
    logic [7:0] b;
    logic [2:0] opcode;

    logic [7:0] result;
    logic z_flag;
    logic c_flag;
    logic v_flag;
    logic n_flag;
    logic p_flag;

    alu_8bit dut(
        .a(a),
        .b(b),
        .opcode(opcode),
        .result(result),
        .z_flag(z_flag),
        .c_flag(c_flag),
        .v_flag(v_flag),
        .n_flag(n_flag),
        .p_flag(p_flag)
    );

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, alu_8bit_tb);

        $monitor("time=%0t a=%d b=%d op=%b result=%d Z=%b C=%b V=%b N=%b P=%b",
                  $time,a,b,opcode,result,
                  z_flag,c_flag,v_flag,n_flag,p_flag);

        // ADD
        a = 8'd10;
        b = 8'd5;
        opcode = 3'b000;
        #10;

        // SUB
        a = 8'd20;
        b = 8'd10;
        opcode = 3'b001;
        #10;

        // AND
        a = 8'b10101010;
        b = 8'b11001100;
        opcode = 3'b010;
        #10;

        // OR
        a = 8'b10101010;
        b = 8'b11001100;
        opcode = 3'b011;
        #10;

        // XOR
        a = 8'b10101010;
        b = 8'b11001100;
        opcode = 3'b100;
        #10;

        // Zero Flag Test
        a = 8'd5;
        b = 8'd5;
        opcode = 3'b001;
        #10;

        // Carry Flag Test
        a = 8'd255;
        b = 8'd1;
        opcode = 3'b000;
        #10;

        // Overflow Flag Test
        a = 8'd127;
        b = 8'd1;
        opcode = 3'b000;
        #10;

        $finish;
    end

endmodule
