module mac1 #(parameter ATTR_WIDTH = 24, RAM1_DATA_WIDTH = 24) (inputattr, inputcoeff, clk, rst_in, acc);
    input wire [ATTR_WIDTH-1:0] inputattr;
    input wire [RAM1_DATA_WIDTH-1:0] inputcoeff;
    input wire clk, rst_in;
    output reg [19:0] acc;

    reg [19:0] prod,sum;
    reg  ctr_set;
    reg [9:0] a,b;
    reg [1:0] counter = 2'b11; //2s(-1)
    reg rst = 1'b0;

    always @(posedge clk) begin
        if(rst_in == 1'b1) begin
            counter = 2'b00;
            ctr_set = 1'b0;
            sum=0;
        end
        else
            counter = counter + 2'b01;
    end

    always @(posedge clk) begin

        if(ctr_set==1'b1) begin
            prod = a*b;
            sum = prod+sum;
            ctr_set = 1'b0;
        end
    end


    always @(counter) begin
        case(counter)
            2'b00 : begin
                        b = {2'b00,inputcoeff[RAM1_DATA_WIDTH-1:RAM1_DATA_WIDTH-8]};
                        a = {2'b00,inputattr[ATTR_WIDTH-1:ATTR_WIDTH-8]};
                        ctr_set = 1'b1;
                    end
            2'b01 : begin
                        b = {2'b00,inputcoeff[RAM1_DATA_WIDTH-9:RAM1_DATA_WIDTH-16]};
                        a = {2'b00,inputattr[ATTR_WIDTH-9:ATTR_WIDTH-16]};
                        ctr_set = 1'b1;
                    end
            2'b10 : begin
                        b = {2'b00,inputcoeff[RAM1_DATA_WIDTH-17:RAM1_DATA_WIDTH-24]};
                        a = {2'b00,inputattr[ATTR_WIDTH-17:ATTR_WIDTH-24]};
                        ctr_set = 1'b1;
                    end

            2'b11 : begin
                        acc = sum;
                        sum=0;
                        ctr_set = 1'b0;
                        counter = 2'b11;
					end

            default : begin
                        b = 8'bx;
                      end
        endcase
    end

endmodule
