module dt (
    input clk, rst, reconfig, b_dn, nb_up,
    output reg b_up, nb_dn,
    output reg [3:0] num
);

always @(posedge clk) begin
    if (rst == 0) begin
        num <= 4'd0;
        b_up <= 0;
        nb_dn <= 0;
    end 
    else if (reconfig == 1) begin
        num <= 4'd9;
        b_up <= 0;
        nb_dn <= 0;
    end 
    else if (b_dn == 1) begin
        if (num == 4'd0) begin 
            if (nb_up == 1) begin
                num <= 4'd0;   // Stop at 00
                b_up <= 0;
                nb_dn <= 1;    // Assert timeout signal
            end else begin
                num <= 4'd9;   // Borrow from next digit
                b_up <= 1;
                nb_dn <= 0;
            end
        end 
        else begin
            num <= num - 4'd1; // Normal decrement
            b_up <= 0;
            nb_dn <= 0;
        end
    end 
    else if (num == 4'd0 && nb_up == 1) begin
        nb_dn <= 1;  // Ensure nb_dn stays high when reaching 00
    end 
    else begin
        b_up <= 0;
        nb_dn <= 0;
    end
end

endmodule
