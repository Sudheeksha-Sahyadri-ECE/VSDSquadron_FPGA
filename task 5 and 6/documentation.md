# **Servo Motor Control via FPGA and UART**

---

## **1. Project Overview**
This project demonstrates the control of a servo motor using an FPGA and UART (Universal Asynchronous Receiver Transmitter) communication. The FPGA receives commands via UART and generates corresponding Pulse Width Modulation (PWM) signals to control the position of the servo motor. The main goal of the project is to showcase the FPGA’s ability to interact with hardware peripherals using serial communication.

---

## **2. Hardware Components**
- **FPGA Board**: A basic FPGA board, such as Xilinx Spartan-6 or Altera Cyclone IV, is used for implementing the UART receiver and PWM generator.
- **Servo Motor**: A small DC servo motor (SG90 or similar) that can rotate to specified angles when provided with a PWM signal.
- **Power Supply**: A 5V regulated DC power supply is required for both the FPGA and the servo motor.
- **Wires and Connectors**: For making the necessary connections between the FPGA, servo motor, and power supply.
- **PC/Terminal**: Used to send UART commands to the FPGA, through serial communication (e.g., using Tera Term or PuTTY).

---

## **3. Software Tools**
- **FPGA Development Tools**: Vivado, Quartus, or any other FPGA development tool compatible with the target FPGA.
- **Programming Language**: Verilog is used to design the logic for both UART reception and PWM signal generation.
- **UART Terminal**: Software like Tera Term or PuTTY is used on the PC to send the control commands (in this case, numerical values) via UART to the FPGA.

---

## **4. System Architecture**
The system consists of several key components:

1. **UART Receiver**: The FPGA receives data (control commands) from a UART terminal.
2. **Data Processing Unit**: The FPGA decodes the incoming UART data, which corresponds to an angle (0 to 180 degrees).
3. **PWM Generator**: Based on the decoded angle, the FPGA generates a PWM signal that will control the servo motor’s position.
4. **Servo Motor**: The PWM signal drives the servo motor, rotating it to the desired angle.

### **Block Diagram**
- **UART Input** -> **FPGA UART Receiver** -> **Angle Data Decoding** -> **PWM Signal Generation** -> **Servo Motor Control**

---

## **5. Code Explanation**
- **UART Receiver Module**: The UART receiver is responsible for receiving data from the serial terminal. It decodes the incoming data and stores it for further processing.

  ```verilog
  module uart_receiver (
      input clk,
      input rx,       // UART input
      output reg [7:0] data_out
  );
      // UART reception logic: baud rate, start/stop bit detection
      always @(posedge clk) begin
          if (rx == 1'b0) begin
              // Logic to capture incoming data byte
              data_out <= data;
          end
      end
  endmodule
  
  ```
  # **Servo Motor Control via FPGA and UART**

---

## **5. Servo Control Logic**
Once the angle data is decoded, the PWM generator module takes the input and generates a PWM signal to drive the servo motor.

```verilog
module servo_control (
    input clk,
    input [7:0] angle_data,  // Incoming angle data (0-180 degrees)
    output pwm_signal
);
    // PWM generation logic: translates angle data to duty cycle
    // Example: angle 90 maps to a 50% duty cycle for the servo
    always @(posedge clk) begin
        pwm_signal <= (angle_data < 90) ? 1'b1 : 1'b0;  // Simple PWM signal
    end
endmodule
```

## **6. Testing and Results**

### **Test Procedure:**
- Connect the FPGA board to the UART terminal on the PC.

- The FPGA decodes the received value and generates the corresponding PWM signal to move the servo motor to the corresponding angle.

### **Expected Results:**
- The servo motor should move smoothly to the desired angle based on the value sent via UART.
- 
### **Video/Images:**
Attach a short video showing the servo motor responding to different UART commands (e.g., moving from 0° to 180°).

---

## **7. Challenges and Solutions**

### **Challenge 1**: UART baud rate mismatch
- **Solution**: Ensure both the UART terminal and FPGA UART receiver are set to the same baud rate (e.g., 9600 bps).

### **Challenge 2**: Servo control accuracy
- **Solution**: Adjust the duty cycle of the PWM signal more precisely to map it to the required angle range (0° to 180°).

### **Challenge 3**: Power supply fluctuations
- **Solution**: Use a stable 5V regulated power supply to avoid erratic servo behavior.

---

## **8. Conclusion**
This project successfully demonstrates how to control a servo motor using FPGA and UART communication. It highlights the capabilities of FPGA in handling serial data and controlling hardware peripherals in real-time. The project can be expanded to include more actuators or sensors, as needed for various applications like robotics or automation systems.
