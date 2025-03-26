`timescale  1ns/100ps
module oneSecTimer_testbench();
reg clk,rst,enable;
wire one_sec_timeout;

always begin
    clk = 1'b0;
    #10;
    clk =1'b1;
    #10;
end
oneSecTimer DUT(clk,rst,enable,one_sec_timeout);
initial begin
    enable =0;
    rst = 1;
    #20;
    rst =0;
    #20;
    rst = 1;
    #10;
    #15;
    enable = 1;

#24000;
end
endmodule