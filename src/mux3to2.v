module mux3to2 (
    sum, score_ones,score_tens, gameover_s, out, tens_out
);
    input [3:0] sum, score_ones, score_tens;
    input gameover_s;
    output reg [3:0] out, tens_out;

    always @(*) begin
        if(gameover_s == 1)begin
            out = score_ones;
            tens_out = score_tens;
        end
        else begin
            out = sum;
            tens_out = 4'd0;
        end
    end
endmodule