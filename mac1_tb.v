module mac1_tb();

reg clk, rst;
reg [7:0] a,b;
reg [15:0] acc;

macunit DUT (.clk(clk), .rst(rst), .a(a), .b(b), .acc(acc));



always @(*) begin
    #10 clk = ~clk;

initial begin
clk=1;
rst=0;
a=0; b=0;
rst=1;
#20
rst=0;

a=5; b=1; #20
a=5; b=2; #20
a=5; b=3; #20
#100
rst =1;
#20
rst=0;

a=4; b=1; #20
a=4; b=2; #20
a=4; b=3; #20
#100
end

endmodule
