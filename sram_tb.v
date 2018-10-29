module sram_basic_testbench();
    parameter ADDR_WIDTH = 4;
    parameter DATA_WIDTH = 34;
    parameter DEPTH = 32;

    reg clk;
    reg [ADDR_WIDTH-1:0] address;
    reg write_enable;
    reg [DATA_WIDTH-1:0] data_in;
    wire [DATA_WIDTH-1:0] data_out;

    initial begin
        $display("sram test bench");
        clk = 1;

        #10 write_enable = 1;
        address = 0;
        data_in = {8'd10,8'd0,8'd0,10'd245};
        #10 address = 1;
        data_in = {8'd0,8'd10,8'd0,10'd175};
        #10 address = 2;
        data_in = {8'd10,8'd0,8'd0,10'd495};
        #10 address = 3;
        data_in = {8'd10,8'd0,8'd0,10'd485};
        #10 address = 4;
        data_in = {8'd0,8'd10,8'd0,10'd165};
        #10 address = 5;
        data_in = {8'd0,8'd10,8'd0,10'd155};
        #10 address = 6;
        data_in = {8'd0,8'd0,8'd10,10'd595};
        #10 address = 7;
        data_in = {8'd0,8'd0,8'd10,10'd695};

        #10 write_enable = 0;
        #10 address = 0;
        #10 address = 1;
        #10 address = 2;
        #10 address = 3;
        #10 address = 4;
        #10 address = 5;
        #10 address = 6;
        #10 address = 7;
    end

    always begin
        #5 clk = ~clk;  // timescale is 1ns so #5 provides 100MHz clock
    end

    sram #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(RAM2_DATA_WIDTH), .DEPTH(DEPTH)) DUT (
        .i_clk(clk),
        .i_addr(address),
        .i_write(write_enable),
        .i_data(data_in),
        .o_data(data_out)
    );

endmodule
