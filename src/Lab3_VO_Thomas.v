module Lab3_VO_Thomas (
   clk, rst, 
   p1_button, pass_button, rng_button, 
   pass_input, p1_input,
   timer_tens, timer_ones, score_tens, sum_score_ones, RNG, P1,
   NmatchLED, matchLED, logoutLED, logInLED 
);
    input clk, rst, p1_button, pass_button, rng_button;
    input [3:0] pass_input, p1_input;
    output NmatchLED, matchLED, logoutLED, logInLED;
    output [6:0] timer_tens, timer_ones, score_tens, sum_score_ones, RNG, P1;
    //configure buttons **not rst and rng
    wire passwordToAC, p1ToAC;
    buttonShaper passwordBS(pass_button, passwordToAC, clk, rst);
    buttonShaper p1BS(p1_button, p1ToAC, clk, rst);
    //configure p1 input to load register
    wire [3:0] LRtoDecoder;
    wire Load_P1_out; //From AC
    LoadRegister p1LR(p1_input, LRtoDecoder, clk,rst, Load_P1_out);
    //configure rng
    wire ACtoRNG;
    wire [3:0] stable_rng_to_adder,rngTo_Adder_decoder;
    rng myrng(ACtoRNG, clk,rst, rngTo_Adder_decoder);
    //rng latch
    rng_latch my_rng_latch(rng_button, clk, rst, rngTo_Adder_decoder, stable_rng_to_adder);
    //configure digit timer
    wire timer_enable, reconfig, timeout;
    wire [3:0] timerToTensDecoder, timerToOnesDecoder;
    digitTimer twoDigitTimer(clk,rst, timer_enable, reconfig, timerToOnesDecoder, timerToTensDecoder, timeout);
    //config adder
    wire [3:0] AdderToMUX_is15; 
    Adder myAdder(stable_rng_to_adder, LRtoDecoder, AdderToMUX_is15);
    //config is15
    wire win;
    Is15 verify(AdderToMUX_is15, win, NmatchLED);
    assign matchLED = win;
    //config score
    wire [6:0] win_count;
    wire [3:0] scoreTensToMUX, scoreOnesToMUX;
    score myScore( win_count, scoreOnesToMUX, scoreTensToMUX);
    //config mux
    wire ACGameOverToMUX;
    wire [3:0] MUXtoDSum, MUXtoDTens;
    mux3to2 myMUX(AdderToMUX_is15, scoreOnesToMUX, scoreTensToMUX, ACGameOverToMUX,MUXtoDSum, MUXtoDTens);
    //config all ddecoders
    sevenSegDecoder Dp1(LRtoDecoder,P1); //p1
    sevenSegDecoder DRNG(stable_rng_to_adder,RNG); //rng
    sevenSegDecoder DSum_ScoreOnes(MUXtoDSum,sum_score_ones); //sum / score ones
    sevenSegDecoder DTens(MUXtoDTens, score_tens); //score tens
    sevenSegDecoder DTimerOnes(timerToOnesDecoder,timer_ones);
    sevenSegDecoder DTimerTens(timerToTensDecoder, timer_tens);
    //access controller 
    Access myAC(pass_input, passwordToAC,p1ToAC, rng_button,
    timeout, rst,clk, Load_P1_out, ACtoRNG, timer_enable, reconfig, 
    logoutLED,logInLED, ACGameOverToMUX ,win , win_count);
endmodule