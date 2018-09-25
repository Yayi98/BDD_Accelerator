module top (a1,a2,a3,a4,a5, Output,clk);

input wire a1[7:0];
input wire a2[7:0];
input wire a3[7:0];
input wire a4[7:0];
input wire a5[7:0];
input wire clk;
output reg Output;

reg [7:0] cAdd;
reg q;
reg na;
reg c;          //class flag
reg [5:0] inputAddr;
reg i_write;


sram # (parameter ADDR_WIDTH = 6, DATA_WIDTH = 56, DEPTH = 64) sram_inst1 (
    .i_clk(clk),
    .i_addr(inputAddr),
    .i_write(i_write),
    .i_data(),
    .o_data()
);

sram # (parameter ADDR_WIDTH = 6, DATA_WIDTH = 12, DEPTH = 64) sram_inst2 (
    .i_clk(clk),
    .i_addr(inputAddr),
    .i_write(i_write),
    .i_data(),
    .o_data()
);

// BRAM_TDP_MACRO_inst coef(
// .DOA(DOA_f),//Outputport-Adata,widthdefinedbyREAD_WIDTH_Aparameter
// .DOB(DOB),//Outputport-Bdata,widthdefinedbyREAD_WIDTH_Bparameter
// .ADDRA(ADDRA),//Inputport-Aaddress,widthdefinedbyPortAdepth
// .ADDRB(ADDRB),//Inputport-Baddress,widthdefinedbyPortBdepth
// .CLKA(clk),//1-bitinputport-Aclock
// .CLKB(clk),//1-bitinputport-Bclock
// .DIA(DIA),//Inputport-Adata,widthdefinedbyWRITE_WIDTH_Aparameter
// .DIB(DIB),//Inputport-Bdata,widthdefinedbyWRITE_WIDTH_Bparameter
// .ENA(ENA),//1-bitinputport-Aenable
// .ENB(ENB),//1-bitinputport-Benable
// .REGCEA(REGCEA),//1-bitinputport-Aoutputregisterenable
// .REGCEB(REGCEB),//1-bitinputport-Boutputregisterenable
// .RSTA(RSTA),//1-bitinputport-Areset
// .RSTB(RSTB),//1-bitinputport-Breset
// .WEA(WEA),//Inputport-Awriteenable,widthdefinedbyPortAdepth
// .WEB(WEB)//Inputport-Bwriteenable,widthdefinedbyPortBdepth
// );

// BRAM_TDP_MACRO_inst child(
// .DOA(DOA_c),//Outputport-Adata,widthdefinedbyREAD_WIDTH_Aparameter
// .DOB(DOB),//Outputport-Bdata,widthdefinedbyREAD_WIDTH_Bparameter
// .ADDRA(ADDRA),//Inputport-Aaddress,widthdefinedbyPortAdepth
// .ADDRB(ADDRB),//Inputport-Baddress,widthdefinedbyPortBdepth
// .CLKA(clk),//1-bitinputport-Aclock
// .CLKB(clk),//1-bitinputport-Bclock
// .DIA(DIA),//Inputport-Adata,widthdefinedbyWRITE_WIDTH_Aparameter
// .DIB(DIB),//Inputport-Bdata,widthdefinedbyWRITE_WIDTH_Bparameter
// .ENA(ENA),//1-bitinputport-Aenable
// .ENB(ENB),//1-bitinputport-Benable
// .REGCEA(REGCEA),//1-bitinputport-Aoutputregisterenable
// .REGCEB(REGCEB),//1-bitinputport-Boutputregisterenable
// .RSTA(RSTA),//1-bitinputport-Areset
// .RSTB(RSTB),//1-bitinputport-Breset
// .WEA(WEA),//Inputport-Awriteenable,widthdefinedbyPortAdepth
// .WEB(WEB)//Inputport-Bwriteenable,widthdefinedbyPortBdepth
// );

// ADDMACC_MACRO_inst w(
// .PRODUCT(PRODUCT),//MACCresultoutput,widthdefinedbyWIDTH_PRODUCTparameter
// .CARRYIN(CARRYIN),//1-bitcarry-ininput
// .CLK(CLK),
// //1-bitclockinput
// .CE(CE),
// //1-bitclockenableinput
// .LOAD(LOAD),
// //1-bitaccumulatorloadinput
// .LOAD_DATA(LOAD_DATA),//Accumulatorloaddatainput,widthdefinedbyWIDTH_PRODUCTparameter
// .MULTIPLIER(MULTIPLIER),//Multiplierdatainput,widthdefinedbyWIDTH_MULTIPLIERparameter
// .PREADD2(PREADD2),//Preadderdatainput,widthdefinedbyWIDTH_PREADDparameter
// .PREADD1(PREADD1),//Preadderdatainput,widthdefinedbyWIDTH_PREADDparameter
// .RST(RST)
// //1-bitactivehighsynchronousreset
// );


// ADDMACC_MACRO_inst mac(
// .PRODUCT(PRODUCT),//MACCresultoutput,widthdefinedbyWIDTH_PRODUCTparameter
// .CARRYIN(CARRYIN),//1-bitcarry-ininput
// .CLK(CLK),
// //1-bitclockinput
// .CE(CE),
// //1-bitclockenableinput
// .LOAD(LOAD),
// //1-bitaccumulatorloadinput
// .LOAD_DATA(LOAD_DATA),//Accumulatorloaddatainput,widthdefinedbyWIDTH_PRODUCTparameter
// .MULTIPLIER(MULTIPLIER),//Multiplierdatainput,widthdefinedbyWIDTH_MULTIPLIERparameter
// .PREADD2(PREADD2),//Preadderdatainput,widthdefinedbyWIDTH_PREADDparameter
// .PREADD1(PREADD1),//Preadderdatainput,widthdefinedbyWIDTH_PREADDparameter
// .RST(RST)
// //1-bitactivehighsynchronousreset
// );
assign ENA= 1b'1;
assign na=0;
always@(posedge clk)

begin
  
if (~c)
begin  
c1=o_data[35:30];c2=o_data[29:24];c3=o_data[23:18];c4=o_data[17:12];c5=o_data[11:6];c6=o_data[5:0];
  
t = ((A1*c1)+(A2*c2)+(A3*c3)+(A4*c4));

  i_addr=na;
  
  if  (t < c6)
    begin
          assign na=o_data[32:21];  //child address including the chld or class bit, so total 11+1=12 bits
    end
  else
    begin
        assign na=DOA_c[11:0];
    end


    if na[12]==1
    begin
      assign c=1;
      Output=na;
     end
end



endmodule // top
