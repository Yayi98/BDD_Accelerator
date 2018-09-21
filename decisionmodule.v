module decisionmodule #(parameter ADDR_WIDTH = 6, DATA_WIDTH = 8, DEPTH = 64) (
    input wire clk,
    input wire nodeaddr,
    input wire ipaddr,
    input wire ipclass,
    input wire [ADDR_WIDTH-1] nodeaddr
    output wire decisionsignal
    );
