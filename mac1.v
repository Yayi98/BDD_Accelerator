module mac1 #(ATTR_WIDTH = 24, RAM1_DATA_WIDTH = 34) (inputattr, inputcoeff, clk, acc);
    input wire [ATTR_WIDTH-1:0] inputattr;
    input wire [RAM1_DATA_WIDTH-1:0] inputcoeff;
    input wire clk;
    output reg [19:0] acc;

    reg [ATTR_WIDTH-1:0] inputattrreg;
    reg [RAM1_DATA_WIDTH-1:0] inputcoeffreg;
    reg [19:0] prod,regg,sum;
    reg [9:0] a, b;
    reg [2:0] counter;
    reg rst;


    always @(posedge clk) begin

        inputattrreg <= inputattr;
        inputcoeffreg <= inputcoeff;

        if(counter>3'b100) begin
            counter <= 3'b000;
        end else begin
            counter <= counter + 3'b001;
        end

        case(counter)
            3'b000 : begin
                        b <= {2'b00,inputcoeffreg[RAM1_DATA_WIDTH-1:RAM1_DATA_WIDTH-8]};
                        a <= {2'b00,inputattrreg[ATTR_WIDTH-1:ATTR_WIDTH-8]};
                    end

            3'b001 : begin
                        b <= {2'b00,inputcoeffreg[RAM1_DATA_WIDTH-9:RAM1_DATA_WIDTH-16]};
                        a <= {2'b00,inputattrreg[ATTR_WIDTH-9:ATTR_WIDTH-16]};
                    end
            3'b010 : begin
                        b <= {2'b00,inputcoeffreg[RAM1_DATA_WIDTH-17:RAM1_DATA_WIDTH-24]};
                        a <= {2'b00,inputattrreg[ATTR_WIDTH-17:ATTR_WIDTH-24]};
                        acc <= sum;
                    end
            3'b011 : begin
                        b <= inputcoeffreg[RAM1_DATA_WIDTH-25:RAM1_DATA_WIDTH-34];
                        rst <= 1;
					end

            default : begin
                        a <= 8'bx;
                        b <= 8'bx;
                      end
        endcase
    end

    always @(clk,rst) begin
        if(rst==1'b1) begin
            regg = 0;
            sum = 0;
        end else begin
            regg = sum;
        end
        prod = a*b;
        sum = prod+regg;
end
endmodule
