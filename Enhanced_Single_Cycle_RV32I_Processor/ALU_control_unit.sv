module alu_control(

    input  logic [1:0] ALUOp,
    input  logic [2:0] funct3,
    input  logic [6:0] funct7,

    output logic [3:0] alu_control

);

always_comb begin

    case (ALUOp)

        // Memory Instructions (LW, SW)
        // ALU performs ADD
        2'b00:
            alu_control = 4'b0000;

        // Branch Instructions (BEQ)
        // ALU performs SUB
        2'b01:
            alu_control = 4'b0001;

        // R-Type Instructions
        2'b10: begin

            case (funct3)

                // ADD / SUB
                3'b000: begin
                    if (funct7 == 7'b0000000)
                        alu_control = 4'b0000;   // ADD
                    else if (funct7 == 7'b0100000)
                        alu_control = 4'b0001;   // SUB
                    else
                        alu_control = 4'b0000;
                end

                // SLL
                3'b001:
                    alu_control = 4'b0101;

                // SLT
                3'b010:
                    alu_control = 4'b1000;

                // SLTU
                3'b011:
                    alu_control = 4'b1001;

                // XOR
                3'b100:
                    alu_control = 4'b0100;

                // SRL / SRA
                3'b101: begin
                    if (funct7 == 7'b0000000)
                        alu_control = 4'b0110;   // SRL
                    else if (funct7 == 7'b0100000)
                        alu_control = 4'b0111;   // SRA
                    else
                        alu_control = 4'b0000;
                end

                // OR
                3'b110:
                    alu_control = 4'b0011;

                // AND
                3'b111:
                    alu_control = 4'b0010;

                default:
                    alu_control = 4'b0000;

            endcase

        end

        // I-Type ALU Instructions (ADDI)
        2'b11:
            alu_control = 4'b0000;

        default:
            alu_control = 4'b0000;

    endcase

end

endmodule
