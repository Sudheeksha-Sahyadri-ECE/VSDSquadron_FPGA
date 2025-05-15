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

![CIRCUIT](https://github.com/user-attachments/assets/9f2334ca-fffa-4e4a-bd76-b06a40756329)


 ![video](https://github.com/Sudheeksha-Sahyadri-ECE/VSDSquadron_FPGA/issues/3#issue-3064558876)
