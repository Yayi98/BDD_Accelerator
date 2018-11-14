module mac1_tb();

    reg [31:0] p;
    reg [15:0] a,b;
    reg clk;
    reg CE = 1;
    reg ci = 0;

    mac1 DUT (.clk(CLK), .CE(CE),.ci(CARRYIN), .p(p_out, .a(A), .b(b));

    always begin
        #20 clk = ~clk;
    end

    initial begin
        clk=1;
        #20 a = 1; b = 10;
        #20 a = 2; b = 10;
        #20 a = 3; b = 10;
        #20 a = 4; b = 0;

/*
        #120 inputattr={8'd49,8'd30,8'd14}; inputcoeff={8'd10,8'd0,8'd0};
        #120 inputattr={8'd47,8'd32,8'd13}; inputcoeff={8'd10,8'd0,8'd0};
    */
    end
endmodule
