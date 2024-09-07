//Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2021.1 (lin64) Build 3247384 Thu Jun 10 19:36:07 MDT 2021
//Date        : Fri Sep  6 19:03:41 2024
//Host        : simtool-5 running 64-bit Ubuntu 20.04.6 LTS
//Command     : generate_target top_level_wrapper.bd
//Design      : top_level_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module top_level_wrapper
   (BTNU,
    CLK100MHZ,
    CPU_RESETN,
    LED,
    SW);
  input BTNU;
  input CLK100MHZ;
  input CPU_RESETN;
  output [15:0]LED;
  input [9:0]SW;

  wire BTNU;
  wire CLK100MHZ;
  wire CPU_RESETN;
  wire [15:0]LED;
  wire [9:0]SW;

  top_level top_level_i
       (.BTNU(BTNU),
        .CLK100MHZ(CLK100MHZ),
        .CPU_RESETN(CPU_RESETN),
        .LED(LED),
        .SW(SW));
endmodule
