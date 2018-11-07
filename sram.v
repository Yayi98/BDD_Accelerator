module sram #(parameter ADDR_WIDTH = 8, DATA_WIDTH = 34, DEPTH = 8) (

	input [DATA_WIDTH-1:0] data_a, data_b,
	input [ADDR_WIDTH-1:0] addr_a, addr_b,
	input we_a, clk,
	output reg [DATA_WIDTH-1:0] q_b
);

	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram [0:DEPTH-1];
    	reg [DATA_WIDTH-1:0] q_a;
	// Port A
	always @ (posedge clk) begin
		if (we_a) begin
			ram[addr_a] <= data_a;
			q_a <= data_a;
		end else begin
			q_a <= ram[addr_a];
		end
	end

	// Port B
	always @ (posedge clk) begin
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
