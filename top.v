
module top #( parameter RAM1_DATA_WIDTH = 34, RAM2_DATA_WIDTH = 16, ADDR_WIDTH = 4, DEPTH = 32) (i,in_attr, out_class,clk, we1, we2,in_addr,ram1_data_in,ram2_data_in);

    //Mac1 and sram inputs

    input wire [29:0] in_attr;
    input wire  clk, we1, we2,i;
    input wire [ADDR_WIDTH-1:0] in_addr;
    input wire [RAM1_DATA_WIDTH-1:0] ram1_data_in;
    input wire [RAM2_DATA_WIDTH-1:0] ram2_data_in;
    output reg [7:0] out_class;


    //Mac1 output
    reg [15:0] mac_acc;
    //Ram1 and Ram2 inputs
    wire ram1clk;
    wire ram2clk;
    //Ram1 and Ram2 outputs
    reg [RAM1_DATA_WIDTH-1:0] ram1reg;
    reg [RAM2_DATA_WIDTH-1:0] ram2reg;



    // reg [7:0] ram1_8bit_reg;
    // reg [7:0] ram2_8bit_reg;
   // reg [9:0] ram1_10bit_reg;
    reg [8:0] ram2_9bit_reg;
    reg [2:0] counter;
    reg [7:0] next_addr;

    wire [9:0] ram1_10bit_wire;
    wire [8:0] ram2_9bit_wire;
    wire [7:0] next_addr_wire;
    wire [RAM1_DATA_WIDTH-1:0] ram1wire;
    wire [RAM2_DATA_WIDTH-1:0] ram2wire;
    wire [15:0] mac_acc_wire;


	 reg [7:0] out_class_reg;

    //Instantiate clkdiv to reduce clkfreq by 4 times for Ram1 and to half the clkfreq for RAM2_DATA_WIDTH
    //So total 2 clkdiv modules

    clkdiv2 clkdiv  (
		  .clk(clk),
        .clk1(ram2clk),
        .clk2(ram1clk)
        );



    sram #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(RAM1_DATA_WIDTH), .DEPTH(DEPTH)) sram_inst1 (
        .i_clk(ram1clk),
        .i_addr(next_addr_wire),
        .i_write(we1),
        .i_data(ram1_data_in),
        .o_data(ram1wire)
        );

    sram #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(RAM2_DATA_WIDTH), .DEPTH(DEPTH)) sram_inst2 (
        .i_clk(ram2clk),
        .i_addr(next_addr_wire),
        .i_write(we2),
        .i_data(ram2_data_in),
        .o_data(ram2wire)
        );

    mac1 mac_inst (
        .inputattr(in_attr),
        .inputcoeff(ram1wire),
        .clk(clk),
        .acc(mac_acc_wire)
        );


//	assign o_data = o_data_reg;


//	always @(posedge clk) begin
//	//	mac_acc = mac_acc_wire;
//	//	ram1_10bit_reg = ram1_10bit_wire;
//	//	ram2_9bit_reg = ram2_9bit_wire;
//		next_addr = next_addr_wire;
//		ram1reg = ram1wire;
//		ram2reg = ram2wire;
//	end
//


	always @(posedge clk) begin
		if (i==1'b1) begin
			next_addr = in_addr;
		end else begin



//		if(counter==3'b011) begin
			if(mac_acc_wire<= ram1wire[RAM1_DATA_WIDTH-25:RAM1_DATA_WIDTH-34]) begin
				ram2_9bit_reg = ram2wire[RAM2_DATA_WIDTH-1:RAM2_DATA_WIDTH-9];
				if(ram2_9bit_reg[8] == 1'b1) begin
					out_class = ram2_9bit_reg[7:0];
					next_addr = 8'b00000000;
				end else begin
					next_addr = ram2_9bit_reg[7:0];
					out_class = 8'b00000000;
				end
			end else begin
				ram2_9bit_reg = ram2wire[RAM2_DATA_WIDTH-10:0];
				if(ram2_9bit_reg[RAM2_DATA_WIDTH-10] == 1'b1) begin
					out_class = ram2_9bit_reg[7:0];
					next_addr = 8'b00000000;
				end else begin
					next_addr = ram2_9bit_reg[7:0];
					out_class = 8'b00000000;
				end
			end
		end
	end


	assign next_addr_wire = next_addr;

//	assign ram2_9bit_wire= ram2_9bit_reg;

endmodule
