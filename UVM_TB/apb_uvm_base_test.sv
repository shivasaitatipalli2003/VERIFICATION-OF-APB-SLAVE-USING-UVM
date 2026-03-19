apb_uvm_base_test.sv

class base_test extends uvm_test;
  `uvm_component_utils(base_test)
  
  uvm_factory factory;
  uvm_coreservice_t cs = uvm_coreservice_t::get();
  tb_environment env;
  
  function new (string name = "base_test", uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    env = tb_environment::type_id::create("env", this);
  endfunction
  
  function void end_of_elaboration_phase (uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    factory = cs.get_factory();
    factory.print();
  endfunction
  
  task run_phase (uvm_phase phase);
    tb_sequence seq;
    phase.raise_objection(this);
    seq = tb_sequence::type_id::create("seq", this);
    seq.start(env.agnt.sqr);
    #30;
    phase.drop_objection(this);
  endtask
  
endclass

