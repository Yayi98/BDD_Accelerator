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
reg[8:0] na;
reg c;          //class flag
reg [5:0] inputAddr;
reg i_write;


    sram # (parameter ADDR_WIDTH = 6, DATA_WIDTH = 48, DEPTH = 64) sram_inst1 (
    .i_clk(clk),
    .i_addr(inputAddr),
    .i_write(i_write1),
    .i_data(),
    .o_data(coeff)
);

    sram # (parameter ADDR_WIDTH = 6, DATA_WIDTH = 18, DEPTH = 64) sram_inst2 (
    .i_clk(clk),
    .i_addr(inputAddr),
    .i_write(i_write2),
    .i_da(),
        .o_da(child)
);


assign ENA= 1b'1;
assign na=0;
always@(posedge clk)

begin
  
if (~c)
begin  
    c1=coeff[47:40];c2=coeff[39:32];c3=coeff[31:24];c4=coeff[23:16];c5=coeff[15:8];c6=coeff[7:0];
  
t = ((A1*c1)+(A2*c2)+(A3*c3)+(A4*c4));

    i_addr=na[7:0];
  
  if  (t < c6)
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
      Output=na;
     end
end



endmodule // top

    
    
    
    
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
