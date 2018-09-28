module mac (A1,A2,A3,A4,A5,c1,c2,c3,c4,c5,Output,clk);

input wire [7:0] A1;
input wire [7:0] A2;
input wire [7:0] A3;
input wire [7:0] A4;
input wire [7:0] A5;
input wire [7:0] c1,c2,c3,c4,c5;
input wire clk;

output reg [15:0] Output;




//reg [7:0] a1,a2,a3,a4;  // atributes stored in registers
reg[15:0] t;



always@(posedge clk)

begin



	t = ((A1*c1)+(A2*c2)+(A3*c3)+(A4*c4)+(A5*c5));

		Output=t;


end
endmodule
