module count_to_10 (
    clk,rst, enable, in, timeout
);
input clk, rst, in, enable;
output timeout;
reg timeout;
reg [3:0] count;
always @(posedge clk)begin
    if(rst ==1'b0)begin
        count <= 0;
        timeout <=0;
    end
    else if(enable == 1'b1)begin
        if(in == 1'b1)begin
            if(count == 9)begin //9
                timeout <=1;
                count <= 0;
            end else begin
                timeout <= 0;
                count <= count +1;
            end
        end else
            timeout <=0;
    end
end  
endmodule
