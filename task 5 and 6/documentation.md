# LED Control via FPGA and UART

---

## 1. Project Overview

This project demonstrates controlling an LED using an FPGA and UART (Universal Asynchronous Receiver Transmitter) communication. The FPGA receives commands via UART and toggles the LED or cycles its color (if using RGB LED) accordingly. The project showcases basic UART communication and real-time hardware control using an FPGA.

---

## 2. Hardware Components

- **FPGA Board**: VSDSquadron FPGA Mini Board (or any iCE40-based board).
- **LED**: A single-color LED or RGB LED connected to GPIO pins.
- **Power Supply**: 5V USB or regulated power supply to power the FPGA board.
- **Wires and Breadboard**: To connect the LED with the board using resistors.
- **PC/Terminal**: For sending UART commands (e.g., using Tera Term or PuTTY).

---

## 3. Software Tools

- **Synthesis & Implementation**: Yosys, NextPNR, and IcePack for open-source FPGA flow.
- **Programming Language**: Verilog HDL.
- **UART Terminal**: Tera Term / PuTTY to send simple characters over serial.

---


---



## 4. System Architecture

1. **UART Receiver**: Receives serial data from the terminal.
2. **Logic Unit**: Based on the received data, the system decides LED behavior.
3. **LED Control**: A simple always block toggles or changes LED state.

### Block Diagram

UART Input → FPGA UART Receiver → Command Logic → LED ON/OFF or Color Cycle


---

## 5. Code Explanation

### UART Receiver Module

Receives a byte from UART and sets received high once a valid byte is captured.

```verilog
module uart_rx_8n1 (
    input clk,
    input rx,
    output reg [7:0] rxbyte = 0,
    output reg received = 0
);
    // UART decoding logic (9600 baud for 50 MHz clock)
    always @(posedge clk) begin
        if (rx) begin
            // Start of frame detection logic
            // Shifting and decoding the byte
            // Setting the received flag when a valid byte is captured
        end
    end
endmodule
```
### Top Module with LED Logic

```verilog
module top (
    input clk,
    input uartrx,
    output [2:0] rgb
);
    wire [7:0] rxbyte;
    wire received;

    reg [2:0] rgb_reg = 3'b001; // RED by default
    assign rgb = rgb_reg;

    // Instantiate the UART receiver module
    uart_rx_8n1 uart_inst (
        .clk(clk),
        .rx(uartrx),
        .rxbyte(rxbyte),
        .received(received)
    );

    // LED control logic based on received UART data
    always @(posedge clk) begin
        if (received) begin
            case (rgb_reg)
                3'b001: rgb_reg <= 3'b010; // RED → GREEN
                3'b010: rgb_reg <= 3'b100; // GREEN → BLUE
                3'b100: rgb_reg <= 3'b001; // BLUE → RED
                default: rgb_reg <= 3'b001;
            endcase
        end
    end
endmodule
```

# 6. Testing and Results

## Test Steps

1. **Connect FPGA via USB** and open UART terminal.
2. **Send any character** via terminal.
3. **Observe LED color change** or blinking pattern on each character input.

### Expected Output
The LED color blinks upon every UART input.

---

# 7. Challenges and Solutions

## Challenge 1: UART not responding
**Solution:** Match baud rate (e.g., 9600 bps) on both FPGA and terminal.

## Challenge 2: Wrong GPIO pins
**Solution:** Refer to board's PCF (pin constraint file) and verify correct connections.

## Challenge 3: Missing LED resistor
**Solution:** Use **220–330 ohm** series resistor to avoid burning the LED.

---

# 8. Conclusion
The project demonstrates how to interact with simple output peripherals like LEDs using UART communication on an FPGA. This is a beginner-friendly introduction to serial communication and real-time I/O control.
