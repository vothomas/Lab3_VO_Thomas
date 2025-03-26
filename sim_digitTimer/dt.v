module dt (
    clk,rst,reconfig,b_dn,nb_up,b_up,nb_dn,num
);
input clk,rst,reconfig,b_dn,nb_up;
output reg b_up, nb_dn;
output reg [3:0] num = 4'd9;

always @(posedge clk) begin
    if(rst == 0)begin
        num <= 4'd9;
        b_up <= 0;
        nb_dn <= 0;
    end
    else if(reconfig == 1)begin
        num <= 4'd9;
        b_up <= 0;
        nb_dn <= 0;
    end
    else if( b_dn == 1 )begin
        
        if(num == 4'd0 && nb_up == 0)begin //borrow
            num <= 4'd9;
            b_up <= 1;
            nb_dn <=0;
        end
        else if(num == 4'd1 && nb_up == 1)begin //wants to borrow but cant
            num <= 0;
            b_up <= 0;
            nb_dn <= 1;
        end
        else if(num == 4'd0 && nb_up == 1)begin //wants to borrow but cant
            num <= 4'd0;
            b_up <= 0;
            nb_dn <= 1;
        end
        else begin  //decrement
            num <= num -4'd1;
            b_up <= 0;
            nb_dn <= 0;
        end
    end 
    else begin
        b_up <= 0;
        nb_dn <= 0;
    end
end
    
endmodule
