module pipeline_reg (

    input  logic        clk,
    input  logic        reset,

    input  logic [7:0]  a,
    input  logic [7:0]  b,
    input  logic [2:0]  opcode,

    output logic [7:0]  a_reg,
    output logic [7:0]  b_reg,
    output logic [2:0]  opcode_reg

);

always_ff @(posedge clk) begin

    if (reset) begin
        a_reg      <= 8'd0;
        b_reg      <= 8'd0;
        opcode_reg <= 3'd0;
    end

    else begin
        a_reg      <= a;
        b_reg      <= b;
        opcode_reg <= opcode;
    end

end

endmodule

module alu_8bit (
    input  logic [7:0] a,
    input  logic [7:0] b,
    input  logic [2:0] opcode,
    output logic [7:0] result
);

always_comb begin
    case (opcode)
        3'b000: result = a + b;  // ADD
        3'b001: result = a - b;  // SUB
        3'b010: result = a & b;  // AND
        3'b011: result = a | b;  // OR
        3'b100: result = a ^ b;  // XOR
        default: result = 8'b00000000;
    endcase
end

endmodule
module pipelined_alu (

    input  logic        clk,
    input  logic        reset,

    input  logic [7:0]  a,
    input  logic [7:0]  b,
    input  logic [2:0]  opcode,

    output logic [7:0]  result

);

    logic [7:0] a_pipe;
    logic [7:0] b_pipe;
    logic [2:0] op_pipe;

    pipeline_reg pipe1 (

        .clk(clk),
        .reset(reset),

        .a(a),
        .b(b),
        .opcode(opcode),

        .a_reg(a_pipe),
        .b_reg(b_pipe),
        .opcode_reg(op_pipe)

    );

    alu_8bit alu1 (

        .a(a_pipe),
        .b(b_pipe),
        .opcode(op_pipe),

        .result(result)

    );

endmodule
