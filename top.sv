
`include "list.svh"

//`define DATA_WIDTH 16
module top ;
import uvm_pkg::*;
    bit clk,rst;
    axi_intf#(`DATA_WIDTH) inf();
assign inf.clk=clk;
assign inf.rst=rst;

    initial
    begin
        forever
        #4 clk = ~clk;
    end

    initial
    begin
      
        rst  =  1;
        #9 ;
        #2 rst  =  0; 
    end

    initial
    begin
        $dumpfile("axi4_stream.vcd");
        $dumpvars(0,top,top.inf);
    end

   initial
   begin
       uvm_config_db#(virtual axi_intf#(`DATA_WIDTH))::set(null, "*", "vif", inf);
       run_test();
   end

endmodule