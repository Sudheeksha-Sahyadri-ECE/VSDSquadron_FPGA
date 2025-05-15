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

---


