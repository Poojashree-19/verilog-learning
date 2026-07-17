module branch_decision(

    input logic        Branch,

    input logic [2:0]  funct3,

    input logic        Zero,
    input logic        less_than,
    input logic        less_than_u,

    output logic       PCSrc

);

always_comb begin

    PCSrc = 1'b0;

    if (Branch) begin

        case (funct3)

            // BEQ
            3'b000:
                PCSrc = Zero;

            // BNE
            3'b001:
                PCSrc = ~Zero;

            // BLT
            3'b100:
                PCSrc = less_than;

            // BGE
            3'b101:
                PCSrc = ~less_than;

            // BLTU
            3'b110:
                PCSrc = less_than_u;

            // BGEU
            3'b111:
                PCSrc = ~less_than_u;

            default:
                PCSrc = 1'b0;

        endcase

    end

end

endmodule
