import pkg1::*;
class axi4_master_sanity_sequence extends uvm_sequence#(axi4_master_seq_item);

    `uvm_object_utils(axi4_master_sanity_sequence)
    axi4_master_seq_item req;
    process job1;
    int count,Print_handle;
  
    function new(string name = "axi4_master_sanity_sequence");
        super.new(name);
    endfunction
    
    function void get_print(int a);
        this.Print_handle = a;
    endfunction

    virtual task body();
        repeat(`COUNT)
        begin
            req  = axi4_master_seq_item::type_id::create("req");
            start_item(req);
            assert(req.randomize());//with{size == 1;});//single transfer per count 
            finish_item(req);
            `uvm_info("transmiter sequence ", $sformatf("Transaction Received: %s",req.sprint()),UVM_LOW)
            Print_handle = $fopen("data_debug_dump.txt","ab"); 
            $fdisplay(Print_handle,"|sequence_count\t",count, "\t|time\t" ,$time,"|");
            count = count + 1;
            $fclose(Print_handle);
        end
    endtask
   
endclass : axi4_master_sanity_sequence



