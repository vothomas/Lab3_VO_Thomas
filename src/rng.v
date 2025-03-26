module rng (
    rng_gen,clk,rst,random_num
);
input rng_gen, clk, rst;
output [3:0] random_num;
wire [3:0] random_num;
wire inv_in;
assign inv_in = ~rng_gen;
counter myRNG(inv_in, clk, rst, random_num);    
endmodule
