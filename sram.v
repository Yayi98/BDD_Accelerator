module sram #(parameter ADDR_WIDTH = 4, DATA_WIDTH = 32, DEPTH = 32) (
    input wire i_clk,
    input wire [ADDR_WIDTH-1:0] i_addr,
    input wire i_write,
    input wire [DATA_WIDTH-1:0] i_data,
    output reg [DATA_WIDTH-1:0] o_data
    );

    reg [DATA_WIDTH-1:0] memory_array [0:DEPTH-1];
  //  reg [ADDR_WIDTH-1:0] counter = 0;


    always @ (i_clk) begin

        if(i_write) begin
            memory_array[i_addr] <= i_data;
//            o_data <= 0;
        end else begin
            o_data <= memory_array[i_addr];
        end
    end
endmodule
