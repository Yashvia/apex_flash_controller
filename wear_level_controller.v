module wear_level_controller #(
    parameter BLOCKS = 64,
    parameter ERASE_W = 16,
    parameter THRESHOLD = 16'd1000
)(
    input clk,
    input reset,

    input write_req,

    output reg [$clog2(BLOCKS)-1:0] phys_block,
    output reg ready
);

    /* Internal wires */
    wire [BLOCKS*ERASE_W-1:0] erase_count_flat;
    wire [BLOCKS-1:0] free_bitmap;
    wire [$clog2(BLOCKS)-1:0] selected_block;
    wire valid_block;

    reg allocate;

    /* Erase counter table */
    erase_counter_table #(
        .BLOCKS(BLOCKS)
    ) ect (
        .clk(clk),
        .reset(reset),
        .erase_en(1'b0),       // driven by erase FSM elsewhere
        .block_id({$clog2(BLOCKS){1'b0}}),
        .erase_count_flat(erase_count_flat)
    );

    /* Free block pool */
    free_block_pool #(
        .BLOCKS(BLOCKS)
    ) fbp (
        .clk(clk),
        .reset(reset),
        .allocate(allocate),
        .alloc_block(selected_block),
        .free(1'b0),
        .free_block({$clog2(BLOCKS){1'b0}}),
        .free_bitmap(free_bitmap)
    );

    /* Wear-level selector */
    wear_level_selector #(
        .BLOCKS(BLOCKS),
        .ERASE_W(ERASE_W),
        .THRESHOLD(THRESHOLD)
    ) wls (
        .erase_count_flat(erase_count_flat),
        .free_bitmap(free_bitmap),
        .selected_block(selected_block),
        .valid(valid_block)
    );

    /* Controller logic */
    always @(posedge clk) begin
        if (reset) begin
            ready <= 1'b0;
            allocate <= 1'b0;
        end else begin
            ready <= 1'b0;
            allocate <= 1'b0;

            if (write_req && valid_block) begin
                phys_block <= selected_block;
                allocate <= 1'b1;
                ready <= 1'b1;
            end
        end
    end

endmodule
