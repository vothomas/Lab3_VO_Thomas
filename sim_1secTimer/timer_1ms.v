module timer_1ms (
    clk,rst, enable, one_ms_timeout
);
input clk, rst, enable;
output one_ms_timeout;
reg one_ms_timeout;
reg [15:0] count;

always @(posedge clk)begin
    if(rst == 1'b0)begin
        count <= 0;
        one_ms_timeout <=0;
    end
    else if(enable == 1'b1)begin
        
            if(count == 3)begin //49999
                one_ms_timeout <=1;
                count <= 0;
            end else begin
                one_ms_timeout <= 0;
                count <= count +1;
            end
         
    end
end  
endmodule

