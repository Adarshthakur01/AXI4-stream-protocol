import pkg1::*;
class axi4_slave_sanity_sequence extends uvm_sequence#(axi4_slave_seq_item);

    `uvm_object_utils(axi4_slave_sanity_sequence)
    axi4_slave_seq_item req;
  
    function new(string name = "axi4_slave_sanity_sequence");
        super.new(name);
    endfunction
   
    virtual task body();
        forever
        begin
            req = axi4_slave_seq_item::type_id::create("req");
            start_item(req);
            assert(req.randomize());//with{ready_before_valid == 0;});
            finish_item(req);
            `uvm_info("receiver sequence ", $sformatf("Transaction Received: %s",req.sprint()),UVM_LOW)
             
        end
    endtask
   
endclass : axi4_slave_sanity_sequence


