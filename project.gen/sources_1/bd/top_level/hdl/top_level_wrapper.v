//Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2021.1 (lin64) Build 3247384 Thu Jun 10 19:36:07 MDT 2021
//Date        : Mon Sep  9 11:58:16 2024
//Host        : rrouwprlc0283 running 64-bit Ubuntu 22.04.4 LTS
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
    PT,
    SW);
  input BTNU;
  input CLK100MHZ;
  input CPU_RESETN;
  output [15:0]LED;
  input [5:0]PT;
  input [9:0]SW;

  wire BTNU;
  wire CLK100MHZ;
  wire CPU_RESETN;
  wire [15:0]LED;
  wire [5:0]PT;
  wire [9:0]SW;

  top_level top_level_i
       (.BTNU(BTNU),
        .CLK100MHZ(CLK100MHZ),
        .CPU_RESETN(CPU_RESETN),
        .LED(LED),
        .PT(PT),
        .SW(SW));
endmodule
