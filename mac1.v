module macunit(a, b, clk,rst, acc);
    input wire [7:0] a;
    input wire [7:0] b;
    input wire clk,rst;
    output wire [15:0] acc;

    reg [15:0]sum;
    reg [15:0]prod;
    reg [15:0]regg;

    always @(clk,rst) begin
        if(rst==1'b1) begin
            regg=0;
        end
        else begin
            regg=sum;
        end
        prod=a*b;
        sum=prod+regg;
    end
    assign acc=sum;
endmodule
