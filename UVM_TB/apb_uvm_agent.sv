class tb_agent extends uvm_agent;

  `uvm_component_utils(tb_agent)
  `uvm_analysis_export#(my_trans) agnt_ap;

  tb_sequencer sqr;
  tb_driver drv;
  tb_monitor mon;

  virtual my_intf vintf;

  function new (string name = "tb_agent", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    agnt_ap = new("agnt_ap", this);
    sqr = tb_sequencer::type_id::create("sqr", this);
    drv = tb_driver::type_id::create("drv", this);
    mon = tb_monitor::type_id::create("mon", this);

    if(!uvm_config_db #(virtual my_intf)::get(this, "", "vintf", vintf))
      `uvm_error("n\n\nAGENT", "vintf fail\n\n\n")

    uvm_config_db #(virtual my_intf)::set(this, "*", "vintf", vintf);
  endfunction

  function void connect_phase (uvm_phase phase);
    super.connect_phase (phase);
    drv.seq_item_port.connect(sqr.seq_item_export);
    mon.mon_ap.connect(agnt_ap);
  endfunction

endclass
