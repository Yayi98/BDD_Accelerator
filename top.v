
module top #( parameter RAM1_DATA_WIDTH = 34, RAM2_DATA_WIDTH = 18, ADDR_WIDTH = 8, DEPTH = 32) (in_attr,out_class,clk,we1,rst_in,in_addr,ram1_data_in,ram2_data_in);

    //Mac1 and sram inputs

    input wire [RAM1_DATA_WIDTH-1:0] in_attr;
    input wire  clk, we1, rst_in;
    input wire [ADDR_WIDTH-1:0] in_addr;
    input wire [RAM1_DATA_WIDTH-1:0] ram1_data_in;
    input wire [RAM2_DATA_WIDTH-1:0] ram2_data_in;
    output reg [7:0] out_class;

    reg [4:0] c1 = 0;
    //Mac1 output
    reg [19:0] mac_acc;
    //Ram1 and Ram2 inputs
    wire ram1clk;
    wire ram2clk;
    //Ram1 and Ram2 outputs
    //reg [RAM1_DATA_WIDTH-1:0] ram1reg;
    //eg [RAM2_DATA_WIDTH-1:0] ram2reg;



    // reg [7:0] ram1_8bit_reg;
    // reg [7:0] ram2_8bit_reg;
   // reg [9:0] ram1_10bit_reg;
    reg [8:0] ram2_9bit_reg;
    reg [ADDR_WIDTH-1:0] next_addr;
    reg [2:0] cnt = 3'b000;
    reg start1,start2=1'b0;
    wire start3;
    wire [9:0] ram1_10bit_wire;
    wire [8:0] ram2_9bit_wire;
    wire [7:0] next_addr_wire;
    wire [RAM1_DATA_WIDTH-1:0] ram1wire;
    wire [RAM2_DATA_WIDTH-1:0] ram2wire;
    wire [15:0] mac_acc_wire;


	reg [7:0] out_class_reg;


    //Instantiate clkdiv to reduce clkfreq by 4 times for Ram1 and to half the clkfreq for RAM2_DATA_WIDTH
    //So total 2 clkdiv modules

    clkdiv2 clkdiv (
		.clk(clk),
        .invclk2(ram2clk),
        .clk2(ram1clk)
        );



    sram #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(RAM1_DATA_WIDTH), .DEPTH(DEPTH)) sram_inst1 (
        .clk(ram1clk),
        .addr_a(in_addr),
        .addr_b(next_addr_wire),
        .data_a(ram1_data_in),
        .we_a(we1),
        .q_b(ram1wire)
        );

    sram #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(RAM2_DATA_WIDTH), .DEPTH(DEPTH)) sram_inst2 (
        .clk(ram2clk),
        .addr_a(in_addr),
        .addr_b(next_addr_wire),
        .data_a(ram2_data_in),
        .we_a(we1),
        .q_b(ram2wire)
        );

    mac1 mac_inst (
        .inputattr(in_attr),
        .inputcoeff(ram1wire),
        .clk(clk),
        .rst_in(rst_in),
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
    always @(in_attr) begin
            start1 = 1;

     end
    always @(posedge ram2clk) begin
        if (cnt ==1'b0)
           start2 =  1;
        else
            start2 =  0;
     end



    assign start3 = start1 & start2;
    assign next_addr_wire = next_addr;

	always @(posedge ram2clk) begin
	    cnt = cnt + 1;
	    if (start3 == 1)
	    begin
	       next_addr = 0;
	       end
	    else begin
		if(mac_acc_wire <= ram1wire[RAM1_DATA_WIDTH-25:RAM1_DATA_WIDTH-34]) begin
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
			    c1 = c1 +1;
				next_addr = ram2_9bit_reg[7:0];
				out_class = 8'b00000000;
			end
		end
		end
	end

//	assign ram2_9bit_wire= ram2_9bit_reg;

endmodule
