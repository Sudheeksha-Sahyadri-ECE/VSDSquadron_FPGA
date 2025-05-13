module uart_rx #(parameter CLKS_PER_BIT = 1250) (
    input clk,            // System clock
    input rx,             // UART RX input
    output reg [7:0] data_out,  // 8-bit received data (e.g., angle)
    output reg data_ready      // Signal to indicate data is ready to be read
);
    localparam IDLE = 3'b000,
               START = 3'b001,
               DATA = 3'b010,
               STOP = 3'b011;
    reg [2:0] state = IDLE;
    reg [3:0] bit_index = 0;
    reg [12:0] clk_count = 0;
    reg [7:0] data_reg = 8'h00;
    reg rx_sync1, rx_sync2; // For synchronizing RX input

    always @(posedge clk) begin
        // Synchronize rx to the system clock
        rx_sync1 <= rx;
        rx_sync2 <= rx_sync1;
    end

    always @(posedge clk) begin
        case (state)
            IDLE: begin
                data_ready <= 0;
                if (!rx_sync2) begin // Start bit detected
                    state <= START;
                end
            end

            START: begin
                if (clk_count < CLKS_PER_BIT - 1)
                    clk_count <= clk_count + 1;
                else begin
                    clk_count <= 0;
                    state <= DATA;
                end
            end

            DATA: begin
                data_reg[bit_index] <= rx_sync2;
                if (clk_count < CLKS_PER_BIT - 1)
                    clk_count <= clk_count + 1;
                else begin
                    clk_count <= 0;
                    if (bit_index < 7)
                        bit_index <= bit_index + 1;
                    else
                        state <= STOP;
                end
            end

            STOP: begin
                if (clk_count < CLKS_PER_BIT - 1)
                    clk_count <= clk_count + 1;
                else begin
                    clk_count <= 0;
                    data_out <= data_reg;
                    data_ready <= 1;
                    state <= IDLE;
                end
            end
        endcase
    end
endmodule
