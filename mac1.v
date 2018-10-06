 module macunit(a, b, clk,rst, acc);
    input [7:0] a;
    input [7:0] b;
    input clk,rst;
    output [15:0] acc;
    
           reg [15:0]acc;
           reg [15:0]sum;
           reg [15:0]prod;    
           reg [15:0]regg;
           
always @(a,b,clk,rst) begin

if(rst==1'b1)
begin
regg=0;
end
else
begin
regg=sum;
end


prod=a*b;
sum=prod+regg;

acc=regg;
end
endmodule
