// ECE 5440
// Thomas Vo 9861
// Access Controller
// controls several inputs and outputs of system design

module Access (
    PassDigit, PassEnter, Load_P1_In, rng_button,timeout,rst, clk, 
    Load_P1_Out, rng_gen, timer_enable, reconfig, logoutLED, loginLED,
    gameover, win, win_count
);

input [3:0] PassDigit;
input PassEnter, Load_P1_In, rng_button,timeout, clk, rst, win;
output  Load_P1_Out, rng_gen, timer_enable, reconfig,logoutLED, loginLED , gameover;
reg Load_P1_Out, rng_gen, timer_enable, reconfig, Flag,logoutLED, loginLED, gameover;
output reg [6:0] win_count = 7'd0;
parameter digit1 = 0, digit2 = 1, digit3 = 2, digit4 = 3, verify = 4,reconfig_timer = 5, wait_gameStart = 6, gameplay = 7, gameOver = 8 ;
reg [3:0] state;
reg prev_win, rng_button_prev;
always @(posedge clk) begin
    prev_win <= win;
    rng_button_prev <= rng_button;
    if(rst == 1'b0)begin
        state <= digit1;
        Flag <= 1'b1;
        Load_P1_Out <= 1'b0;
        rng_gen <= 1;
        timer_enable <= 0;
        reconfig <=0;
        logoutLED <=1;
        loginLED <= 0;
        gameover <= 0;
        win_count <= 7'd0;
    end

    else begin
        
    case (state)
        digit1:begin
            Flag <= 1'b1;
            Load_P1_Out <= 1'b0;
            rng_gen <= 1;
            timer_enable <= 0;
            reconfig <=0;

            if(PassEnter == 1'b1)begin
                if(PassDigit != 4'b1001) //incorrect - 9
                    Flag <= 1'b0; 
                state <= digit2;
            end
            else
                state <= digit1;
        end 

        digit2:begin
            Load_P1_Out <= 1'b0;
            rng_gen <= 1;
            timer_enable <= 0;
            reconfig <=0;
            if(PassEnter == 1'b1)begin
                if(PassDigit != 4'b1000) //incorrect - 8
                    Flag <= 1'b0; 
                state <= digit3;
            end
            else
                state <= digit2;
        end

        digit3:begin
            Load_P1_Out <= 1'b0;
            rng_gen <= 1;
            timer_enable <= 0;
            reconfig <=0;
            if(PassEnter == 1'b1)begin
                if(PassDigit != 4'b0110) //incorrect - 6
                    Flag <= 1'b0; 
                state <= digit4;
            end
            else
                state <= digit3;
        end

        digit4:begin
            Load_P1_Out <= 1'b0;
            rng_gen <= 1;
            timer_enable <= 0;
            reconfig <=0;
            if(PassEnter == 1'b1)begin
                if(PassDigit != 4'b0001) //incorrect - 1
                    Flag <= 1'b0; 
                state <= verify;
            end
            else
                state <= digit4;
        end

        verify:begin
            if(Flag == 1'b1)
                state <= reconfig_timer;
            else
                state <= digit1;
        end
        reconfig_timer:begin
            gameover <= 0;
            reconfig <= 1;
            state <= wait_gameStart;

        end

        wait_gameStart:begin
            win_count <= 7'd0;
            gameover <= 0;
            reconfig <= 0;
            rng_gen <= rng_button;
            logoutLED <=0;
            loginLED <= 1;
            if(PassEnter == 1)begin
                state <= gameplay;
                timer_enable <= 1;
            end else 
                    state <= wait_gameStart;
        end

        gameplay:begin
            gameover <= 0;
            if(timeout == 1) begin
                state <= gameOver;
                timer_enable <=0;
            end

        rng_gen <= rng_button;
        Load_P1_Out <= Load_P1_In;
           if(win == 1 && prev_win == 0  ) begin  // Rising edge detection
        win_count <= (win_count < 7'd99) ? win_count + 1 : win_count;
        end
        end

    //     gameplay_win:begin
    //         if(prev_win == 1'b1 && win == 1'b0) begin
    //             if(win_count < 7'd99)
    //                 win_count <= win_count + 1;
    //         state <= gameplay;
    // end
    // gameover <= 0;
    // if(timeout == 1) begin
    //     state <= gameOver;
    //     timer_enable <= 0;
    // end
    // rng_gen <= rng_button;
    // Load_P1_Out <= Load_P1_In;
    //     end

        gameOver:begin
            gameover <= 1;
            rng_gen <= 1;
            Load_P1_Out <=0;
            if(PassEnter == 1)
                state <= reconfig_timer;
            else
                state <= gameOver;
        end
        

        default: begin
            state <= digit1;
            Flag <= 1'b1;
            Load_P1_Out <= 1'b0;
            rng_gen <= 1;
            timer_enable <= 0;
            reconfig <=0;
            logoutLED <=1;
            loginLED <= 0;
            gameover <= 0;
            win_count <= 7'd0;
        end
    endcase
end
end
    
endmodule