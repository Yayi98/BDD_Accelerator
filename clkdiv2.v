module  clkdiv2 (clk,clk1,clk2);
    input wire clk;
    output wire clk1,clk2;
    
    reg clk1reg = 0;
    reg clk2reg = 0;
    
    always @ ( posedge clk ) begin
         clk1reg = ~clk1reg;
    end

    always @ (posedge clk1) begin
            clk2reg = ~clk2reg;
    end
    
    assign clk1 = clk1reg;
    assign clk2 = clk2reg;
endmodule

