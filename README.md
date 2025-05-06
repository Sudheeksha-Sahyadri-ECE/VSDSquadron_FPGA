# VSDSquadron_FPGA

<details>
<summary>TASK1:RGB LED Control on VSDSquadron FPGA Mini Board

</summary>
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

