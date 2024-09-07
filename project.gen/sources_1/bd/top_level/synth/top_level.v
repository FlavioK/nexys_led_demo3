//Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2021.1 (lin64) Build 3247384 Thu Jun 10 19:36:07 MDT 2021
//Date        : Fri Sep  6 19:03:40 2024
//Host        : simtool-5 running 64-bit Ubuntu 20.04.6 LTS
//Command     : generate_target top_level.bd
//Design      : top_level
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module source_100mhz_imp_MSWE0P
   (CLK100MHZ,
    CPU_RESETN,
    clk_100mhz,
    peripheral_aresetn);
  input CLK100MHZ;
  input CPU_RESETN;
  output clk_100mhz;
  output [0:0]peripheral_aresetn;

  wire clk_in1_0_1;
  wire ext_reset_in_0_1;
  wire [0:0]proc_sys_reset_0_peripheral_aresetn;
  wire system_clock_clk_100mhz;

  assign clk_100mhz = system_clock_clk_100mhz;
  assign clk_in1_0_1 = CLK100MHZ;
  assign ext_reset_in_0_1 = CPU_RESETN;
  assign peripheral_aresetn[0] = proc_sys_reset_0_peripheral_aresetn;
  top_level_clk_wiz_0_0 system_clock
       (.clk_100mhz(system_clock_clk_100mhz),
        .clk_in1(clk_in1_0_1));
  top_level_proc_sys_reset_0_0 system_reset
       (.aux_reset_in(1'b1),
        .dcm_locked(1'b1),
        .ext_reset_in(ext_reset_in_0_1),
        .mb_debug_sys_rst(1'b0),
        .peripheral_aresetn(proc_sys_reset_0_peripheral_aresetn),
        .slowest_sync_clk(system_clock_clk_100mhz));
endmodule

(* CORE_GENERATION_INFO = "top_level,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=top_level,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=7,numReposBlks=6,numNonXlnxBlks=0,numHierBlks=1,maxHierDepth=1,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=3,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "top_level.hwdef" *) 
module top_level
   (BTNU,
    CLK100MHZ,
    CPU_RESETN,
    LED,
    SW);
  input BTNU;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLK100MHZ CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLK100MHZ, CLK_DOMAIN top_level_CLK100MHZ, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) input CLK100MHZ;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.CPU_RESETN RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.CPU_RESETN, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input CPU_RESETN;
  output [15:0]LED;
  input [9:0]SW;

  wire PIN_0_1;
  wire [15:0]axi_led_slave_leds;
  wire button_Q;
  wire clk_in1_0_1;
  wire [31:0]dance_master_M_AXI_ARADDR;
  wire dance_master_M_AXI_ARREADY;
  wire dance_master_M_AXI_ARVALID;
  wire [31:0]dance_master_M_AXI_AWADDR;
  wire dance_master_M_AXI_AWREADY;
  wire dance_master_M_AXI_AWVALID;
  wire dance_master_M_AXI_BREADY;
  wire [1:0]dance_master_M_AXI_BRESP;
  wire dance_master_M_AXI_BVALID;
  wire [31:0]dance_master_M_AXI_RDATA;
  wire dance_master_M_AXI_RREADY;
  wire [1:0]dance_master_M_AXI_RRESP;
  wire dance_master_M_AXI_RVALID;
  wire [31:0]dance_master_M_AXI_WDATA;
  wire dance_master_M_AXI_WREADY;
  wire [3:0]dance_master_M_AXI_WSTRB;
  wire dance_master_M_AXI_WVALID;
  wire [9:0]delay_switches_0_1;
  wire ext_reset_in_0_1;
  wire source_100mhz_clk_100mhz;
  wire [0:0]source_100mhz_peripheral_aresetn;
  wire [6:0]system_interconnect_M00_AXI_ARADDR;
  wire [2:0]system_interconnect_M00_AXI_ARPROT;
  wire system_interconnect_M00_AXI_ARREADY;
  wire system_interconnect_M00_AXI_ARVALID;
  wire [6:0]system_interconnect_M00_AXI_AWADDR;
  wire [2:0]system_interconnect_M00_AXI_AWPROT;
  wire system_interconnect_M00_AXI_AWREADY;
  wire system_interconnect_M00_AXI_AWVALID;
  wire system_interconnect_M00_AXI_BREADY;
  wire [1:0]system_interconnect_M00_AXI_BRESP;
  wire system_interconnect_M00_AXI_BVALID;
  wire [31:0]system_interconnect_M00_AXI_RDATA;
  wire system_interconnect_M00_AXI_RREADY;
  wire [1:0]system_interconnect_M00_AXI_RRESP;
  wire system_interconnect_M00_AXI_RVALID;
  wire [31:0]system_interconnect_M00_AXI_WDATA;
  wire system_interconnect_M00_AXI_WREADY;
  wire [3:0]system_interconnect_M00_AXI_WSTRB;
  wire system_interconnect_M00_AXI_WVALID;

  assign LED[15:0] = axi_led_slave_leds;
  assign PIN_0_1 = BTNU;
  assign clk_in1_0_1 = CLK100MHZ;
  assign delay_switches_0_1 = SW[9:0];
  assign ext_reset_in_0_1 = CPU_RESETN;
  top_level_axi_led_slave_0_0 axi_led_slave
       (.S_AXI_ARADDR(system_interconnect_M00_AXI_ARADDR),
        .S_AXI_ARPROT(system_interconnect_M00_AXI_ARPROT),
        .S_AXI_ARREADY(system_interconnect_M00_AXI_ARREADY),
        .S_AXI_ARVALID(system_interconnect_M00_AXI_ARVALID),
        .S_AXI_AWADDR(system_interconnect_M00_AXI_AWADDR),
        .S_AXI_AWPROT(system_interconnect_M00_AXI_AWPROT),
        .S_AXI_AWREADY(system_interconnect_M00_AXI_AWREADY),
        .S_AXI_AWVALID(system_interconnect_M00_AXI_AWVALID),
        .S_AXI_BREADY(system_interconnect_M00_AXI_BREADY),
        .S_AXI_BRESP(system_interconnect_M00_AXI_BRESP),
        .S_AXI_BVALID(system_interconnect_M00_AXI_BVALID),
        .S_AXI_RDATA(system_interconnect_M00_AXI_RDATA),
        .S_AXI_RREADY(system_interconnect_M00_AXI_RREADY),
        .S_AXI_RRESP(system_interconnect_M00_AXI_RRESP),
        .S_AXI_RVALID(system_interconnect_M00_AXI_RVALID),
        .S_AXI_WDATA(system_interconnect_M00_AXI_WDATA),
        .S_AXI_WREADY(system_interconnect_M00_AXI_WREADY),
        .S_AXI_WSTRB(system_interconnect_M00_AXI_WSTRB),
        .S_AXI_WVALID(system_interconnect_M00_AXI_WVALID),
        .clk(source_100mhz_clk_100mhz),
        .leds(axi_led_slave_leds),
        .resetn(source_100mhz_peripheral_aresetn));
  top_level_button_0_0 button
       (.CLK(source_100mhz_clk_100mhz),
        .PIN(PIN_0_1),
        .Q(button_Q));
  top_level_dance_master_0_0 dance_master
       (.M_AXI_ARADDR(dance_master_M_AXI_ARADDR),
        .M_AXI_ARREADY(dance_master_M_AXI_ARREADY),
        .M_AXI_ARVALID(dance_master_M_AXI_ARVALID),
        .M_AXI_AWADDR(dance_master_M_AXI_AWADDR),
        .M_AXI_AWREADY(dance_master_M_AXI_AWREADY),
        .M_AXI_AWVALID(dance_master_M_AXI_AWVALID),
        .M_AXI_BREADY(dance_master_M_AXI_BREADY),
        .M_AXI_BRESP(dance_master_M_AXI_BRESP),
        .M_AXI_BVALID(dance_master_M_AXI_BVALID),
        .M_AXI_RDATA(dance_master_M_AXI_RDATA),
        .M_AXI_RREADY(dance_master_M_AXI_RREADY),
        .M_AXI_RRESP(dance_master_M_AXI_RRESP),
        .M_AXI_RVALID(dance_master_M_AXI_RVALID),
        .M_AXI_WDATA(dance_master_M_AXI_WDATA),
        .M_AXI_WREADY(dance_master_M_AXI_WREADY),
        .M_AXI_WSTRB(dance_master_M_AXI_WSTRB),
        .M_AXI_WVALID(dance_master_M_AXI_WVALID),
        .button(button_Q),
        .clk(source_100mhz_clk_100mhz),
        .ms_delay(delay_switches_0_1),
        .resetn(source_100mhz_peripheral_aresetn));
  source_100mhz_imp_MSWE0P source_100mhz
       (.CLK100MHZ(clk_in1_0_1),
        .CPU_RESETN(ext_reset_in_0_1),
        .clk_100mhz(source_100mhz_clk_100mhz),
        .peripheral_aresetn(source_100mhz_peripheral_aresetn));
  top_level_smartconnect_0_0 system_interconnect
       (.M00_AXI_araddr(system_interconnect_M00_AXI_ARADDR),
        .M00_AXI_arprot(system_interconnect_M00_AXI_ARPROT),
        .M00_AXI_arready(system_interconnect_M00_AXI_ARREADY),
        .M00_AXI_arvalid(system_interconnect_M00_AXI_ARVALID),
        .M00_AXI_awaddr(system_interconnect_M00_AXI_AWADDR),
        .M00_AXI_awprot(system_interconnect_M00_AXI_AWPROT),
        .M00_AXI_awready(system_interconnect_M00_AXI_AWREADY),
        .M00_AXI_awvalid(system_interconnect_M00_AXI_AWVALID),
        .M00_AXI_bready(system_interconnect_M00_AXI_BREADY),
        .M00_AXI_bresp(system_interconnect_M00_AXI_BRESP),
        .M00_AXI_bvalid(system_interconnect_M00_AXI_BVALID),
        .M00_AXI_rdata(system_interconnect_M00_AXI_RDATA),
        .M00_AXI_rready(system_interconnect_M00_AXI_RREADY),
        .M00_AXI_rresp(system_interconnect_M00_AXI_RRESP),
        .M00_AXI_rvalid(system_interconnect_M00_AXI_RVALID),
        .M00_AXI_wdata(system_interconnect_M00_AXI_WDATA),
        .M00_AXI_wready(system_interconnect_M00_AXI_WREADY),
        .M00_AXI_wstrb(system_interconnect_M00_AXI_WSTRB),
        .M00_AXI_wvalid(system_interconnect_M00_AXI_WVALID),
        .S00_AXI_araddr(dance_master_M_AXI_ARADDR),
        .S00_AXI_arprot({1'b0,1'b0,1'b0}),
        .S00_AXI_arready(dance_master_M_AXI_ARREADY),
        .S00_AXI_arvalid(dance_master_M_AXI_ARVALID),
        .S00_AXI_awaddr(dance_master_M_AXI_AWADDR),
        .S00_AXI_awprot({1'b0,1'b0,1'b0}),
        .S00_AXI_awready(dance_master_M_AXI_AWREADY),
        .S00_AXI_awvalid(dance_master_M_AXI_AWVALID),
        .S00_AXI_bready(dance_master_M_AXI_BREADY),
        .S00_AXI_bresp(dance_master_M_AXI_BRESP),
        .S00_AXI_bvalid(dance_master_M_AXI_BVALID),
        .S00_AXI_rdata(dance_master_M_AXI_RDATA),
        .S00_AXI_rready(dance_master_M_AXI_RREADY),
        .S00_AXI_rresp(dance_master_M_AXI_RRESP),
        .S00_AXI_rvalid(dance_master_M_AXI_RVALID),
        .S00_AXI_wdata(dance_master_M_AXI_WDATA),
        .S00_AXI_wready(dance_master_M_AXI_WREADY),
        .S00_AXI_wstrb(dance_master_M_AXI_WSTRB),
        .S00_AXI_wvalid(dance_master_M_AXI_WVALID),
        .aclk(source_100mhz_clk_100mhz),
        .aresetn(source_100mhz_peripheral_aresetn));
endmodule
