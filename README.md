# VSDSquadron_FPGA

# ABOUT ME
Name: SUDHEEKSHA SK
-
College: Sahyadri College of Engineering and Management, Adyar, Mangaluru.
-
Email ID: sudheeksha.ec22@sahyadri.edu.in or sudeekshas36@gmail.com
-
LinkedIn: [Sudheeksha SK](https://www.linkedin.com/in/sudeeksha-s-b3a78626a?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app)
-

<details>
<summary>TASK1:RGB LED Control on VSDSquadron FPGA Mini Board

</summary>
</summary>
</details>
# RGB LED Control on VSDSquadron FPGA Mini Board

This project demonstrates the implementation of a Verilog-based RGB LED control module on the **VSDSquadron FPGA Mini Board**. The design uses an internal oscillator to drive a frequency counter and control the on-board RGB LED through appropriate pin mappings and logic.

## Table of Contents

* [Overview](#overview)
* [Verilog Code Breakdown](#verilog-code-breakdown)
* [PCF File: Pin Mapping](#pcf-file-pin-mapping)
* [Board Integration](#board-integration)
* [Build and Flash Instructions](#build-and-flash-instructions)
* [Observations](#observations)
* [Challenges Faced](#challenges-faced)
* [Conclusion](#conclusion)

---

## Overview

The objective of this task is to understand and implement the provided Verilog code on the VSDSquadron FPGA Mini board. The core functionality includes:

* Using the **SB\_HFOSC** internal oscillator
* Driving outputs to onboard RGB LEDs
* Mapping signals to physical board pins
* Verifying hardware behavior post-synthesis and flashing

---

## Verilog Code Breakdown

The design file [top.v](https://github.com/thesourcerer8/VSDSquadron_FM/blob/main/led_blue/top.v) includes:

### Module Ports:

* led_red, led_green, led_blue – RGB LED outputs
* hw_clk – Clock input from the board
* testwire – Used to monitor internal logic externally

### Internal Logic:

* **SB\_HFOSC**: The internal high-frequency oscillator generates a 12 MHz clock.
* **Counter Logic**: A register-based counter increases with every clock cycle.
* **RGB LED Driver**: LED outputs are toggled based on specific counter bits, creating a visible blinking pattern.

This structure ensures basic toggling of LEDs and helps in verifying board-to-code interaction.

---

## PCF File: Pin Mapping

The constraints file [VSDSquadronFM.pcf](https://github.com/thesourcerer8/VSDSquadron_FM/blob/main/led_blue/VSDSquadronFM.pcf) defines how each signal connects to the physical pins on the board:

| Signal      | Board Pin | Purpose              |
| ----------- | --------- | -------------------- |
| led_red   | 39        | Drives Red LED       |
| led_blue  | 40        | Drives Blue LED      |
| led_green | 41        | Drives Green LED     |
| hw_clk    | 20        | Board’s clock source |
| testwire  | 17        | Debug/Test output    |

These mappings are verified using the VSDSquadron FPGA Mini board datasheet, ensuring proper physical-to-logical signal correlation.

---

## Board Integration

### Steps Followed:

1. **Connected the Board** via USB-C as described in the datasheet.
2. Ensured **FTDI detection** using dmesg and verified with ls /dev/ttyUSB*.
3. Installed necessary tools:

   * yosys, nextpnr-ice40, icestorm, and openFPGALoader
4. Ensured Makefile was updated for:

   * Correct file paths
   * Proper target board flags (hx1k, etc.)

---

## Build and Flash Instructions

From the led_blue directory:

bash
make clean        # Clear old builds
make build        # Synthesize and place & route the design
sudo make flash   # Flash the design to the board


---

## Observations

* LEDs blink as expected, based on the internal counter logic.
* testwire can be probed using an oscilloscope or logic analyzer for further analysis.
* Integration was successful with no pin conflict or programming error.

---

## Challenges Faced

* FTDI serial detection required proper USB permissions on some systems.
* Understanding PCF pin naming and matching it with the board layout needed attention.

---

## Conclusion

This mini-project helped in understanding:

* FPGA basics using Verilog
* Creating and using a PCF constraints file
* Toolchain flow: Verilog → Bitstream → Flash
* Hardware-level debugging and LED testing

The setup now serves as a base to explore more complex FPGA-based digital designs.
</details>
<details>
<summary>TASK2: UART Loopback Mechanism Implementation

</summary>

\---.........................task 2:# UART Loopback Mechanism Implementation

## Objective:

The goal of this project is to implement a UART (Universal Asynchronous Receiver-Transmitter) loopback mechanism, which allows for the immediate reception of transmitted data. This functionality is useful for testing and verifying UART communication on FPGA boards.

## Overview:

UART is a commonly used protocol for serial communication. It utilizes two primary data lines: TX (Transmit) and RX (Receive). In a loopback configuration, the transmitted data on the TX pin is routed directly back to the RX pin. This provides a convenient method for testing UART functionality without requiring an external device.

The existing Verilog code is sourced from [VSDSquadron\_FM](https://github.com/thesourcerer8/VSDSquadron_FM/tree/main/uart_loopback).

## Code Analysis:

The provided Verilog code includes several key components that facilitate the UART loopback mechanism:

### 1. **Port Breakdown:**

* **RGB LED outputs**: led_red, led_blue, led_green
* **UART pins**: uarttx (Transmit), uartrx (Receive)
* **Clock input**: hw_clk

### 2. **Internal Components:**

* **Oscillator (SB\_HFOSC)**: Provides the internal clock signal (int_osc).
* **Frequency Counter**: A 28-bit counter that increments on the positive edge of the internal clock, providing a timing reference for the system.
* **UART Loopback**: Direct connection between the TX and RX pins for data transmission and reception.
* **RGB LED Driver (SB\_RGBA\_DRV)**: Converts the received UART data into PWM signals for controlling LED brightness.

### 3. **System Operation:**

* **UART Communication**: The received data is immediately transmitted back out, and the same data is used to control the RGB LEDs.
* **LED Control**: The UART data drives all three LEDs with PWM signals.
* **Timing and Frequency Generation**: The internal oscillator and frequency counter generate the required timing for the system.

## Step 1: Design Overview

The UART loopback system consists of the following elements:

1. **Block Diagram**: Illustrates the architecture of the UART loopback mechanism.

   * ![Image](https://github.com/Sudheeksha-Sahyadri-ECE/VSDSquadron_FPGA/blob/main/task2/block%20diagram.jpg?raw=true)
2. **Circuit Diagram**: Shows the connections between the FPGA and peripherals used in the design.

   * !![Image](https://github.com/Sudheeksha-Sahyadri-ECE/VSDSquadron_FPGA/blob/main/task2/circuit%20diagram.jpg?raw=true)

## Step 2: Code and Files Structure

Create the following files in a folder named UART_loopback under VSDSquadronFM:

* **Makefile**: For build automation.
* **uart\_trx.v**: Verilog code for UART transmission and reception.
* **top\_module.v**: Top module integrating the UART system.
* **pcf file**: Pin configuration file.

### Directory Structure:

bash
VSDSquadronFM/
└── UART_loopback/
    ├── Makefile
    ├── uart_trx.v
    ├── top_module.v
    └── uart_loopback.pc


# Step 3: Transmitting Code to the FPGA Board

Once the files are ready, proceed with the following steps to transmit the code to the FPGA board:

## Navigate to the Project Folder

bash
cd VSDSquadron_FM
cd UART_loopback


## check for FPGA connection

# Build and Flash the FPGA

bash
make build
sudo make flash


# Step 4: Testing the UART Loopback

To test the UART loopback functionality, use the **Docklight** software.

1. Download and install Docklight from the official website.

2. Open Docklight and ensure it is connected to the correct communication port (e.g., **COM7**).

3. If necessary, change the port under:

4. Set the baud rate to **9600**.

# Step 5: Documentation and Results

## Block and Circuit Diagrams

* Add block and circuit diagrams here.

## Testing Results

* * !![Image](https://github.com/Sudheeksha-Sahyadri-ECE/VSDSquadron_FPGA/blob/main/task2/FPGA_uartloopback_picture.jpg?raw=true)

## Video Demonstration

* A video demonstrating the UART loopback functionality is available:
* **Video Demonstration**:
  [Click here to watch the video](https://github.com/Sudheeksha-Sahyadri-ECE/VSDSquadron_FPGA/raw/refs/heads/main/task2/uart_loopback_demovideo.mp4)

# Conclusion

This project successfully implements a UART loopback mechanism on an FPGA board, enabling effective testing of UART communication functionality.
The loopback allows data sent to the TX pin to be immediately received back on the RX pin, providing an efficient means for testing UART hardware communication.
</details>
<details>
<summary>TASK3:Developing a UART Transmitter Module
</summary>
task3:# Task 3: Developing a UART Transmitter Module

## Objective

To design and implement a UART transmitter module on the FPGA that enables serial communication by converting 8-bit parallel data into a serial bitstream, facilitating data transmission to external devices such as PCs or microcontrollers.

---

## Step 1: Study the Existing Code

A UART transmitter module facilitates serial communication by transmitting data bits one by one over a single line. It is a key interface in embedded systems and FPGA-based communication.

**Repository Links**:

* Project source: [VSDSquadron\_FM](https://github.com/thesourcerer8/VSDSquadron_FM/tree/main/uart_tx)
* Internship Task Code: [UART Transmitter Task](https://github.com/Sudheeksha-Sahyadri-ECE/VSDSquadron_FPGA.git)

### Module Overview

* **Language**: VHDL
* **Configuration**: 8N1 (8 data bits, No parity, 1 stop bit)
* **Baud Rate**: Defined in code (commonly 9600 bps)

### State Machine Description

1. **STATE\_IDLE**:

   * TX line remains HIGH (idle).
   * Waits for a signal to begin transmission (senddata).
   * Clears the txdone flag.

2. **STATE\_STARTTX**:

   * Sends the **start bit** (logic LOW).
   * Loads the transmission buffer with txbyte.
   * Proceeds to TXING state.

3. **STATE\_TXING**:

   * Sends 8 data bits serially (LSB first).
   * Shifts the buffer right each clock cycle.
   * Continues until all bits are transmitted.

4. **STATE\_TXDONE**:

   * Sends the **stop bit** (logic HIGH).
   * Sets txdone flag.
   * Returns to **IDLE**.

---

## Step 2: Design Documentation

**Block Diagram**: Illustrates the architecture of the UART loopback mechanism.

* ![Image](https://github.com/Sudheeksha-Sahyadri-ECE/VSDSquadron_FPGA/blob/main/task%203/block%20diagram.jpg?raw=true)

2. **Circuit Diagram**: Shows the connections between the FPGA and peripherals used in the design.

   * !![Image](https://github.com/Sudheeksha-Sahyadri-ECE/VSDSquadron_FPGA/blob/main/task%203/circuit%20diagram.jpg?raw=true)

---

## Step 3: Implementation

### File Setup and Compilation

1. Create a new folder under VSDSquadron_FM and add the UART transmitter code files.
2. Open a terminal and navigate using:

   
bash
   cd VSDSquadron_FM
   cd uart_tx_sense
   ### 3. Confirm FPGA Connection


To verify that your FPGA is connected to your system, run the following command in the terminal:

bash
lsusb


### 4. Compile and Upload the Design to the FPGA

To build the project and flash the bitstream onto the FPGA, use the following commands in your terminal:

bash
make build
sudo make flash


## Step 4: Testing and Verification

### Serial Communication Setup

* Use a USB-to-Serial adapter to connect the FPGA’s *TX* pin to your PC.
* Open *PuTTY* or any terminal emulator.
* Set the serial configuration as follows:

  * *Port*: (e.g., COM6)
  * *Baud Rate*: 9600
  * *Data Bits*: 8
  * *Parity*: None
  * *Stop Bits*: 1

---

* ### Expected Output

* Repeated characters like 'D' will appear on the serial terminal.

* The RGB LED on the board should blink in sequence (Red → Green → Blue), confirming successful transmission and correct state machine operation.

---

## Step 5: Documentation

### UART Transmission in Action

* *The video demonstrates*:

  * Proper hardware connections
  * Blinking RGB LED activity
  * Continuous serial output shown in PuTTY

---

## Conclusion

The UART transmitter module was successfully implemented and verified. The FPGA continuously transmits serial data in *8N1* format. The functionality was tested using PuTTY, with expected character output and RGB LED blinking behavior. This project confirms the reliability of an FSM-based UART implementation for real-time serial communication on an FPGA.
</details>
<details>
<summary>TASK4:UART-Based Sensor Data Transmission System for FPGA
</summary>
task4:# UART-Based Sensor Data Transmission System for FPGA

## 📌 Objective

Implement a UART transmitter that sends data based on sensor inputs, enabling the FPGA to communicate real-time sensor data to an external device.

---

## 🔍 Step 1: Study the Existing Code

### 📁 Module Overview

The uart_tx_sense module implements a UART transmitter designed for sensor-based data communication. It consists of the following key blocks:

* **Data Buffer Management**
  Temporarily stores 32-bit sensor input data.

* **UART Protocol Controller**
  Handles UART protocol format: start, data, and stop bits.

* **Transmission Control Logic**
  Controls when and how data is sent serially.

---

### ⚙️ Operation Flow

#### 1. Data Acquisition

* Data is captured when the valid signal is asserted.
* The system must be in the IDLE state to accept new data.
* Captured data is stored in a 32-bit internal register.

#### 2. Transmission Protocol

* **START Bit**: Transmits a logic low (0) to indicate the beginning of a frame.
* **DATA Bits**: Transmits 8 bits serially, LSB first.
* **STOP Bit**: Transmits a logic high (1) to complete the frame.

#### 3. Status Signals

* **ready**: Indicates the system is ready to receive new data.
* **tx_out**: Carries the serial UART-formatted output stream.

---

### 🔌 Port Interface

| Signal    | Direction | Description                            |
| --------- | --------- | -------------------------------------- |
| clk     | Input     | System clock                           |
| reset_n | Input     | Active-low reset                       |
| data    | Input     | 32-bit sensor data input               |
| valid   | Input     | Indicates that input data is valid     |
| tx_out  | Output    | UART serial output                     |
| ready   | Output    | Indicates readiness for new data input |

---

## 🧠 Step 2: Design Documentation

**Block Diagram**: Illustrates the architecture of the UART loopback mechanism.

* ![Image](https://github.com/Sudheeksha-Sahyadri-ECE/VSDSquadron_FPGA/blob/main/task%204/blockdiagram.jpg?raw=true)

2. **Circuit Diagram**: Shows the connections between the FPGA and peripherals used in the design.

   * !![Image](https://github.com/Sudheeksha-Sahyadri-ECE/VSDSquadron_FPGA/blob/main/task%204/circuitdiagram.jpg?raw=true)

---

> **Note:** The following describes the hardware setup in text form. Use a tool like Fritzing or KiCad for the visual diagram.

* Sensor → FPGA Inputs (data[31:0], valid)
* FPGA UART tx_out → USB-to-Serial Converter (e.g., CP2102 or FTDI) → PC
* Power Supply: 3.3V/5V regulated to FPGA and sensor module
* Common ground between FPGA and external device

---

## 🛠️ Step 3: Implementation

### ✅ Hardware Setup

* Connect your sensor to the FPGA pins.
* Ensure UART TX pin from FPGA connects to the RX pin of a USB-Serial converter.
* Power the board properly using a regulated 3.3V/5V power source.

### 💻 Steps to Build and Flash

1. Open terminal and navigate to project folder:

   
bash
   cd VSDSquadron_FM/uart_transmission/uart_tx_sense

   ### ✅ Verify FPGA is Connected


Open a terminal and run the following command to ensure the FPGA board is detected:

bash
lsusb


### 🛠️ Build the Code

Navigate to the project directory and build the design using the following command:

bash
make build


### 🔁 Flash the Bitstream to FPGA

Once the build is complete, use the following command to flash the bitstream to your FPGA:

bash
sudo make flash


## 🧪 Step 4: Testing and Verification

### 🔌 Connect Serial Monitor

* Use PuTTY, CoolTerm, or any serial monitor.
* Set baud rate (e.g., 9600 or as per your UART setup).
* Select the correct COM port (e.g., COM64).

### 📈 Expected Output

* A stream of ASCII characters (e.g., "D", "E", etc.) will appear on the screen.
* When sensor input is stimulated, you will observe different outputs.
* On successful transmission, the RGB LED on the FPGA may turn **Red** (if integrated into logic).

---

## 📝 Step 5: Documentation

### 📄 Included in Final Report

* Block Diagram
* Circuit Diagram
* Verilog Code Overview
* Testing Procedure and Results
* Status Signals Description
* Expected UART Output Format

### 🎥 Video Demonstration

* Real-time sensor input.
* UART serial transmission.
* Live output on terminal.
* FPGA status indication (LED change, etc.).

---

## ✅ Summary

* Built a sensor-based UART transmission module.
* Implemented Verilog code with a clean FSM design.
* Verified data on serial terminal.
* Documented the full pipeline from data acquisition to UART output.

---

## 📚 References

* [VSDSquadron GitHub Repository](https://github.com)
* FPGA board documentation and datasheet
* UART protocol standard
</details>


<details>
<summary>TASK5:overview of project themes

# FPGA Project Documentation

## Project Theme 1: FPGA-Based Real-Time Display via UART

### Concept Summary
This project involves developing a real-time data display system where an FPGA receives data through UART (Universal Asynchronous Receiver/Transmitter) and presents it on a display unit such as a 7-segment module or LCD. The focus is on implementing robust UART communication, effective data decoding, and seamless display updates.

---

### Goals
- Build a UART receiver (Rx-only) on the FPGA  
- Translate received ASCII or hex data into a readable format  
- Control a 7-segment or LCD module to reflect the received values  
- Optionally create a simple PC-based user interface  
- Maintain consistent and real-time communication  

---

### Hardware and Software Requirements

**Platform:**  
- VSDSquadron FPGA Mini Board  
- Display device (7-segment or LCD)  
- PC running Ubuntu  

**Tools:**  
- Docklight (for UART communication testing)  

---

### System Block Outline

1. **UART Reception Module:**  
   Captures serial data from a connected host (PC or microcontroller), converts it into parallel bits, and stores it in a buffer. Developed in Verilog or VHDL. Simulations validate reception of characters like '0' to '9'.

2. **Data Interpretation:**  
   Incoming ASCII values are mapped to usable formats — either binary digits or display-specific patterns. This ensures accurate interpretation before display.

3. **Display Driver Logic:**  
   Updates the connected display (7-segment or LCD) in real time using the decoded data. Can use a combinational or FSM-based design for segment updates.

4. **Integration & Testing:**  
   - Integrate all modules into a top-level design  
   - Flash onto the FPGA  
   - Use Docklight to send UART data  
   - Verify correct display output
  
   ![fpga_uart_display_block_diagram_tall](https://private-user-images.githubusercontent.com/150655928/443890936-de1bb1db-0766-42b8-88c8-cbd607e55bf7.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NDcyNjgyNjksIm5iZiI6MTc0NzI2Nzk2OSwicGF0aCI6Ii8xNTA2NTU5MjgvNDQzODkwOTM2LWRlMWJiMWRiLTA3NjYtNDJiOC04OGM4LWNiZDYwN2U1NWJmNy5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNTE1JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDUxNVQwMDEyNDlaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT01YTYwM2ZjNGUyMzVkYzAzM2YxNjA3MDg0OGUyOWVmZTYyOThjODdkMWVlZmJlOTEyMjY3M2JkMGZhNzAzNTdkJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.UowkJrxecsaocm5QrnEeLkpyabFYl7UZYcBmrNvZ5_Q)


---

### Functional Workflow

- Define UART parameters (baud rate, 8N1 format)
- Create UART receiver
- Decode received ASCII data
- Drive display device accordingly
- Test using Docklight and observe real-time updates

---

## Project Theme 2: UART-Controlled Device Activation Using FPGA

### Project Summary
This project focuses on enabling control of physical devices like LEDs or motors using an FPGA that responds to serial commands sent over UART. The system interprets simple textual commands and triggers outputs accordingly, demonstrating basic control logic for automation and embedded systems.

---

### Target Outcomes

- Set up a UART reception module in FPGA  
- Interpret string-based commands like `"MOTOR ON"` or `"LED OFF"`  
- Develop a finite state machine (FSM) to handle decoded instructions  
- Connect and control external devices like LEDs or motors  
- Enable real-time command input via serial interface  

---

### Required Hardware and Software

**Components:**  
- VSDSquadron FPGA Mini Board  
- Actuators: LEDs, Motor Driver, Relays  
- FTDI-based USB-to-Serial Interface  
- Breadboard and jumper wires  

**Development Environment:**  
- Ubuntu OS  
- Docklight or any serial terminal software  

---

### System Design Overview

1. **Initial Hardware Validation:**  
   Upload basic LED blink code to verify GPIOs and FPGA board functionality.

2. **UART Interface Module:**  
   - Build a UART receiver that detects the start bit, samples data bits, and forms 8-bit words  
   - Ensure correct baud rate configuration  
   - Simulate and validate functionality  

3. **Command Interpretation Unit:**  
   - Implement parser or FSM  
   - Store characters in buffer until a valid command like `"LED ON"` is detected  

4. **Actuator Control Logic:**  
   - Convert valid commands into GPIO control signals  
   - Drive external devices (LEDs, relays, motors)

5. **System Testing:**  
   - Use Docklight to send commands  
   - Observe real-time control response on actuators
  
6. ![fpga_uart_display_block_diagram_tall](https://private-user-images.githubusercontent.com/150655928/443891456-98973b6f-ad12-4e63-aed1-68a1aac7fffc.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NDcyNjg0MTYsIm5iZiI6MTc0NzI2ODExNiwicGF0aCI6Ii8xNTA2NTU5MjgvNDQzODkxNDU2LTk4OTczYjZmLWFkMTItNGU2My1hZWQxLTY4YTFhYWM3ZmZmYy5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNTE1JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDUxNVQwMDE1MTZaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT0yMWU0MTk4Mzc2N2UwMTQ0Njg1MjdmMGE1ZGMwOWYyNmIyNmZlNTIyMWQ0ZjYyYjdmYzUwNDVmOTBhMmVlMzVhJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.3pYiCdFPMuY3hXXHyc65BxNmGRBWJqIiYe2BVdtUAMU)

---



</summary>
</details>

<details>
 <summary>TASK6: implentation of the prokject </summary>

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

📹 **[Demo Video on GitHub](https://github.com/Sudheeksha-Sahyadri-ECE/VSDSquadron_FPGA/issues/5#issue-3068441406)
</details>
