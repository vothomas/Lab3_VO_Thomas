`timescale 1ns/100ps
module digitTimer_testbench();
reg clk, rst, timer_enable, reconfig;
wire [3:0] ones, tens;
wire timeout;
// Clock generation
    always 
    begin
        clk = 1'b0;
        #10;
        clk = 1'b1;
        #10;
    end

digitTimer DUT_digitTimer(clk, rst, timer_enable, reconfig, ones, tens, timeout);

initial begin
rst =1; timer_enable = 0; reconfig = 0;
#20;
rst =0;
#30;
rst = 1;
#50
timer_enable = 1;
#5000;
end

endmodule