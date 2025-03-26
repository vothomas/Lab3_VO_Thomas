module score (
    input [6:0] win_count,  // 7-bit win count input (0 to 99)
    output reg [3:0] ones,  // Ones digit (0 to 9)
    output reg [3:0] tens   // Tens digit (0 to 9)
);

always @(*) begin
    // Calculate tens digit
    tens = win_count / 10;

    // Calculate ones digit
    ones = win_count % 10;
end

endmodule