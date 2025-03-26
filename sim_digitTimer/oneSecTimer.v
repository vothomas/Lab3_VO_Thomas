module oneSecTimer (
    clk,rst,enable,one_sec_timeout
);
input clk, rst, enable;
output one_sec_timeout;
wire one_sec_timeout;

wire one_ms_timeout;
wire one_hundred_ms_timeout;

timer_1ms timer_1ms_inst(clk,rst,enable,one_ms_timeout);
count_to_100 count_100ms_inst(clk,rst,enable,one_ms_timeout,one_hundred_ms_timeout);
count_to_10 count_1s_inst(clk,rst,enable,one_hundred_ms_timeout, one_sec_timeout);
    
endmodule
