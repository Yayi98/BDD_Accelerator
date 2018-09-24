module top (A1,A2,A3,A4, Output,clk);

input[7:0] A1;
input[7:0] A2;
input[7:0] A3;
input[7:0] A4;
//input A5[7:0];
input clk;

output Output;




//reg [7:0] a1,a2,a3,a4;  // atributes stored in registers 
reg[15:0] t,c5;
reg [7:0] c1,c2,c3,c4;
reg Output;




always@(posedge clk)

begin



	t = ((A1*c1)+(A2*c2)+(A3*c3)+(A4*c4));
	if (t < c5)
		Output=1;
	else 
		Output=0;
end
endmodule 