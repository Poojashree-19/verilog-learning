module data_memory(

    input  logic        clk,
    input  logic        MemRead,
    input  logic        MemWrite,

    input  logic [31:0] address,
    input  logic [31:0] write_data,

    output logic [31:0] read_data

);

    // ---------------------------------------------
    // Data Memory
    // 256 locations, each 32 bits wide
    // ---------------------------------------------

    logic [31:0] memory [0:255];

    // ---------------------------------------------
    // Write Operation
    // ---------------------------------------------

    always_ff @(posedge clk) begin

        if (MemWrite)
            memory[address[31:2]] <= write_data;

    end

    // ---------------------------------------------
    // Read Operation
    // ---------------------------------------------

    assign read_data = (MemRead) ? memory[address[31:2]] : 32'd0;

endmodule
