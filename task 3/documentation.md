# Task 3: Developing a UART Transmitter Module

## Objective
To design and implement a UART transmitter module on the FPGA that enables serial communication by converting 8-bit parallel data into a serial bitstream, facilitating data transmission to external devices such as PCs or microcontrollers.

---

## Step 1: Study the Existing Code

A UART transmitter module facilitates serial communication by transmitting data bits one by one over a single line. It is a key interface in embedded systems and FPGA-based communication.

**Repository Links**:
- Project source: [VSDSquadron_FM](https://github.com/thesourcerer8/VSDSquadron_FM/tree/main/uart_tx)
- Internship Task Code: [UART Transmitter Task](https://github.com/Sudheeksha-Sahyadri-ECE/VSDSquadron_FPGA.git)

### Module Overview
- **Language**: VHDL
- **Configuration**: 8N1 (8 data bits, No parity, 1 stop bit)
- **Baud Rate**: Defined in code (commonly 9600 bps)

### State Machine Description
1. **STATE_IDLE**:
   - TX line remains HIGH (idle).
   - Waits for a signal to begin transmission (`senddata`).
   - Clears the `txdone` flag.

2. **STATE_STARTTX**:
   - Sends the **start bit** (logic LOW).
   - Loads the transmission buffer with `txbyte`.
   - Proceeds to TXING state.

3. **STATE_TXING**:
   - Sends 8 data bits serially (LSB first).
   - Shifts the buffer right each clock cycle.
   - Continues until all bits are transmitted.

4. **STATE_TXDONE**:
   - Sends the **stop bit** (logic HIGH).
   - Sets `txdone` flag.
   - Returns to **IDLE**.

---

## Step 2: Design Documentation

 **Block Diagram**: Illustrates the architecture of the UART loopback mechanism.
   - ![Image](https://github.com/Sudheeksha-Sahyadri-ECE/VSDSquadron_FPGA/blob/main/task%203/block%20diagram.jpg?raw=true)
2. **Circuit Diagram**: Shows the connections between the FPGA and peripherals used in the design.
   - !![Image](https://github.com/Sudheeksha-Sahyadri-ECE/VSDSquadron_FPGA/blob/main/task%203/circuit%20diagram.jpg?raw=true)
---

## Step 3: Implementation

### File Setup and Compilation
1. Create a new folder under `VSDSquadron_FM` and add the UART transmitter code files.
2. Open a terminal and navigate using:
   ```bash
   cd VSDSquadron_FM
   cd uart_tx_sense
   ### 3. Confirm FPGA Connection

To verify that your FPGA is connected to your system, run the following command in the terminal:

```bash
lsusb
```
### 4. Compile and Upload the Design to the FPGA

To build the project and flash the bitstream onto the FPGA, use the following commands in your terminal:

```bash
make build
sudo make flash
```
## Step 4: Testing and Verification
### Serial Communication Setup

- Use a USB-to-Serial adapter to connect the FPGA’s *TX* pin to your PC.
- Open *PuTTY* or any terminal emulator.
- Set the serial configuration as follows:
  - *Port*: (e.g., COM6)
  - *Baud Rate*: 9600
  - *Data Bits*: 8
  - *Parity*: None
  - *Stop Bits*: 1
 ---
  - ### Expected Output

- Repeated characters like 'D' will appear on the serial terminal.
- The RGB LED on the board should blink in sequence (Red → Green → Blue), confirming successful transmission and correct state machine operation.

---
## Step 5: Documentation

### UART Transmission in Action

- *The video demonstrates*:
  - Proper hardware connections
  - Blinking RGB LED activity
  - Continuous serial output shown in PuTTY

---

## Conclusion

The UART transmitter module was successfully implemented and verified. The FPGA continuously transmits serial data in *8N1* format. The functionality was tested using PuTTY, with expected character output and RGB LED blinking behavior. This project confirms the reliability of an FSM-based UART implementation for real-time serial communication on an FPGA.
