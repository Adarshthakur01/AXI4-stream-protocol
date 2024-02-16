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
    
    constraint tkeep_sparse_continuous_aligned_stream       { foreach(tkeep[i]) tkeep[i] == {(`DATA_WIDTH/8){1'b1}}; } //later change this for null bytes
    
  //constraint tsrb_sparse      { tstrb.sum()with(int'(1 ? $countones(item) : 0)) > tstrb.sum()with(int '(1 ? ((`DATA_WIDTH/8)) - $countones(item) : 0)) ;} not working in vivado 2020.02 alternative is done

  //constraint tstrb_sparse     {  foreach(tstrb[i]) $countones(tstrb[i]) > (`DATA_WIDTH/8) - $countones(tstrb[i]);   } not working in vivado 2020.02 alternative is done

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
