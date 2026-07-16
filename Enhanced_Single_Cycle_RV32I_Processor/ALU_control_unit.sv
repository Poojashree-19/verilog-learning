module alu_control(

    input  logic [1:0] ALUOp,
    input  logic [2:0] funct3,
    input  logic [6:0] funct7,

    output logic [3:0] alu_control

);

always_comb begin

    case (ALUOp)

        // Memory Instructions (LW, SW)
        2'b00:
            alu_control = 4'b0000;

        // Branch Instructions (BEQ)
        2'b01:
            alu_control = 4'b0001;

        // R-Type Instructions
        2'b10: begin

            case (funct3)

                3'b000:
                    alu_control = (funct7 == 7'b0100000) ? 4'b0001 : 4'b0000;

                3'b001:
                    alu_control = 4'b0101;

                3'b010:
                    alu_control = 4'b1000;

                3'b011:
                    alu_control = 4'b1001;

                3'b100:
                    alu_control = 4'b0100;

                3'b101:
                    alu_control = (funct7 == 7'b0100000) ? 4'b0111 : 4'b0110;

                3'b110:
                    alu_control = 4'b0011;

                3'b111:
                    alu_control = 4'b0010;

                default:
                    alu_control = 4'b0000;

            endcase

        end

        // I-Type Instructions
        2'b11: begin

            case (funct3)

                // ADDI
                3'b000:
                    alu_control = 4'b0000;

                // SLLI
                3'b001:
                    alu_control = 4'b0101;

                // SLTI
                3'b010:
                    alu_control = 4'b1000;

                // SLTIU
                3'b011:
                    alu_control = 4'b1001;

                // XORI
                3'b100:
                    alu_control = 4'b0100;

                // SRLI / SRAI
                3'b101:
                    alu_control = (funct7[5]) ? 4'b0111 : 4'b0110;

                // ORI
                3'b110:
                    alu_control = 4'b0011;

                // ANDI
                3'b111:
                    alu_control = 4'b0010;

                default:
                    alu_control = 4'b0000;

            endcase

        end

        default:
            alu_control = 4'b0000;

    endcase

end

endmodule
