module digitTimer (
    clk,rst, timer_enable, reconfig, ones,tens, timeout
);
input clk, rst, timer_enable, reconfig;
output [3:0] ones, tens;
output timeout;

wire Timer1s_to_OnesPlace;
oneSecTimer my1s(clk, rst, timer_enable, Timer1s_to_OnesPlace );
wire OnesBU_to_TensBD, TensNBD_to_OnesNBU, dummy;
dt OnesPlace(clk,rst, reconfig, Timer1s_to_OnesPlace, TensNBD_to_OnesNBU, OnesBU_to_TensBD,timeout, ones);
dt TensPlace(clk, rst, reconfig, OnesBU_to_TensBD, 1'b1, dummy, TensNBD_to_OnesNBU, tens);

endmodule
