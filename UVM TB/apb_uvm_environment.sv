class tb_environment extends uvm_env;

    `uvm_component_utils(tb_environment)

    tb_agent agnt;
    tb_scoreboard scb;

    function new (string name = "tb_environment", uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        agnt = tb_agent::type_id::create("agnt", this);
        scb = tb_scoreboard::type_id::create("scb", this);
    endfunction

    function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
        agnt.agnt_ap.connect(scb.scb_ap);
    endfunction

endclass
