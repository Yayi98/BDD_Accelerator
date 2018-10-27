module top_tb();
    parameter RAM1_DATA_WIDTH = 34;
    parameter RAM2_DATA_WIDTH = 18;
    parameter ADDR_WIDTH = 4;
    parameter DEPTH = 32;

    reg [9:0] in_attr;
    reg clk, we1, we2, rst;
    reg [ADDR_WIDTH-1:0] in_addr;
    reg [RAM1_DATA_WIDTH-1:0] ram1_data_in;
    reg [RAM2_DATA_WIDTH-1:0] ram2_data_in;
    wire [7:0] out_class;

    top #(.RAM1_DATA_WIDTH(RAM1_DATA_WIDTH), .RAM2_DATA_WIDTH(RAM2_DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH), .DEPTH(DEPTH)) DUT (
        .in_attr(in_attr),
        .clk(clk),
        .we1(we1),
        .we2(we2),
        .in_addr(in_addr),
        .ram1_data_in(ram1_data_in),
        .ram2_data_in(ram2_data_in),
        .out_class(out_class)
        );

    always begin
        #5 clk = ~clk;
    end

    initial begin
        clk = 1;
        //Load sram1
        we1 = 1;
        in_addr = 0;
        ram1_data_in = {8'd10,8'd0,8'd0,10'd245};
        #40 in_addr = 1;
        ram1_data_in = {8'd0,8'd10,8'd0,10'd175};
        #40 in_addr = 2;
        ram1_data_in = {8'd10,8'd0,8'd0,10'd495};
        #40 in_addr = 3;
        ram1_data_in = {8'd10,8'd0,8'd0,10'd485};
        #40 in_addr = 4;
        ram1_data_in = {8'd0,8'd10,8'd0,10'd165};
        #40 in_addr = 5;
        ram1_data_in = {8'd0,8'd10,8'd0,10'd155};
        #40 in_addr = 6;
        ram1_data_in = {8'd0,8'd0,8'd10,10'd595};
        #40 in_addr = 7;
        ram1_data_in = {8'd0,8'd0,8'd10,10'd695};
        we1 = 0;

        //Load sram2
        #20 we2 = 1;
        in_addr = 0;
        ram2_data_in = 18'b100000000000000001;
        #20 in_addr = 1;
        ram2_data_in = 18'b000000010000000011;
        #20 in_addr = 2;
        ram2_data_in = 18'b000000100000000101;
        #20 in_addr = 3;
        ram2_data_in = 18'b000000110100000001;
        #20 in_addr = 4;
        ram2_data_in = 18'b100000001100000010;
        #20 in_addr = 5;
        ram2_data_in = 18'b100000010000000111;
        #20 in_addr = 6;
        ram2_data_in = 18'b100000001100000011;
        #20 in_addr = 7;
        ram2_data_in = 18'b100000001100000011;
        we2 = 0;

        //Give input attr

        repeat (7) begin
            #10 in_attr = 10'd49;
            #10 in_attr = 30;
            #10 in_attr = 14;
        end
    end
endmodule
