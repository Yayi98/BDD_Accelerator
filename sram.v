module sram #(parameter ADDR_WIDTH = 3, DATA_WIDTH = 34, DEPTH = 8) (

	input [DATA_WIDTH-1:0] data_a, data_b,
	input [ADDR_WIDTH-1:0] addr_a, addr_b,
	input we_a, clk,
	output reg [DATA_WIDTH-1:0] q_b
);

	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram [0:DEPTH-1];
    reg [DATA_WIDTH-1:0] q_a; 
	// Port A
	always @ (posedge clk)
	begin
		if (we_a)
		begin
			ram[addr_a] <= data_a;
			q_a <= data_a;
		end
		else
		begin
			q_a <= ram[addr_a];
		end
	end

	// Port B
	always @ (posedge clk)
	begin
		// if (we_b)
		// begin
		// 	ram[addr_b] <= data_b;
		// 	q_b <= data_b;
		// end
		// else
		// begin
		q_b <= ram[addr_b];
		//end
	end

endmodule

//    input wire i_clk,
//    input wire [ADDR_WIDTH-1:0] i_addr,
//    input wire i_write,
//    input wire [DATA_WIDTH-1:0] i_data,
//    output reg [DATA_WIDTH-1:0] o_data
//    );

//    reg [DATA_WIDTH-1:0] memory_array [0:DEPTH-1];
//    reg [ADDR_WIDTH-1:0] counter = 0;

//    //rst and we have to be held high for "DEPTH" number of clk cycles to reset the ram

//    always @ (i_clk) begin
//        //counter <= counter + 1;

//        //if(~rst) begin
//        if(i_write) begin
//            memory_array[i_addr] <= i_data;
//            o_data <= 0;
//        end else begin
//            o_data <= memory_array[i_addr];
//        end

////        else begin
////            if(counter<DEPTH) begin
////                if(i_write) begin
////                    memory_array[counter] <= 0;
////                end
////            end else begin
////                counter <= 0;
////            end
////        end
//    end
//endmodule
