module mac1_tb();

    reg [23:0] inputattr;
    reg [23:0] inputcoeff;
    reg clk;
    reg [19:0] acc;

    mac1 DUT (.clk(clk), .acc(acc), .inputattr(inputattr), .inputcoeff(inputcoeff));

    always @(*) begin
        #20 clk = ~clk;
    end

    initial begin
        clk=1;
        #20 inputattr=0; inputcoeff=0;
        #20 inputattr={8'd49,8'd30,8'd14}; inputcoeff={8'd10,8'd0,8'd0};
        #20 inputattr={8'd47,8'd32,8'd13}; inputcoeff={8'd10,8'd0,8'd0};
    end
endmodule
