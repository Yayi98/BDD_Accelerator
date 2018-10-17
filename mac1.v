
module macunit (a, b, clk,rst, acc);
    input wire [9:0] a;
    input wire [9:0] b;
    input wire clk,rst;
    output reg [19:0] acc;

    reg [19:0]sum;
    reg [19:0]prod;
    reg [19:0]regg;

    always @(clk,rst) begin
        if(rst==1'b1) begin
            regg <= 0;
            sum <= 0;
        end
        else begin
            regg <= sum;
        end
        prod = a*b;
        sum = prod+regg;
    end
    acc<=sum;
endmodule
