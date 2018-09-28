module sram_tb();
    reg i_clk, i_write, i_read;
    reg [4:0] i_addr;
    reg [47:0] i_data, o_data;

    sram #(.ADDR_WIDTH(5), .DATA_WIDTH(48), .DEPTH(32)) DUT (
        .i_clk(i_clk),
        .i_write(i_write),
        .i_read(i_read),
        .i_addr(i_addr),
        .i_data(i_data),
        .o_data(o_data)
    );

    initial begin
        i_addr =4'b00000;
        $readmemb("initram.txt",memory_array);


    end
    always @(*) begin
        #10 clk = ~clk;

    end

    always @(posedge clk)
      begin
      i_read=~i_read;
      end
      always @(negedge clk)
      begin
      i_addr=i_addr+1'b1;
      end
      endmodule
