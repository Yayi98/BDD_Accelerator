module mac1_tb();

    reg [15:0] inputattr;
    reg [15:0] inputcoeff;
    reg clk,rst;
    wire [31:0] acc;

    mac2 DUT (.clk(clk), .acc(acc), .a(inputattr), .b(inputcoeff), .rst_in(rst));

    always begin
        #20 clk = ~clk;
    end

    initial begin
        clk=1;
        rst = 1;
        #40 rst = 0;
        inputattr=16'd49;            //,8'd30,8'd14};
        inputcoeff=16'd10;
        #40 inputattr=16'd30;            //,8'd30,8'd14};
        inputcoeff=16'd10;
        #40 inputattr=16'd14;            //,8'd30,8'd14};
        inputcoeff=16'd0;
        #40 inputattr=16'd47;            //,8'd30,8'd14};
        inputcoeff=16'd10;
        #40 inputattr=16'd32;            //,8'd30,8'd14};
        inputcoeff=16'd10;
        rst = 1;
        #40 rst = 0;
        inputattr=16'd49;            //,8'd30,8'd14};
        inputcoeff=16'd10;
        #40 inputattr=16'd30;            //,8'd30,8'd14};
        inputcoeff=16'd10;
        #40 inputattr=16'd13;            //,8'd30,8'd14};
        inputcoeff=16'd10;
        end
endmodule
