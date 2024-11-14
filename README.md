# FPGA-FEC
An FPGA-accelerated platform for FEC analysis of wireline systems

## Table of Contents
* [General Info](#general-information)
* [Repository Organization](#repository-organization)

## General Information

This work was done for my MASc thesis project at University of Toronto.
Supervisor: Tony Chan Causone

For more information, see my thesis document in the Publications directory.

This repository is still in progress. Over the next few months leading up to DesignCon 2025, I will work to add content and better comment and document the code. 

## Repository Organization

The following explains the orginization of this repository. I reccommend first running some testbenches from the "code" directory to get an idea of how they work. Feel free to use and modify the modules to suit your own purposes. The vivado and vitis directories are included to provide an example of how I set up this platform on a ZCU102 board and run simulations. Feel free to use this as a reference, however modifications will be necessary to run this on different hardware. 

- /publications: publications based off the FPGA platform 
  - MASc Thesis
  - MWSCAS 2024 conference paper
  - TCAS-II Journal paper (upcoming)
  - DesignCon 2025 paper (upcoming)
      
- /code: contains the library modules for modelling wireline systems with FEC on the FPGA platform
    - /library: verilog modules for wireline system modelling
      - /top_level: 9 top-level verilog files defining different wireline systems, all with RS-KP4 FEC:
          - sys1: Single-part link with error propagation factor channel, with precoding and block interleaving
          - sys2: Single-part link with DFE error propagation markov model channel
          - sys3: Single-part link with analog AWGN channel
          - sys4: Single-part link with analog AWGN channel and hard-decision Hamming(128,120) inner FEC code
          - sys5: Single-part link with analog LPF coloured noise channel with convolutional interleaver and hard-decision Hamming(128,120) inner FEC code
          - sys6: Single-part link with 1+aD channel with AWGN and MLSE equalizer
          - sys7: Single-part link with AWGN channel, soft-output slicer, and soft-decision Hamming (68,60) inner FEC code
          - sys8: Single-part link with 1+aD channel with AWGN, SOVA equalizer and soft-decision Hamming (68,60) inner FEC code
          - sys9: Multi-part link (from case study section in Thesis document)
    - /testbench: verilog testbenches for each of the 9 systems
    - /matlab: various matlab scripts that were used to create the library of verilog modules and confirm their accuracy. 

- /vivado: contains a vivado project that implements the full FPGA platform including sys9, along with the microblaze processor, memory, and custom driver IP for programming the BER simulation IP settings

- /vitis: contains the vitis directory that has the software to program the Microblaze processor for a simulation that sweeps SNR for a range of channel conditions. 
