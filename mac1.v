module mac1 (a, b, clk,rst, acc);
    input wire [9:0] a;
    input wire [9:0] b;
    input wire clk,rst;
    output reg [19:0] acc;
    reg [19:0] prod,regg,sum;

    always @(clk,rst) begin
        if(rst==1'b1) begin
            regg = 0;
            sum = 0;
        end
        else begin
            regg = sum;
        end
        prod = a*b;
        sum = prod+regg;
	    acc = sum;
    end
endmodule
