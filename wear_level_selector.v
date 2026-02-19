module wear_level_selector #(
    parameter BLOCKS = 64,
    parameter ERASE_W = 16,
    parameter THRESHOLD = 16'd1000
)(
    input [BLOCKS*ERASE_W-1:0] erase_count_flat,
    input [BLOCKS-1:0] free_bitmap,

    output reg [$clog2(BLOCKS)-1:0] selected_block,
    output reg valid
);

    integer i;
    reg [ERASE_W-1:0] min_erase;
    reg [ERASE_W-1:0] erase_i;

    always @(*) begin
        min_erase = {ERASE_W{1'b1}};
        selected_block = 0;
        valid = 1'b0;

        for (i = 0; i < BLOCKS; i = i + 1) begin
            erase_i = erase_count_flat[i*ERASE_W +: ERASE_W];

            if (free_bitmap[i] &&
                erase_i < min_erase &&
                erase_i < THRESHOLD) begin

                min_erase = erase_i;
                selected_block = i[$clog2(BLOCKS)-1:0];
                valid = 1'b1;
            end
        end
    end

endmodule
