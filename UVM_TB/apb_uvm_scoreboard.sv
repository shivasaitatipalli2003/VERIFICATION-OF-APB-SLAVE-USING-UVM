class tb_scoreboard extends uvm_scoreboard;

    `uvm_component_utils(tb_scoreboard)

    uvm_analysis_export#(my_trans) scb_ap;

    scb_predictor prd;
    scb_comparator cmp;

    function new(string name,uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        //$display("\n\n\nbuild\n\n\n");
        scb_ap = new("scb_ap", this);
        prd = scb_predictor::type_id::create("prd", this);
        cmp = scb_comparator::type_id::create("cmp", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        scb_ap.connect(prd.analysis_export);
        scb_ap.connect(cmp.act_ap);
        prd.results_ap.connect(cmp.exp_ap);
    endfunction

endclass
