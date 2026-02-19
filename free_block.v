module free_block_pool #(
    parameter BLOCKS = 64
)(
    input clk,
    input reset,

    input allocate,
    input [$clog2(BLOCKS)-1:0] alloc_block,

    input free,
    input [$clog2(BLOCKS)-1:0] free_block,

    output [BLOCKS-1:0] free_bitmap
);

    reg [BLOCKS-1:0] free_bitmap_r;

    assign free_bitmap = free_bitmap_r;

    always @(posedge clk) begin
        if (reset) begin
            free_bitmap_r <= {BLOCKS{1'b1}}; // all blocks free
        end else begin
            if (allocate)
                free_bitmap_r[alloc_block] <= 1'b0;
            if (free)
                free_bitmap_r[free_block] <= 1'b1;
        end
    end

endmodule
