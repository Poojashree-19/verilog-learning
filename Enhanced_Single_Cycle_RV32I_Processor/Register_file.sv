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
