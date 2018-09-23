module top (a1,a2,a3,a4,a5, Output,clk);

input a1[7:0];
input a2[7:0];
input a3[7:0];
input a4[7:0];
input a5[7:0];
input clk;

output Output;

reg [7:0] cAdd;
reg q;
reg na;
reg c;          //class flag


BRAM_TDP_MACRO_inst coef(
.DOA(DOA_f),//Outputport-Adata,widthdefinedbyREAD_WIDTH_Aparameter
.DOB(DOB),//Outputport-Bdata,widthdefinedbyREAD_WIDTH_Bparameter
.ADDRA(ADDRA),//Inputport-Aaddress,widthdefinedbyPortAdepth
.ADDRB(ADDRB),//Inputport-Baddress,widthdefinedbyPortBdepth
.CLKA(clk),//1-bitinputport-Aclock
.CLKB(clk),//1-bitinputport-Bclock
.DIA(DIA),//Inputport-Adata,widthdefinedbyWRITE_WIDTH_Aparameter
.DIB(DIB),//Inputport-Bdata,widthdefinedbyWRITE_WIDTH_Bparameter
.ENA(ENA),//1-bitinputport-Aenable
.ENB(ENB),//1-bitinputport-Benable
.REGCEA(REGCEA),//1-bitinputport-Aoutputregisterenable
.REGCEB(REGCEB),//1-bitinputport-Boutputregisterenable
.RSTA(RSTA),//1-bitinputport-Areset
.RSTB(RSTB),//1-bitinputport-Breset
.WEA(WEA),//Inputport-Awriteenable,widthdefinedbyPortAdepth
.WEB(WEB)//Inputport-Bwriteenable,widthdefinedbyPortBdepth
);

BRAM_TDP_MACRO_inst child(
.DOA(DOA_c),//Outputport-Adata,widthdefinedbyREAD_WIDTH_Aparameter
.DOB(DOB),//Outputport-Bdata,widthdefinedbyREAD_WIDTH_Bparameter
.ADDRA(ADDRA),//Inputport-Aaddress,widthdefinedbyPortAdepth
.ADDRB(ADDRB),//Inputport-Baddress,widthdefinedbyPortBdepth
.CLKA(clk),//1-bitinputport-Aclock
.CLKB(clk),//1-bitinputport-Bclock
.DIA(DIA),//Inputport-Adata,widthdefinedbyWRITE_WIDTH_Aparameter
.DIB(DIB),//Inputport-Bdata,widthdefinedbyWRITE_WIDTH_Bparameter
.ENA(ENA),//1-bitinputport-Aenable
.ENB(ENB),//1-bitinputport-Benable
.REGCEA(REGCEA),//1-bitinputport-Aoutputregisterenable
.REGCEB(REGCEB),//1-bitinputport-Boutputregisterenable
.RSTA(RSTA),//1-bitinputport-Areset
.RSTB(RSTB),//1-bitinputport-Breset
.WEA(WEA),//Inputport-Awriteenable,widthdefinedbyPortAdepth
.WEB(WEB)//Inputport-Bwriteenable,widthdefinedbyPortBdepth
);

ADDMACC_MACRO_inst w(
.PRODUCT(PRODUCT),//MACCresultoutput,widthdefinedbyWIDTH_PRODUCTparameter
.CARRYIN(CARRYIN),//1-bitcarry-ininput
.CLK(CLK),
//1-bitclockinput
.CE(CE),
//1-bitclockenableinput
.LOAD(LOAD),
//1-bitaccumulatorloadinput
.LOAD_DATA(LOAD_DATA),//Accumulatorloaddatainput,widthdefinedbyWIDTH_PRODUCTparameter
.MULTIPLIER(MULTIPLIER),//Multiplierdatainput,widthdefinedbyWIDTH_MULTIPLIERparameter
.PREADD2(PREADD2),//Preadderdatainput,widthdefinedbyWIDTH_PREADDparameter
.PREADD1(PREADD1),//Preadderdatainput,widthdefinedbyWIDTH_PREADDparameter
.RST(RST)
//1-bitactivehighsynchronousreset
);


ADDMACC_MACRO_inst mac(
.PRODUCT(PRODUCT),//MACCresultoutput,widthdefinedbyWIDTH_PRODUCTparameter
.CARRYIN(CARRYIN),//1-bitcarry-ininput
.CLK(CLK),
//1-bitclockinput
.CE(CE),
//1-bitclockenableinput
.LOAD(LOAD),
//1-bitaccumulatorloadinput
.LOAD_DATA(LOAD_DATA),//Accumulatorloaddatainput,widthdefinedbyWIDTH_PRODUCTparameter
.MULTIPLIER(MULTIPLIER),//Multiplierdatainput,widthdefinedbyWIDTH_MULTIPLIERparameter
.PREADD2(PREADD2),//Preadderdatainput,widthdefinedbyWIDTH_PREADDparameter
.PREADD1(PREADD1),//Preadderdatainput,widthdefinedbyWIDTH_PREADDparameter
.RST(RST)
//1-bitactivehighsynchronousreset
);
assign ENA= 1b'1;
assign na=0;
always@(posedge clk)

// ADDMACC_MACRO code here

if (~c)
begin
  ADDRA=na;
  assign t = DOA_f[5:0];
  if  t < PRODUCT
    begin
          assign na=DOA_c[32:21];  //child address including the chld or class bit, so total 11+1=12 bits
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
