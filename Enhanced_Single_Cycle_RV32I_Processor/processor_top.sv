`timescale 1ns/1ps
module program_counter (

    input  logic        clk,
    input  logic        reset,
    input  logic [31:0] next_pc,

    output logic [31:0] pc

);

always_ff @(posedge clk) begin

    if (reset)
        pc <= 32'd0;

    else
        pc <= next_pc;

end

endmodule

module next_pc_logic(

    input  logic [31:0] pc,
    input  logic [31:0] branch_target,
    input  logic        branch_taken,

    output logic [31:0] next_pc

);

always_comb begin

    if (branch_taken)
        next_pc = branch_target;

    else
        next_pc = pc + 32'd4;

end

endmodule

module instruction_memory(

    input  logic [31:0] address,
    output logic [31:0] instruction

);

    logic [31:0] memory [0:255];
    integer i;

    initial begin

        // Fill entire memory with NOPs
        for(i=0;i<256;i=i+1)
            memory[i] = 32'h00000013;

        // -------------------------------------------------
        // Test Program
        // -------------------------------------------------

        memory[0]  = 32'h00500093;   // ADDI x1,x0,5
        memory[1]  = 32'h00A00113;   // ADDI x2,x0,10
        memory[2]  = 32'h002081B3;   // ADD  x3,x1,x2
        memory[3]  = 32'h40110233;   // SUB  x4,x2,x1
        memory[4]  = 32'h0020F2B3;   // AND  x5,x1,x2
        memory[5]  = 32'h0020E333;   // OR   x6,x1,x2
        memory[6]  = 32'h00302023;   // SW   x3,0(x0)
        memory[7]  = 32'h00002383;   // LW   x7,0(x0)
        memory[8]  = 32'h00420463;   // BEQ  x1,x4,+8
        memory[9]  = 32'h06300413;   // ADDI x8,x0,99 (Skipped)
        memory[10] = 32'h02A00413;   // ADDI x8,x0,42
        memory[11] = 32'h00700493;   // ADDI x9,x0,7

    end

    assign instruction = memory[address[31:2]];

endmodule
module Register_file(

    input  logic        clk,
    input  logic        reset,

    input  logic        reg_write,

    input  logic [4:0]  rs1,
    input  logic [4:0]  rs2,
    input  logic [4:0]  rd,

    input  logic [31:0] write_data,

    output logic [31:0] read_data1,
    output logic [31:0] read_data2

);

    // -------------------------------------------------
    // 32 Registers (x0 - x31)
    // Each register is 32 bits wide
    // -------------------------------------------------

    logic [31:0] registers [0:31];

    integer i;

    // -------------------------------------------------
    // Write Operation
    // -------------------------------------------------

    always_ff @(posedge clk) begin

        if (reset) begin

            for (i = 0; i < 32; i = i + 1)
                registers[i] <= 32'd0;

        end

        else begin

            // x0 is always zero, so it cannot be written
            if (reg_write && (rd != 5'd0))
                registers[rd] <= write_data;

        end

    end

    // -------------------------------------------------
    // Read Operations
    // -------------------------------------------------

    assign read_data1 = (rs1 == 5'd0) ? 32'd0 : registers[rs1];

    assign read_data2 = (rs2 == 5'd0) ? 32'd0 : registers[rs2];

endmodule

module immediate_generator(

    input  logic [31:0] instruction,

    output logic [31:0] immediate

);

always_comb begin

    case (instruction[6:0])

        // I-Type : ADDI, LW
        7'b0010011,
        7'b0000011:
            immediate = {{20{instruction[31]}}, instruction[31:20]};

        // S-Type : SW
        7'b0100011:
            immediate = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};

        // B-Type : BEQ
        7'b1100011:
            immediate = {{19{instruction[31]}},
                          instruction[31],
                          instruction[7],
                          instruction[30:25],
                          instruction[11:8],
                          1'b0};

        // Unsupported instruction
        default:
            immediate = 32'd0;

    endcase

end

endmodule

module main_control_unit(

    input logic [6:0] opcode,

    output logic RegWrite,
    output logic MemRead,
    output logic MemWrite,
    output logic Branch,
    output logic ALUSrc,
    output logic MemtoReg,
    output logic [1:0] ALUOp

);

always_comb begin

    // Default Values
    RegWrite = 1'b0;
    MemRead  = 1'b0;
    MemWrite = 1'b0;
    Branch   = 1'b0;
    ALUSrc   = 1'b0;
    MemtoReg = 1'b0;
    ALUOp    = 2'b00;

    case (opcode)

        // -----------------------------------------
        // R-Type Instructions
        // ADD, SUB, AND, OR, XOR, SLL, SRL, SRA, SLT, SLTU
        // -----------------------------------------
        7'b0110011: begin
            RegWrite = 1'b1;
            ALUSrc   = 1'b0;
            ALUOp    = 2'b10;
        end

        // -----------------------------------------
        // Load Word (LW)
        // -----------------------------------------
        7'b0000011: begin
            RegWrite = 1'b1;
            MemRead  = 1'b1;
            ALUSrc   = 1'b1;
            MemtoReg = 1'b1;
            ALUOp    = 2'b00;
        end

        // -----------------------------------------
        // Store Word (SW)
        // -----------------------------------------
        7'b0100011: begin
            MemWrite = 1'b1;
            ALUSrc   = 1'b1;
            ALUOp    = 2'b00;
        end

        // -----------------------------------------
        // Branch Equal (BEQ)
        // -----------------------------------------
        7'b1100011: begin
            Branch = 1'b1;
            ALUSrc = 1'b0;
            ALUOp  = 2'b01;
        end

        // -----------------------------------------
        // ADD Immediate (ADDI)
        // -----------------------------------------
        7'b0010011: begin
            RegWrite = 1'b1;
            ALUSrc   = 1'b1;
            ALUOp    = 2'b11;
        end

        // -----------------------------------------
        // Default
        // -----------------------------------------
        default: begin
            RegWrite = 1'b0;
            MemRead  = 1'b0;
            MemWrite = 1'b0;
            Branch   = 1'b0;
            ALUSrc   = 1'b0;
            MemtoReg = 1'b0;
            ALUOp    = 2'b00;
        end

    endcase

end

endmodule

module alu_control(

    input  logic [1:0] ALUOp,
    input  logic [2:0] funct3,
    input  logic [6:0] funct7,

    output logic [3:0] alu_control

);

always_comb begin

    // Default assignment
    alu_control = 4'b0000;

    case (ALUOp)

        // -------------------------------------------------
        // Memory Instructions (LW, SW)
        // ALU performs ADD
        // -------------------------------------------------
        2'b00:
            alu_control = 4'b0000;

        // -------------------------------------------------
        // Branch Instructions (BEQ)
        // ALU performs SUB
        // -------------------------------------------------
        2'b01:
            alu_control = 4'b0001;

        // -------------------------------------------------
        // R-Type Instructions
        // -------------------------------------------------
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

        // -------------------------------------------------
        // I-Type Instructions
        // -------------------------------------------------
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

                // XORI
                3'b100:
                    alu_control = 4'b0100;

                // SRLI / SRAI
                3'b101: begin
                    if (funct7 == 7'b0000000)
                        alu_control = 4'b0110;   // SRLI
                    else if (funct7 == 7'b0100000)
                        alu_control = 4'b0111;   // SRAI
                    else
                        alu_control = 4'b0000;
                end

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

        // -------------------------------------------------
        // Default
        // -------------------------------------------------
        default:
            alu_control = 4'b0000;

    endcase

end

endmodule

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

module data_memory(

    input logic clk,
    input logic MemRead,
    input logic MemWrite,

    input logic [31:0] address,
    input logic [31:0] write_data,

    output logic [31:0] read_data

);

logic [31:0] memory [0:255];

integer i;

initial begin

    for(i=0;i<256;i=i+1)
        memory[i]=32'd0;

end

always_ff @(posedge clk) begin

    if(MemWrite)
        memory[address[31:2]] <= write_data;

end

assign read_data =
        (MemRead) ?
        memory[address[31:2]] :
        32'd0;

endmodule
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
module writeback_mux(

    input logic MemtoReg,

    input logic [31:0] alu_result,
    input logic [31:0] memory_data,

    output logic [31:0] write_back_data

);

    assign write_back_data =
        (MemtoReg) ? memory_data : alu_result;

endmodule



module datapath(

    input logic clk,
    input logic reset

);

    // -------------------------------------------------
    // Program Counter Signals
    // -------------------------------------------------

    logic [31:0] pc;
    logic [31:0] next_pc;
    logic [31:0] branch_target;

    // -------------------------------------------------
    // Instruction Memory
    // -------------------------------------------------

    logic [31:0] instruction;

    // -------------------------------------------------
    // Register File
    // -------------------------------------------------

    logic [31:0] read_data1;
    logic [31:0] read_data2;
    logic [31:0] write_back_data;

    // -------------------------------------------------
    // Immediate Generator
    // -------------------------------------------------

    logic [31:0] immediate;

    // -------------------------------------------------
    // ALU
    // -------------------------------------------------

    logic [31:0] alu_input2;
    logic [31:0] alu_result;

    logic Zero;
    logic less_than;      // ADD HERE
    logic less_than_u;    // ADD HERE

    // -------------------------------------------------
    // Data Memory
    // -------------------------------------------------

    logic [31:0] memory_data;

    // -------------------------------------------------
    // Control Signals
    // -------------------------------------------------

    logic RegWrite;
    logic MemRead;
    logic MemWrite;
    logic Branch;
    logic ALUSrc;
    logic MemtoReg;

    logic [1:0] ALUOp;
    logic [3:0] alu_control;

    // -------------------------------------------------
    // Branch Logic
    // -------------------------------------------------

    logic PCSrc;

    // -------------------------------------------------
    // Internal Connections
    // -------------------------------------------------

    assign alu_input2   = (ALUSrc) ? immediate : read_data2;

    assign branch_target = pc + immediate;

    // -------------------------------------------------
    // Program Counter
    // -------------------------------------------------

    program_counter pc_inst(

        .clk(clk),
        .reset(reset),
        .next_pc(next_pc),
        .pc(pc)

    );

    // -------------------------------------------------
    // Instruction Memory
    // -------------------------------------------------

    instruction_memory imem(

        .address(pc),
        .instruction(instruction)

    );

    // -------------------------------------------------
    // Main Control Unit
    // -------------------------------------------------

    main_control_unit control(

        .opcode(instruction[6:0]),

        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .Branch(Branch),
        .ALUSrc(ALUSrc),
        .MemtoReg(MemtoReg),
        .ALUOp(ALUOp)

    );

    // -------------------------------------------------
    // Register File
    // -------------------------------------------------

    Register_file rf(

        .clk(clk),
        .reset(reset),

        .reg_write(RegWrite),

        .rs1(instruction[19:15]),
        .rs2(instruction[24:20]),
        .rd(instruction[11:7]),

        .write_data(write_back_data),

        .read_data1(read_data1),
        .read_data2(read_data2)

    );
      // -------------------------------------------------
    // Immediate Generator
    // -------------------------------------------------

    immediate_generator imm_gen(

        .instruction(instruction),
        .immediate(immediate)

    );

    // -------------------------------------------------
    // ALU Control Unit
    // -------------------------------------------------

    alu_control alu_ctrl(

        .ALUOp(ALUOp),
        .funct3(instruction[14:12]),
        .funct7(instruction[31:25]),

        .alu_control(alu_control)

    );

    // -------------------------------------------------
    // 32-bit ALU
    // -------------------------------------------------
    alu_32bit alu(

    .operand_a(read_data1),
    .operand_b(alu_input2),
    .alu_control(alu_control),

    .result(alu_result),
    .Zero(Zero),
    .less_than(less_than),        // ADD THIS
    .less_than_u(less_than_u)     // ADD THIS

);
    // -------------------------------------------------
    // Data Memory
    // -------------------------------------------------

    data_memory dmem(

        .clk(clk),

        .MemRead(MemRead),
        .MemWrite(MemWrite),

        .address(alu_result),
        .write_data(read_data2),

        .read_data(memory_data)

    );

    // -------------------------------------------------
    // Branch Decision
    // -------------------------------------------------
 branch_decision branch(

    .Branch(Branch),
    .funct3(instruction[14:12]),  // ADD THIS
    .Zero(Zero),
    .less_than(less_than),        // ADD THIS
    .less_than_u(less_than_u),    // ADD THIS

    .PCSrc(PCSrc)

);

    // -------------------------------------------------
    // Writeback MUX
    // -------------------------------------------------

    writeback_mux wb_mux(

        .MemtoReg(MemtoReg),

        .alu_result(alu_result),
        .memory_data(memory_data),

        .write_back_data(write_back_data)

    );
      // -------------------------------------------------
    // Next PC Logic
    // -------------------------------------------------

    next_pc_logic next_pc_inst(

        .pc(pc),
        .branch_target(branch_target),
        .branch_taken(PCSrc),

        .next_pc(next_pc)

    );

endmodule


module processor_top(

    input logic clk,
    input logic reset

);

    //--------------------------------------------------
    // Datapath Instance
    //--------------------------------------------------

    datapath cpu(

        .clk(clk),
        .reset(reset)

    );

endmodule
