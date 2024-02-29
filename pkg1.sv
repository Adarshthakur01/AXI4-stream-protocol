package pkg1;
import uvm_pkg::*;
`include "uvm_macros.svh"
`define DATA_WIDTH 16
`define COUNT 10
`include "axi4_master_seq_item.sv"
`include "axi4_slave_seq_item.sv"
`include "axi4_master_driver.sv"
`include "axi4_slave_driver.sv"
`include "axi4_seqr.sv"
`include "axi4_master_agent.sv"
`include "axi4_slave_agent.sv"
`include "axi4_env.sv"
`include "axi4_master_sequence.sv"
`include "axi4_slave_sequence.sv"
`include "axi4_test.sv"
endpackage
`include "axi_intf.sv"