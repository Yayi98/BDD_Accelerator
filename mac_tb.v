module mac_tb();
    reg [7:0] A1, A2, A3, A4, A5, c1, c2, c3, c4, c5;
    reg clk;
    reg [15:0] Output;

    mac DUT (A1,A2,A3,A4,A5,c1,c2,c3,c4,c5,Output,clk);

    initial begin
        A1 = 8'd1;
        A2 = 8'd1;
        A3 = 8'd1;
        A4 = 8'd1;
        A5 = 8'd1;
        c1 = 8'd1;
        c2 = 8'd1;
        c3 = 8'd1;
        c4 = 8'd1;
        c5 = 8'd1;
        clk = 1'b0;
        Output = 16'b0000000000000000;
    end

    always @(*) begin
        #10 clk = ~clk;
    end
endmodule
