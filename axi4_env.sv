class axi4_env extends uvm_env;

    `uvm_component_utils(axi4_env) // register with factory
    axi4_master_agent master_agent;// create handle for master and slave agent
    axi4_slave_agent  slave_agent;

    function new(string name="axi4_env", uvm_component parent = null);//constructor
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);//create master and slave agent 
        super.build_phase(phase);
        master_agent = axi4_master_agent::type_id::create("master_agent", this);
        slave_agent  = axi4_slave_agent::type_id::create("slave_agent", this);
    endfunction



endclass : axi4_env
