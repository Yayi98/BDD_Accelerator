`timescale 1ns / 1ps
//-----------------------------------------------------
// Design Name : BDD_top
// File Name   : BDD_top.v
// Function    : BD traversal
// Coder       : Jatin Kumar Bollareddy
// Version     : 1
//-----------------------------------------------------

top #(parameter RAM1_DATA_WIDTH = 34, ADDR_WIDTH = 32, DEPTH = 1024, EDGES=124 ) (clk, we1,ram1_data_in, out) //ram1_data_in CHECK

    input wire clk, we1;
  //  input wire [ADDR_WIDTH-1:0] in_addr;
    input wire [RAM1_DATA_WIDTH-1:0] ram1_data_in;
    output reg [EDGES-1:0] out;

    // counter reg 
    reg [EDGES-1 : 0] counter = 0; 
    reg [31:0] cost = 0;              //reg to store cost
    reg [31:0] Mincost;
    reg [EDGES-1:0] addr;             // reg to store address
    reg [EDGES-1:0] Minaddr;
    reg i = 0;
    reg [ADDR_WIDTH-1:0] next_addr;
    reg [RAM1_DATA_WIDTH-1:0] ram1;
    wire [ADDR_WIDTH-1:0] next_addr_wire;
    wire [RAM1_DATA_WIDTH-1:0] ram1ram1wire;
    
    sram #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(RAM1_DATA_WIDTH), .DEPTH(DEPTH)) sram_inst1 (
          .i_clk(clk),
          .i_addr(next_addr_wire),  //check if we can directly assign wires or regs 
          .i_write(we1),
          .i_data(ram1_data_in),     
          .o_data(ram1wire)
          );

    assign next_addr_wire = next_addr;
  //  assign ram1wire = ram1;

    
    always @ ( clk ) begin: process

    if counter == EDGES'b1111111111111.... disable process;
    cost = cost + ram1wire [m : n]
    
    if counter[i] ==0;
      next_addr =  ram1wire [x : y];
      
    else if counter[i] == 1;
      next_addr =  ram1wire [x : y];

    else if (ram1wire[0] == 0);
    begin
       cost = 0;
       counter = counter +1; end
       
    else if (ram1wire[0] == 1);
    begin
        if (Mincost > Cost);
            begin
            Mincost = Cost;
            Minaddr = counter;
            Cost = 0; end
        counter = counter +1;
    end
    
    end


endmodule
  
