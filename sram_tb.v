`timescale 1ns/10ps
module sram_basic_testbench();
    parameter ADDR_WIDTH = 3;
    parameter DATA_WIDTH = 34;
    parameter DEPTH = 8;

    reg clk;
    reg [ADDR_WIDTH-1:0] address,addr_b;
    reg we_a, we_b;
    reg [DATA_WIDTH-1:0] data_a,data_b;
    wire [DATA_WIDTH-1:0] q_a,q_b;

    always begin
        #5 clk = ~clk;  // timescale is 1ns so #5 provides 100MHz clock
    end

    initial begin
        $display("sram test bench");
        clk = 1;

        #10 we_a = 1;
        address = 0;
        data_a = {8'd10,8'd0,8'd0,10'd245};
        #10 address = 1;
        data_a = {8'd0,8'd10,8'd0,10'd175};
        #10 address = 2;
        data_a = {8'd10,8'd0,8'd0,10'd495};
        #10 address = 3;
        data_a = {8'd10,8'd0,8'd0,10'd485};
        #10 address = 4;
        data_a = {8'd0,8'd10,8'd0,10'd165};
        #10 address = 5;
        data_a = {8'd0,8'd10,8'd0,10'd155};
        #10 address = 6;
        data_a = {8'd0,8'd0,8'd10,10'd595};
        #10 address = 7;
        data_a = {8'd0,8'd0,8'd10,10'd695};

        #10 we_a = 0;
        #10 we_b = 0;
        #10 addr_b = 0;
        #10 addr_b = 1;
        #10 addr_b = 2;
        #10 addr_b = 3;
        #10 addr_b = 4;
        #10 addr_b = 5;
        #10 addr_b = 6;
        #10 addr_b = 7;
    end


    sram DUT (
        .clk(clk),
        .addr_a(address),
        .addr_b(addr_b),
        .data_a(data_a),
        .data_b(data_b),
        .we_a(we_a),
        .we_b(we_b),
        .q_a(q_a),
        .q_b(q_b)
        );

endmodule
