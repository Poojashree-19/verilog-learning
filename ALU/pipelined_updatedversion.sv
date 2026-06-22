module pipeline_reg (

    input  logic       clk,
    input  logic       reset,
    input  logic       stall,
    input  logic       flush,

    input  logic [7:0] a,
    input  logic [7:0] b,
    input  logic [2:0] opcode,

    output logic [7:0] a_reg,
    output logic [7:0] b_reg,
    output logic [2:0] opcode_reg

);

always_ff @(posedge clk) begin

    // Highest priority: Reset
    if (reset) begin
        a_reg      <= 8'd0;
        b_reg      <= 8'd0;
        opcode_reg <= 3'd0;
    end

    // Second priority: Flush
    else if (flush) begin
        a_reg      <= 8'd0;
        b_reg      <= 8'd0;
        opcode_reg <= 3'd0;
    end

    // Third priority: Stall
    else if (stall) begin
        a_reg      <= a_reg;
        b_reg      <= b_reg;
        opcode_reg <= opcode_reg;
    end

    // Normal operation
    else begin
        a_reg      <= a;
        b_reg      <= b;
        opcode_reg <= opcode;
    end

end

endmodule
