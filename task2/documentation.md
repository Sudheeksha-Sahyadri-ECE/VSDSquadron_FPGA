# UART Loopback Mechanism Implementation

## Objective:
The goal of this project is to implement a UART (Universal Asynchronous Receiver-Transmitter) loopback mechanism, which allows for the immediate reception of transmitted data. This functionality is useful for testing and verifying UART communication on FPGA boards.

## Overview:
UART is a commonly used protocol for serial communication. It utilizes two primary data lines: TX (Transmit) and RX (Receive). In a loopback configuration, the transmitted data on the TX pin is routed directly back to the RX pin. This provides a convenient method for testing UART functionality without requiring an external device.

The existing Verilog code can be found [here](https://github.com/Bhavankumar123/VSDSquadron-FPGA-Mini-Internship-program/blob/main/UARTexistingcode.v), sourced from [VSDSquadron_FM](https://github.com/thesourcerer8/VSDSquadron_FM/tree/main/uart_loopback).

## Code Analysis:
The provided Verilog code includes several key components that facilitate the UART loopback mechanism:

### 1. **Port Breakdown:**
   - **RGB LED outputs**: `led_red`, `led_blue`, `led_green`
   - **UART pins**: `uarttx` (Transmit), `uartrx` (Receive)
   - **Clock input**: `hw_clk`

### 2. **Internal Components:**
   - **Oscillator (SB_HFOSC)**: Provides the internal clock signal (`int_osc`).
   - **Frequency Counter**: A 28-bit counter that increments on the positive edge of the internal clock, providing a timing reference for the system.
   - **UART Loopback**: Direct connection between the TX and RX pins for data transmission and reception.
   - **RGB LED Driver (SB_RGBA_DRV)**: Converts the received UART data into PWM signals for controlling LED brightness.

### 3. **System Operation:**
   - **UART Communication**: The received data is immediately transmitted back out, and the same data is used to control the RGB LEDs.
   - **LED Control**: The UART data drives all three LEDs with PWM signals.
   - **Timing and Frequency Generation**: The internal oscillator and frequency counter generate the required timing for the system.

## Step 1: Design Overview
The UART loopback system consists of the following elements:

1. **Block Diagram**: Illustrates the architecture of the UART loopback mechanism.
   - ![Image](https://github.com/Sudheeksha-Sahyadri-EC/VSDSquadron_FPGA/blob/main/task2/block%20diagram.jpg?raw=true)
2. **Circuit Diagram**: Shows the connections between the FPGA and peripherals used in the design.
   - ![Circuit Diagram](image_placeholder)

## Step 2: Code and Files Structure
Create the following files in a folder named `UART_loopback` under `VSDSquadronFM`:

- **Makefile**: For build automation.
- **uart_trx.v**: Verilog code for UART transmission and reception.
- **top_module.v**: Top module integrating the UART system.
- **pcf file**: Pin configuration file.

### Directory Structure:
```bash
VSDSquadronFM/
└── UART_loopback/
    ├── Makefile
    ├── uart_trx.v
    ├── top_module.v
    └── uart_loopback.pc
```
# Step 3: Transmitting Code to the FPGA Board

Once the files are ready, proceed with the following steps to transmit the code to the FPGA board:

## Navigate to the Project Folder
```bash
cd VSDSquadron_FM
cd UART_loopback
```
## check for FPGA connection

# Build and Flash the FPGA

```bash
make build
sudo make flash
```
# Step 4: Testing the UART Loopback

To test the UART loopback functionality, use the **Docklight** software.

1. Download and install Docklight from the official website.
2. Open Docklight and ensure it is connected to the correct communication port (e.g., **COM7**).
3. If necessary, change the port under:

4. Set the baud rate to **9600**.

# Step 5: Documentation and Results

## Block and Circuit Diagrams
- Add block and circuit diagrams here.

## Testing Results
- Screenshots of Docklight demonstrating the loopback functionality.

## Video Demonstration
- A video demonstrating the UART loopback functionality is available: **VID_20250415_202951.mp4**
# Conclusion

This project successfully implements a UART loopback mechanism on an FPGA board, enabling effective testing of UART communication functionality.  
The loopback allows data sent to the TX pin to be immediately received back on the RX pin, providing an efficient means for testing UART hardware communication.
