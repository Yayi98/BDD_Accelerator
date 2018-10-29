module clkdiv_tb();

    reg clk,clk1,clk2;
    
    clkdiv2 DUT (.clk(clk), .clk1(clk1), .clk2(clk2));
    initial begin
            clk = 1;
            end
    always begin
          #20 clk = ~clk;
           end

endmodule
