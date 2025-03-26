module counter (
    count,clk,rst,c_out
);
    
input clk, rst, count;
output [3:0] c_out;
reg [3:0] c_out;

always @(posedge clk) begin
    if(rst == 0)
        c_out <= 4'b0000;
    else begin
        if(count == 1)
            c_out <= c_out +1;
    end
end

endmodule
