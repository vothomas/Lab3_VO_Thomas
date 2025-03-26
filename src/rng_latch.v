module rng_latch (
    input rng_button,
    input clk,
    input rst,
    input [3:0] rng_value,
    output reg [3:0] stable_rng_value
);

reg rng_button_prev;

always @(posedge clk) begin
    rng_button_prev <= rng_button;
    
    if (rst == 1'b0) begin
        stable_rng_value <= 4'b0000;
    end
    else if (rng_button_prev == 1'b1 && rng_button == 1'b0) begin
        // Button release detected (falling edge)
        stable_rng_value <= rng_value;
    end
end

endmodule