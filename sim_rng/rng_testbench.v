`timescale 1ns/100ps
module rng_testbench ();
reg clk, rst, in;
wire [3:0] rnum;
// Clock generation
    always 
    begin
        clk = 1'b0;
        #10;
        clk = 1'b1;
        #10;
    end

rng DUT_myRNG(in, clk,rst, rnum);

initial begin
    rst = 1;
    in = 1;

    #20;
    rst = 0;
    @(posedge clk);
    rst = 1;
    @(posedge clk);

    in = 0;
    @(posedge clk);
    @(posedge clk);
    in = 1;
    @(posedge clk);
    @(posedge clk);

    in = 0;
    #100;
    in = 1;



end
    
endmodule
