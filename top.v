module top #(RAM1_DATA_WIDTH = 34, RAM2_DATA_WIDTH = 16, ADDR_WIDTH = 4, DEPTH = 32) (a, Output,clk);

    //Mac1 and sram inputs

    input wire [7:0] in_attr;
    input wire clk, rst, we1, we2, i_write;
    input wire [31:0] ram_1_data_in;
    input wire [ADDR_WIDTH-1:0] in_addr;
    input wire [RAM1_DATA_WIDTH-1:0] ram1_data_in;
    input wire [RAM2_DATA_WIDTH-1:0] ram2_data_in;
    output reg [7:0] out_class;

    //Mac1 output
    reg [15:0] mac_acc;
    //Ram1 and Ram2 inputs
    reg ram1clk;
    reg ram2clk;
    //Ram1 and Ram2 outputs
    reg [RAM1_DATA_WIDTH-1:0] ram1reg;
    reg [RAM2_DATA_WIDTH-1:0] ram2reg;

    // reg [7:0] ram1_8bit_reg;
    // reg [7:0] ram2_8bit_reg;
    reg [9:0] ram1_10bit_reg;
    reg [8:0] ram2_9bit_reg;
    reg [2:0] counter;
    reg [7:0] next_addr;

    initial begin
        mac_acc = 16'b0000000000000000;
        ram1clk = 1'b0;
        ram2clk = 1'b0;
        ram1reg = 0;
        ram2reg = 0;
        // ram1_8bit_reg = 8'b00000000;
        // ram2_8bit_reg = 8'b00000000;
        ram1_10bit_reg = 10'b0000000000;
        ram2_9bit_reg = 9'b000000000;
        counter = 3'b000;
    end

    //Instantiate clkdiv to reduce clkfreq by 4 times for Ram1 and to half the clkfreq for RAM2_DATA_WIDTH
    //So total 2 clkdiv modules
    clkdiv #(.DIVISOR(4)) clkdivram1 (
        .clock_in(clk),
        .clock_out(ram1clk)
        );

    clkdiv #(.DIVISOR(2)) clkdivram2 (
        .clock_in(clk),
        .clock_out(ram2clk)
        );

    sram #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(RAM1_DATA_WIDTH), .DEPTH(DEPTH)) sram_inst1 (
        .i_clk(ram1clk),
        .i_addr(next_addr),
        .i_write(we1),
        .rst(rst),
        .i_data(ram1_data_in),
        .o_data(ram1reg)
        );

    sram #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(RAM2_DATA_WIDTH), .DEPTH(DEPTH)) sram_inst2 (
        .i_clk(ram2clk),
        .i_addr(next_addr),
        .i_write(we2),
        .rst(rst),
        .i_data(ram2_data_in),
        .o_data(ram2reg)
        );

    mac1 mac_inst (
        .a(in_attr),
        .b(ram1_10bit_reg),
        .clk(clk),
        .rst(rst)
        .acc(mac_acc)
        );

    always @(clk,rst) begin
        if(posedge clk) begin
            if(counter>3'b100) begin
                counter <= 3'b000;
            end else begin
                counter <= counter + 3'b001;
            end
        end

        case(counter)
            3'b000 : ram1_10bit_reg <= ram1reg[RAM1_DATA_WIDTH-1:RAM1_DATA_WIDTH-8];
            3'b001 : ram1_10bit_reg <= ram1reg[RAM1_DATA_WIDTH-9:RAM1_DATA_WIDTH-16];
            3'b010 : ram1_10bit_reg <= ram1reg[RAM1_DATA_WIDTH-17:RAM1_DATA_WIDTH-24];
            3'b011 : ram1_10bit_reg <= ram1reg[RAM1_DATA_WIDTH-25:RAM1_DATA_WIDTH-34];
            default : ram1_10bit_reg <= 8'bx;
        endcase

        if(counter=3'b011) begin
            if(macc_acc<=ram1_10bit_reg) begin
                ram2_9bit_reg <= ram2reg[RAM2_DATA_WIDTH-1:RAM2_DATA_WIDTH-9];
                if(ram2_9bit_reg[RAM2_DATA_WIDTH-1] = 1'b1) begin
                    out_class <= ram2_9bit_reg[RAM2_DATA_WIDTH-2:RAM2_DATA_WIDTH-9];
                    next_addr <= 8'b00000000;
                end else begin
                    next_addr <= ram2_9bit_reg[RAM2_DATA_WIDTH-2:RAM2_DATA_WIDTH-9];
                    out_class <= 8'b00000000;
                end
            end else begin
                ram2_9bit_reg <= ram2reg[RAM2_DATA_WIDTH-10:0];
                if(ram2_9bit_reg[RAM2_DATA_WIDTH-10] = 1'b1) begin
                    out_class <= ram2_9bit_reg[RAM2_DATA_WIDTH-11:0];
                    next_addr <= 8'b00000000;
                end else begin
                    next_addr <= ram2_9bit_reg[RAM2_DATA_WIDTH-11:0];
                    out_class <= 8'b00000000;
                end
            end
        end
    end
endmodule



























// input wire a[31:0];
//
// input wire clk;
// output reg[8:0] Output;
//
//
// reg[7:0] a,b;
// reg[7:0] na =8'b00000000;;      //next address/class
// reg c =1'b0;          //class flag
// reg [7:0] c1,c2,c3,c4;
// reg [15:0] t;
// reg count;
// //always@(a)
// //c=0;
// while (c==0) begin
//
//
// begin
//     count=0;
//     inputAddr=na[7:0];
//     c1=coeff[32:24];c2=coeff[23:16];c3=coeff[15:8];c4=coeff[7:0];
//     always @ (clk) begin
//       if (count==0) begin
//       rst=1;
//       a = c1; b=a[23:16];
//       rst=0;
//       count= count+1;
//       end
//       if (count==1) begin
//       a = c2; b=a[15:8];
//       count= count+1;
//       if (count==2) begin
//       a = c3; b=a[7:0];
//       t=acc;
//       count= 0;
//     end
//
//
//
//   if  (t < c4)
//     begin
//         assign na=child[17:9];  //child address including the chld or class bit, so total 11+1=12 bits
//     end
//   else
//     begin
//         assign na=child[8:0];
//     end
//
//
//     if na[8]==1
//     begin
//       assign c=1;
//       Output=child;
//      end
// end



endmodule // top
