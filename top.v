module top (a, Output,clk);

input wire a[31:0];

input wire clk;
output reg[8:0] Output;


reg[7:0] a,b;
reg[7:0] na =8'b00000000;;      //next address/class
reg c =1'b0;          //class flag
reg [7:0] c1,c2,c3,c4;
reg [15:0] c6;



    sram1  sram_node (
    .i_clk(clk),
    .i_addr(node_addr),
    .i_write(i_write),
    .i_data(i_data),
    .o_data(coeff)
);

    sram2  sram_child (
    .i_clk(clk),
    .i_addr(inputAddr),
    .i_write(i_write),
    .i_da(i_data),
    .o_da(child)
);
    mac1 mac_i(.a(a),.b(b),.c3(c3),.rst(rst), .acc(acc) clk(clk));


assign i_write=0;
assign i_data=1;


//always@(a)
//c=0;
while (c==0) begin


begin

    inputAddr=na[7:0];
    c1=coeff[32:24];c2=coeff[23:16];c3=coeff[15:8];c4=coeff[7:0];
    always @ (clk) begin
      a = 
    end



  if  (acc < c4)
    begin
        assign na=child[17:9];  //child address including the chld or class bit, so total 11+1=12 bits
    end
  else
    begin
        assign na=child[8:0];
    end


    if na[8]==1
    begin
      assign c=1;
      Output=child;
     end
end



endmodule // top
