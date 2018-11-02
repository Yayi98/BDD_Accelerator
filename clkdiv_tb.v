`timescale 1ns/10ps
module clkdiv_tb();

    reg clk;
    wire clk1,clk2;

    clkdiv2 DUT (.clk(clk), .invclk2(clk1), .clk2(clk2));

    initial begin
            clk = 0;
    end

    always begin
          #5 clk = ~clk;
           end

endmodule
