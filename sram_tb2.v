module sram_basic_testbench();
    parameter ADDR_WIDTH = 4;
    parameter DATA_WIDTH = 32;
    parameter DEPTH = 32;

    reg clk;
    reg [ADDR_WIDTH-1:0] address;
    reg write_enable;
    reg [DATA_WIDTH-1:0] data_in;
    wire [DATA_WIDTH-1:0] data_out;

    initial begin
        $display("sram test bench 2");
        clk = 1;

        #10 write_enable = 1;
        address = 0;
        data_in = 18'b100000000000000001;
        address = 1;
        data_in = 18'b000000010000000011;
        address = 2;
        data_in = 18'b000000100000000101;
        address = 3;
        data_in = 18'b000000110100000001;
        address = 4;
        data_in = 18'b100000001100000010;
        address = 5;
        data_in = 18'b100000010000000111;
        address = 6;
        data_in = 18'b100000001100000011;
        address = 7;
        data_in = 18'b100000001100000011;

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

    sram DUT (
        .i_clk(clk),
        .i_addr(address),
        .i_write(write_enable),
        .i_data(data_in),
        .o_data(data_out));

endmodule
