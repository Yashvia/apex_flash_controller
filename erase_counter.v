module erase_counter_table #(
    parameter BLOCKS = 64
)(
    input clk,
    input reset,
    input erase_en,
    input [$clog2(BLOCKS)-1:0] block_id,
    output [BLOCKS*16-1:0] erase_count_flat
);

    // Internal erase counter array
    reg [15:0] erase_count [0:BLOCKS-1];

    integer i;

    // Erase count update logic
    always @(posedge clk) begin
        if (reset) begin
            for (i = 0; i < BLOCKS; i = i + 1)
                erase_count[i] <= 16'd0;
        end else if (erase_en) begin
            erase_count[block_id] <= erase_count[block_id] + 1'b1;
        end
    end

    // Pack array into flat output bus
    genvar g;
    generate
        for (g = 0; g < BLOCKS; g = g + 1) begin : PACK
            assign erase_count_flat[g*16 +: 16] = erase_count[g];
        end
    endgenerate

endmodule
