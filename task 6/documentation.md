# UART-Based LED Actuation using FPGA

## 🔍 Project Summary

This project demonstrates how an FPGA board can receive serial commands over UART and activate three separate LEDs in a sequential pattern. The control signals are sent from a PC using the **Docklight terminal**, and the system interprets the received bytes to toggle LEDs accordingly.

---

## ⚙️ System Description

- A serial terminal (Docklight) is used to transmit data to the FPGA board via UART.
- Upon receiving a command, the FPGA turns ON one of the three LEDs (Red, Green, or Blue).
- The sequence follows a round-robin pattern: Red → Green → Blue → Red...
- Each valid byte received through UART results in switching to the next LED.

---

## 📟 Code Modules

### ✅ `top.v`

This module acts as the main controller for LED actuation.

```verilog
`include "uart_trx.v"

module top (
    input clk,
    input uartrx,
    output [2:0] rgb
);

    wire [7:0] rxbyte;
    wire received;
    reg [2:0] rgb_reg = 3'b001; // Start with RED
    assign rgb = rgb_reg;

    uart_rx_8n1 uart_inst (
        .clk(clk),
        .rx(uartrx),
        .rxbyte(rxbyte),
        .received(received)
    );

    always @(posedge clk) begin

        if (received) begin
            // Rotate through RED → GREEN → BLUE
            case (rgb_reg)
                3'b001: rgb_reg <= 3'b010; // RED → GREEN
                3'b010: rgb_reg <= 3'b100; // GREEN → BLUE
                3'b100: rgb_reg <= 3'b001; // BLUE → RED
                default: rgb_reg <= 3'b001; // fallback to RED
            endcase
        end
    end

endmodule
```

## 🧩 uart_trx.v Module

This module implements a **UART Receiver** in **8N1 format** (8 data bits, no parity, 1 stop bit) operating at **9600 baud**. It captures serial data on the `rx` line and provides the received byte and a `received` flag.

---

### 📄 Verilog Code

```verilog
module uart_rx_8n1 (
    input clk,
    input rx,
    output reg [7:0] rxbyte = 0,
    output reg received = 0
);

    reg [3:0] bitindex = 0;
    reg [7:0] data = 0;
    reg [12:0] clkcount = 0;
    reg busy = 0;
    reg rx_sync = 1;

    parameter BAUD_TICKS = 5208;  // 50 MHz / 9600 baud

    always @(posedge clk) begin
        rx_sync <= rx;

        if (!busy) begin
            received <= 0;
            if (rx_sync == 0) begin  // start bit detected
                busy <= 1;
                clkcount <= BAUD_TICKS / 2;
                bitindex <= 0;
            end
        end else begin
            if (clkcount == 0) begin
                clkcount <= BAUD_TICKS;
                if (bitindex < 8) begin
                    data[bitindex] <= rx_sync;
                    bitindex <= bitindex + 1;
                end else if (bitindex == 8) begin
                    rxbyte <= data;
                    received <= 1;
                    busy <= 0;
                end
            end else begin
                clkcount <= clkcount - 1;
            end
        end
    end

endmodule

```
## 🧩 VSDSquadronFM.pcf Module

```verilog
set_io clk     20  # Onboard 50MHz
set_io uartrx  15  # UART RX from FTDI/Docklight
set_io rgb[0]  2 # RED
set_io rgb[1]  3  # GREEN
set_io rgb[2]  4  # YELLOW
```

Circuit:

![CIRCUIT](https://github.com/Sudheeksha-Sahyadri-ECE/VSDSquadron_FPGA/blob/main/task%206/ckt.png?raw=true)

Working Video:

[https://github.com/user-attachments/assets/bce30ff7-64fd-4e4a-8977-a2be4b28ede3
](https://github.com/Sudheeksha-Sahyadri-ECE/VSDSquadron_FPGA/issues/3#issue-3064558876)
# 🔢 UART-Controlled 7-Segment Display using FPGA

## 🔍 Project Summary

This project demonstrates how an **FPGA board receives serial data via UART** and displays the corresponding number (`0` to `9`) on a **7-segment display**. The user can send ASCII digits through the Docklight terminal, and the FPGA will decode and update the 7-segment accordingly.

---

## ⚙️ System Description

- Data is sent over **UART** using the Docklight terminal at **9600 baud**.
- The FPGA receives each byte and checks if it’s a digit between `'0'` and `'9'`.
- If valid, it updates the **common anode 7-segment display**.
- Invalid characters are ignored.

---

## 📟 Code Modules

### ✅ `top.v`

```verilog
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
```

## 🧩 `uart_trx.v`

**UART Receiver module in 8N1 format at 9600 baud**

```verilog
module uart_rx_8n1 (
    input clk,
    input rx,
    output reg [7:0] rxbyte = 0,
    output reg received = 0
);

    reg [3:0] bitindex = 0;
    reg [7:0] data = 0;
    reg [12:0] clkcount = 0;
    reg busy = 0;
    reg rx_sync = 1;

    parameter BAUD_TICKS = 5208;  // 50 MHz / 9600 baud

    always @(posedge clk) begin
        rx_sync <= rx;

        if (!busy) begin
            received <= 0;
            if (rx_sync == 0) begin
                busy <= 1;
                clkcount <= BAUD_TICKS / 2;
                bitindex <= 0;
            end
        end else begin
            if (clkcount == 0) begin
                clkcount <= BAUD_TICKS;
                if (bitindex < 8) begin
                    data[bitindex] <= rx_sync;
                    bitindex <= bitindex + 1;
                end else if (bitindex == 8) begin
                    rxbyte <= data;
                    received <= 1;
                    busy <= 0;
                end
            end else begin
                clkcount <= clkcount - 1;
            end
        end
    end
endmodule
```
## 🧪 Docklight Test

- **Baud Rate:** 9600  
- **Data Format:** 8N1  
- **Send As:** Text (not Hex or Binary)  
- **Input:** Type ASCII digits like `0`, `1`, `2`, ..., `9`  
- **Output:** Corresponding number shown on the 7-segment display  

---

## ▶️ Working Video

📹 **[Demo Video on GitHub](https://github.com/Sudheeksha-Sahyadri-ECE/VSDSquadron_FPGA/issues/3#issue-3064558876)**  
