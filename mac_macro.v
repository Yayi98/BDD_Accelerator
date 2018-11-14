module mac_macro (
    output reg [31:0] p_out,
    input [15:0] A,B,
    input CLK,CE,CARRYIN);

    reg [1:0] counter = 2'b11;
    reg LOAD, RST;
    wire [31:0] P;
    //reg ADDSUB = 1;

    MACC_MACRO #(
        .DEVICE("7SERIES"), // Target Device: "7SERIES"
        .LATENCY(1), // Desired clock cycle latency, 1-4
        .WIDTH_A(16), // Multiplier A-input bus width, 1-25
        .WIDTH_B(16), // Multiplier B-input bus width, 1-18
        .WIDTH_P(32) // Accumulator output bus width, 1-48
    ) MACC_MACRO_inst (
        .P(P), // MACC output bus, width determined by WIDTH_P parameter
        .A(A), // MACC input A bus, width determined by WIDTH_A parameter
        .ADDSUB(1'b1), // 1-bit add/sub input, high selects add, low selects subtract
        .B(B), // MACC input B bus, width determined by WIDTH_B parameter
        .CARRYIN(1'b0), // 1-bit carry-in input to accumulator
        .CE(1'b1), // 1-bit active high input clock enable
        .CLK(CLK), // 1-bit positive edge clock input
        .LOAD(LOAD), // 1-bit active high input load accumulator enable
        .LOAD_DATA(P), // Load accumulator input data, width determined by WIDTH_P parameter
        .RST(RST) // 1-bit input active high reset
    );

    always @(posedge CLK) begin
        if (counter == 2'b11) begin
            RST = 0;
            LOAD = 0;
        end
        else begin
            LOAD = 1;
        end
        if(counter == 2'b10) begin
            p_out = P;
            RST = 1;
        end

        counter = counter + 1;
    end
endmodule
