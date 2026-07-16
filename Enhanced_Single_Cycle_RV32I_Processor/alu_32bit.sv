module alu_32bit(

    input  logic [31:0] operand_a,
    input  logic [31:0] operand_b,

    input  logic [3:0] alu_control,

    output logic [31:0] result,
    output logic        Zero

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

        // Shift Left Logical (SLL)
        4'b0101:
            result = operand_a << operand_b[4:0];

        // Shift Right Logical (SRL)
        4'b0110:
            result = operand_a >> operand_b[4:0];

        // Shift Right Arithmetic (SRA)
        4'b0111:
            result = $signed(operand_a) >>> operand_b[4:0];

        // Set Less Than (SLT)
        4'b1000:
            result = ($signed(operand_a) < $signed(operand_b)) ? 32'd1 : 32'd0;

        // Set Less Than Unsigned (SLTU)
        4'b1001:
            result = (operand_a < operand_b) ? 32'd1 : 32'd0;

        // Default
        default:
            result = 32'd0;

    endcase

end

// Zero Flag
assign Zero = (result == 32'd0);

endmodule
