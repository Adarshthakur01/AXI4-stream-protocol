import pkg1::*;

class axi4_master_seq_item extends uvm_sequence_item;

    rand    bit [(`DATA_WIDTH)-1 : 0]               data[$];
    randc   int                                     clk_count;
    randc   bit [6:0]                               id;
    randc   bit [3:0]                               dest;
    rand    bit [5:0]                               size;
    rand    bit [(`DATA_WIDTH/8)-1 : 0]             tstrb[$];
    rand    bit [(`DATA_WIDTH/8)-1 : 0]             tkeep[$];
    rand    bit                                     sparse_continuous_aligned_en;   //1  -> sparse , 0-> continuous_aligned


    //later add null bytes 

    //Utility and Field macros,
    `uvm_object_utils_begin(axi4_master_seq_item)
    `uvm_field_int (clk_count, UVM_DEFAULT)
    `uvm_field_array_int(data,UVM_ALL_ON)
    `uvm_field_int  (id, UVM_ALL_ON)
    `uvm_field_int  (dest, UVM_ALL_ON)
    `uvm_field_int  (size, UVM_ALL_ON)
    `uvm_field_array_int(tstrb, UVM_ALL_ON)
    `uvm_field_array_int(tkeep, UVM_ALL_ON)
    `uvm_object_utils_end
  
    constraint range            {   clk_count inside{[1:20]};    
                                
                                }  
    
    constraint q_size           {   data.size       == this.size;
                                    tstrb.size      == this.size;
                                    tkeep.size      == this.size;
                                }
                                    
    constraint size_var         {   size inside{[1:10]};        } 

    constraint order            {   solve size                          before  data ;
                                    solve size                          before  tstrb;
                                    solve size                          before  tkeep;
                                    solve sparse_continuous_aligned_en  before  tstrb;
                                    solve sparse_continuous_aligned_en  before  tkeep;
                                }
    
    constraint tkeep_sparse_continuous_aligned_stream       { foreach(tkeep[i]) tkeep[i] == {(`DATA_WIDTH/8){1'b1}}; } 
    constraint tstrb_sparse_continuous_aligned_stream       {   
                                                                if(sparse_continuous_aligned_en == 1'b1) 
                                                                    foreach(tstrb[i]) {tstrb[i] % 2 != 0; tstrb[i] > 1; ^tstrb[i] == 1;}
                                                                else if(sparse_continuous_aligned_en == 1'b0)  
                                                                    foreach(tstrb[i]) {tstrb[i] == {(`DATA_WIDTH/8){1'b1}};   }
                                                            }    

    //Constructor
    function new(string name = "axi4_master_seq_item");
        super.new(name);
    endfunction
    


endclass : axi4_master_seq_item
