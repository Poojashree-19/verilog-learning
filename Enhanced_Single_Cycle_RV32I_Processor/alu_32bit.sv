module alu_32bit(

    input  logic [31:0] operand_a,
    input  logic [31:0] operand_b,
    input  logic [3:0]  alu_control,

    output logic [31:0] result,
    output logic        Zero,
    output logic        less_than,
    output logic        less_than_u

);

always_comb begin

    case (alu_control)

        // ADD
        4'b0000:
            result = operand_a + operand_b;

        // SUB
        4'b0001:
            result = operand_a - operand_b;

        // AND
        4'b0010:
            result = operand_a & operand_b;

        // OR
        4'b0011:
            result = operand_a | operand_b;

        // XOR
        4'b0100:
            result = operand_a ^ operand_b;

        // SLL
        4'b0101:
            result = operand_a << operand_b[4:0];

        // SRL
        4'b0110:
            result = operand_a >> operand_b[4:0];

        // SRA
        4'b0111:
            result = $signed(operand_a) >>> operand_b[4:0];

        // SLT
        4'b1000:
            result = ($signed(operand_a) < $signed(operand_b))
                     ? 32'd1 : 32'd0;

        // SLTU
        4'b1001:
            result = (operand_a < operand_b)
                     ? 32'd1 : 32'd0;

        default:
            result = 32'd0;

    endcase

end

assign Zero        = (result == 32'd0);

assign less_than   = ($signed(operand_a) < $signed(operand_b));

assign less_than_u = (operand_a < operand_b);

endmodule
