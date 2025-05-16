`include "uart_trx.v"

module top (
    input clk,
    input uartrx,
    output [6:0] seg,
    output dp
);

    wire [7:0] rxbyte;
    wire received;
    reg [3:0] digit = 0;
    reg [6:0] seg_reg = 7'b1111110;

    assign seg = ~seg_reg;  // Invert for common anode
    assign dp = 1'b1;       // Decimal point OFF

    uart_rx_8n1 uart_inst (
        .clk(clk),
        .rx(uartrx),
        .rxbyte(rxbyte),
        .received(received)
    );

    always @(posedge clk) begin
        if (received) begin
            if (rxbyte >= "0" && rxbyte <= "9") begin
                digit <= rxbyte - "0";
            end
        end
    end

    always @(*) begin
        case (digit)
            4'd0: seg_reg = 7'b1111110;
            4'd1: seg_reg = 7'b0110000;
            4'd2: seg_reg = 7'b1101101;
            4'd3: seg_reg = 7'b1111001;
            4'd4: seg_reg = 7'b0110011;
            4'd5: seg_reg = 7'b1011011;
            4'd6: seg_reg = 7'b1011111;
            4'd7: seg_reg = 7'b1110000;
            4'd8: seg_reg = 7'b1111111;
            4'd9: seg_reg = 7'b1111011;
            default: seg_reg = 7'b0000001; // Error symbol
        endcase
    end

endmodule
