module instruction_memory(

    input  logic [31:0] address,

    output logic [31:0] instruction

);

    // -------------------------------------------------
    // 256 x 32-bit Instruction Memory
    // -------------------------------------------------

    logic [31:0] memory [0:255];

    integer i;

    // -------------------------------------------------
    // Initialize Instruction Memory
    // -------------------------------------------------

    initial begin

        // Initialize all memory locations to NOP
        for (i = 0; i < 256; i = i + 1)
            memory[i] = 32'h00000013;   // NOP (ADDI x0, x0, 0)

        // Load Program
        memory[0] = 32'h00100093;   // ADDI x1, x0, 1
        memory[1] = 32'h00208133;   // ADD  x2, x1, x2
        memory[2] = 32'h00012083;   // LW   x1, 0(x2)
        memory[3] = 32'h00208463;   // BEQ  x1, x2, Branch

    end

    // -------------------------------------------------
    // Read Instruction
    // -------------------------------------------------

    assign instruction = memory[address[31:2]];

endmodule
