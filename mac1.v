module mac1 #(parameter ATTR_WIDTH = 24, RAM1_DATA_WIDTH = 24) (inputattr, inputcoeff, clk, rst_in, acc);
    input wire [ATTR_WIDTH-1:0] inputattr;
    input wire [RAM1_DATA_WIDTH-1:0] inputcoeff;
    input wire clk, rst_in;
    output reg [19:0] acc;

  //  reg [ATTR_WIDTH-1:0] inputattrreg;
  //  reg [RAM1_DATA_WIDTH-1:0] inputcoeffreg;
    reg [19:0] prod,sum;
    reg  ctr_set;
    reg [9:0] a,a1,a2,b;
    reg [1:0] counter = 2'b11; //2s(-1)
    reg rst = 1'b0;
//    wire [19:0] accwire;

    always @(posedge clk) begin

 //       inputattrreg = inputattr;
 //       inputcoeffreg = inputcoeff;
 //       acc = accwire;
        if(rst_in == 1'b1) begin
            counter = 2'b00;
            rst = 1'b1;
            ctr_set = 1'b0;
        end else if(counter == 2'b00) begin
            rst = 1'b1;
            counter = counter + 2'b01;
        end
        /*
        if(counter>3'b010) begin
            counter = 3'b000;
            rst = 1'b0;
        end else begin
            //if(rst==1'b0) begin
                counter = counter + 3'b001;
            //end
        end
        */
    end


        always @(posedge clk) begin

            if(rst==1'b1) begin
                sum = 0;
                ctr_set = 1'b0;
                rst = 1'b0;
            end

            if(ctr_set==1'b1) begin
                prod = a*b;
                sum = prod+sum;
                ctr_set = 1'b0;
            end
        end


    always @(counter) begin
        case(counter)
            2'b00 : begin
                        rst = 1'b1;
                        b = {2'b00,inputcoeff[RAM1_DATA_WIDTH-1:RAM1_DATA_WIDTH-8]};
                        a = {2'b00,inputattr[ATTR_WIDTH-1:ATTR_WIDTH-8]};
                    end

            2'b01 : begin
                        b = {2'b00,inputcoeff[RAM1_DATA_WIDTH-9:RAM1_DATA_WIDTH-16]};
                        a = {2'b00,inputattr[ATTR_WIDTH-9:ATTR_WIDTH-16]};
                    end

            2'b10 : begin
                        b = {2'b00,inputcoeff[RAM1_DATA_WIDTH-17:RAM1_DATA_WIDTH-24]};
                        a = {2'b00,inputattr[ATTR_WIDTH-17:ATTR_WIDTH-24]};
                    end

            2'b11 : begin
                        //b <= inputcoeffreg[RAM1_DATA_WIDTH-25:RAM1_DATA_WIDTH-34];
                        acc = sum;
					end

            default : begin
                    //    inputattrreg = 8'bx;
                        b = 8'bx;
                      end
        endcase
        ctr_set = 1'b1;
    end

    /*
    always @(posedge clk) begin
        a1 <= a;
        a2 <= a1;
    end
     //   assign accwire = sum;

*/
endmodule
