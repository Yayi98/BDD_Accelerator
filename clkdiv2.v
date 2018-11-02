module  clkdiv2 (clk,invclk2,clk2);
    input wire clk;
    output wire invclk2,clk2;

    reg clk1reg = 0;
    reg clk2reg = 0;

    always @ ( posedge clk ) begin
         clk1reg = ~clk1reg;
    end

    always @ (posedge clk1) begin
            clk2reg = ~clk2reg;
    end

    assign invclk2 = ~clk2reg;
    assign clk2 = clk2reg;
    
endmodule
