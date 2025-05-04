# UART-Based Sensor Data Transmission System for FPGA

## 📌 Objective

Implement a UART transmitter that sends data based on sensor inputs, enabling the FPGA to communicate real-time sensor data to an external device.

---

## 🔍 Step 1: Study the Existing Code

### 📁 Module Overview

The `uart_tx_sense` module implements a UART transmitter designed for sensor-based data communication. It consists of the following key blocks:

- **Data Buffer Management**  
  Temporarily stores 32-bit sensor input data.

- **UART Protocol Controller**  
  Handles UART protocol format: start, data, and stop bits.

- **Transmission Control Logic**  
  Controls when and how data is sent serially.

---

### ⚙️ Operation Flow

#### 1. Data Acquisition

- Data is captured when the `valid` signal is asserted.
- The system must be in the `IDLE` state to accept new data.
- Captured data is stored in a 32-bit internal register.

#### 2. Transmission Protocol

- **START Bit**: Transmits a logic low (`0`) to indicate the beginning of a frame.
- **DATA Bits**: Transmits 8 bits serially, LSB first.
- **STOP Bit**: Transmits a logic high (`1`) to complete the frame.

#### 3. Status Signals

- **`ready`**: Indicates the system is ready to receive new data.
- **`tx_out`**: Carries the serial UART-formatted output stream.

---

### 🔌 Port Interface

| Signal    | Direction | Description                                 |
|-----------|-----------|---------------------------------------------|
| `clk`     | Input     | System clock                                |
| `reset_n` | Input     | Active-low reset                            |
| `data`    | Input     | 32-bit sensor data input                    |
| `valid`   | Input     | Indicates that input data is valid          |
| `tx_out`  | Output    | UART serial output                          |
| `ready`   | Output    | Indicates readiness for new data input      |

---

## 🧠 Step 2: Design Documentation

### 📦 Block Diagram


### 🔌 Circuit Diagram

> **Note:** The following describes the hardware setup in text form. Use a tool like Fritzing or KiCad for the visual diagram.

- Sensor → FPGA Inputs (`data[31:0]`, `valid`)
- FPGA UART `tx_out` → USB-to-Serial Converter (e.g., CP2102 or FTDI) → PC
- Power Supply: 3.3V/5V regulated to FPGA and sensor module
- Common ground between FPGA and external device

---

## 🛠️ Step 3: Implementation

### ✅ Hardware Setup

- Connect your sensor to the FPGA pins.
- Ensure UART TX pin from FPGA connects to the RX pin of a USB-Serial converter.
- Power the board properly using a regulated 3.3V/5V power source.

### 💻 Steps to Build and Flash

1. Open terminal and navigate to project folder:
   ```bash
   cd VSDSquadron_FM/uart_transmission/uart_tx_sense

   ### ✅ Verify FPGA is Connected

Open a terminal and run the following command to ensure the FPGA board is detected:

```bash
lsusb
```
### 🛠️ Build the Code

Navigate to the project directory and build the design using the following command:

```bash
make build
```
### 🔁 Flash the Bitstream to FPGA

Once the build is complete, use the following command to flash the bitstream to your FPGA:

```bash
sudo make flash
```
## 🧪 Step 4: Testing and Verification

### 🔌 Connect Serial Monitor

- Use PuTTY, CoolTerm, or any serial monitor.
- Set baud rate (e.g., 9600 or as per your UART setup).
- Select the correct COM port (e.g., `COM64`).

### 📈 Expected Output

- A stream of ASCII characters (e.g., "D", "E", etc.) will appear on the screen.
- When sensor input is stimulated, you will observe different outputs.
- On successful transmission, the RGB LED on the FPGA may turn **Red** (if integrated into logic).

---

## 📝 Step 5: Documentation

### 📄 Included in Final Report

- Block Diagram
- Circuit Diagram
- Verilog Code Overview
- Testing Procedure and Results
- Status Signals Description
- Expected UART Output Format

### 🎥 Video Demonstration


- Real-time sensor input.
- UART serial transmission.
- Live output on terminal.
- FPGA status indication (LED change, etc.).

---

## ✅ Summary

- Built a sensor-based UART transmission module.
- Implemented Verilog code with a clean FSM design.
- Verified data on serial terminal.
- Documented the full pipeline from data acquisition to UART output.

---

## 📚 References

- [VSDSquadron GitHub Repository](https://github.com)
- FPGA board documentation and datasheet
- UART protocol standard


