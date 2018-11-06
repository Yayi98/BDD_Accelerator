module top_tb();
    parameter RAM1_DATA_WIDTH = 34;
    parameter RAM2_DATA_WIDTH = 18;
    parameter ADDR_WIDTH = 8;
    parameter DEPTH = 32;

    reg [23:0] in_attr;
    reg clk, we1;
    reg [ADDR_WIDTH-1:0] in_addr;
    reg [RAM1_DATA_WIDTH-1:0] ram1_data_in;
    reg [RAM2_DATA_WIDTH-1:0] ram2_data_in;
    wire [7:0] out_class;

    reg rst_in;

    top #(.RAM1_DATA_WIDTH(RAM1_DATA_WIDTH), .RAM2_DATA_WIDTH(RAM2_DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH), .DEPTH(DEPTH)) DUT (
        .in_attr(in_attr),
        .clk(clk),
        .we1(we1),
        .rst_in(rst_in),
        .in_addr(in_addr),
        .ram1_data_in(ram1_data_in),
        .ram2_data_in(ram2_data_in),
        .out_class(out_class)
        );

    initial begin
        clk = 1'b1;
        rst_in = 1'b0;
        //Load sram1
        we1 = 1;
        #20 in_addr = 0;
        ram1_data_in = {8'd10,8'd0,8'd0,10'd245};
        ram2_data_in = 18'b100000011000000001;

        #40 in_addr = 1;
        ram1_data_in = {8'd0,8'd10,8'd0,10'd175};
        ram2_data_in = 18'b000000010000000011;

        #40 in_addr = 2;
        ram1_data_in = {8'd10,8'd0,8'd0,10'd495};
        ram2_data_in = 18'b000000100000000101;

        #40 in_addr = 3;
        ram1_data_in = {8'd10,8'd0,8'd0,10'd485};
        ram2_data_in = 18'b000000110100000001;

        #40 in_addr = 4;
        ram1_data_in = {8'd0,8'd10,8'd0,10'd165};
        ram2_data_in = 18'b100000001100000010;

        #40 in_addr = 5;
        ram1_data_in = {8'd0,8'd10,8'd0,10'd155};
        ram2_data_in = 18'b100000010000000111;

        #40 in_addr = 6;
        ram1_data_in = {8'd0,8'd0,8'd10,10'd595};
        ram2_data_in = 18'b100000001100000011;

        #40 in_addr = 7;
        ram1_data_in = {8'd0,8'd0,8'd10,10'd695};
        ram2_data_in = 18'b100000001100000011;

        #40 we1 = 0;
        rst_in=1'b1;
        #5 rst_in = 1'b0;
        in_attr = {8'd14,8'd2,8'd49};
    end

    always begin
        #5 clk = ~clk;
    end

endmodule
