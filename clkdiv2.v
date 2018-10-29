module  clkdiv2 (clk,clk1,clk2);
    input wire clk;
    output reg clk1,clk2;

    always @ ( posedge clk ) begin
         clk1 = ~ clk1;
    end

    always @ (posedge clk1) begin
            clk2=~clk2;
    end
endmodule
