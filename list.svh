`define UART
`define DATA_WIDTH 16
`define COUNT 10
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "axi_intf.sv"
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
`include "uart_tx.sv"
`include "uart_rx.sv"
`include "uart.sv"