# ERES Project – Environmental Monitoring System

## Repository Contents

This repository contains the project documentation and implementation developed at Hochschule München.

- **PDF:** Contains the final project presentation for the project acceptance.
- **`hardware/`:** Contains the PCB layout and schematic designed using Altium Designer.
- **`components/`:** Contains datasheets for the electronic components used in the project.
- **`source_code/`:** Contains the source code for Microchip SoftConsole, Libero SoC, and the Python-based PC application.

## Overview

The ERES Project is an embedded environmental monitoring system designed to monitor soil moisture and ambient temperature to help users improve plant care and watering decisions.

The system combines analog sensors, FPGA-based data acquisition, embedded software, and a PC-based human-machine interface (HMI).

## Features

- Acquisition of analog sensor signals using a 12-bit ADC.
- FPGA-based data acquisition and communication via SPI.
- Sensor data processing and conversion into physical units on the Microprocessor Subsystem (MSS).
- Storage of measurement history in SRAM using a ring buffer.
- Data transfer to a PC via UART.
- Visualization of temperature and soil moisture over time using a Python-based HMI.
- Extensible architecture with additional analog sensor inputs.
- Detection and reporting of sensor errors.

## System Architecture

1. **Sensors:** Measure soil moisture and ambient temperature.
2. **ADC:** Converts analog sensor signals into digital values.
3. **FPGA Fabric:** Handles ADC communication, data transfer, and measurement storage.
4. **Microprocessor Subsystem (MSS):** Processes ADC readings and converts them into physical values.
5. **PC Application:** Receives measurement data via UART and visualizes it using Python.

## Hardware and Software

- **SoC Platform:** PolarFire SoC Discovery Kit
- **FPGA Development:** Microchip Libero SoC
- **Embedded Software:** SoftConsole
- **Hardware Design:** Altium Designer
- **PC Application:** Python
- **Communication Interfaces:** SPI, AXI, UART
- **Data Storage:** SRAM
- **ADC:** 12-bit, four-channel ADC

## Project Scope

The project covers requirements engineering, system architecture, hardware design, embedded software development, FPGA integration, PC application development, and verification of the implemented functionality.

## References

- [MikroElektronika mikroBUS](https://www.mikroe.com/mikrobus)
- [MikroElektronika ADC Click](https://www.mikroe.com/adc-click)

## Project Information

Developed as part of a university project at Hochschule München.