// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (lin64) Build 2708876 Wed Nov  6 21:39:14 MST 2019
// Date        : Wed Nov 20 00:14:23 2019
// Host        : nicklinux running 64-bit unknown
// Command     : write_verilog -force ./build/cpu_impl_netlist.v
// Design      : CPU
// Purpose     : This is a Verilog netlist of the current design or from a specific cell of the design. The output is an
//               IEEE 1364-2001 compliant Verilog HDL file that contains netlist information obtained from the input
//               design files.
// Device      : xc7vx485tffg1761-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* ECO_CHECKSUM = "726190cd" *) 
(* STRUCTURAL_NETLIST = "yes" *)
module CPU
   (clk_i,
    rst_i,
    wr_instr_en_i,
    wr_instr_i,
    out_o);
  input clk_i;
  input rst_i;
  input wr_instr_en_i;
  input [7:0]wr_instr_i;
  output out_o;

  wire \<const0> ;
  wire out_o;

  GND GND
       (.G(\<const0> ));
  OBUF out_o_OBUF_inst
       (.I(\<const0> ),
        .O(out_o));
endmodule
