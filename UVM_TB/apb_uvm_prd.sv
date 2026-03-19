class scb_predictor extends uvm_subscriber#(my_trans);

    `uvm_component_utils(scb_predictor)

    uvm_analysis_port#(my_trans) results_ap;

    bit [7:0] mem [7:0];

    function new (string name = "scb_predictor", uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        results_ap = new("results_ap", this);
    endfunction

    function void write(my_trans t);
        my_trans exp_tr;
        exp_tr = scb_calc_exp(t);
        //$display("[prd] paddr = %h | pwdata = %h | prdata = %h",exp_tr.paddr,exp_tr.pwdata,exp_tr.prdata);
        results_ap.write(exp_tr);
    endfunction

    extern function my_trans scb_calc_exp(my_trans t);

endclass

function my_trans scb_predictor::scb_calc_exp(my_trans t);
    my_trans tr = my_trans::type_id::create("tr");
    tr.copy(t);

    if(!tr.rst) begin
        tr.prdata = 0;
        tr.pslverr = 0;
        foreach (mem[i]) mem[i] = 0;
        //$display("\nreset\n");
    end
    else begin
        if(tr.pselx) begin
            if(tr.penable) begin
                if(tr.pwrite) begin
                    mem[tr.paddr] = tr.pwdata;
                    tr.prdata = tr.prdata;
                    //$display(mem);
                end
                else begin
                    tr.prdata = mem[tr.paddr];
                    //$display("read");
                end
            end
        end
    end
    return tr;
endfunction
