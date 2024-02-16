
class axi4_slave_seq_item extends uvm_sequence_item;

    
    randc bit ready_before_valid; // 0-> valid before ready , 1->ready before valid
    randc int clk_count;
    //Utility and Field macros,
    `uvm_object_utils_begin(axi4_slave_seq_item)
    `uvm_object_utils_end
  
    constraint range{clk_count inside{[0:15]};}
    //Constructor
    function new(string name = "axi4_slave_seq_item");
        super.new(name);
    endfunction
  
  
endclass : axi4_slave_seq_item