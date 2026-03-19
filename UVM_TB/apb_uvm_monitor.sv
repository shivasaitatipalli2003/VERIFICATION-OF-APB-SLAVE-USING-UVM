`define MVIF vintf.MONITOR.monitor_cb
class tb_monitor extends uvm_monitor;

    `uvm_component_utils(tb_monitor)

    uvm_analysis_port#(my_trans)mon_ap;

    my_trans req;

    virtual my_intf vintf;

    function new (string name = "tb_monitor", uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        mon_ap = new("mon_ap",this);

        if(!uvm_config_db#(virtual my_intf)::get(this,"", "vintf",vintf))
        `uvm_fatal(get_type_name(),"\n\n\nVINTF is not set\n\n")

    endfunction

    task run_phase (uvm_phase phase);
        req = my_trans::type_id::create("req");
        forever begin
            wait(vintf.preset_n);
            @(vintf.monitor_cb);
            req.rst = `MVIF.preset_n;
            req.pselx = `MVIF.pselx;
            req.pwrite = `MVIF.pwrite;
            req.paddr = `MVIF.paddr;
            req.pwdata = `MVIF.pwdata;
            @(vintf.monitor_cb);
            req.penable = `MVIF.penable;
            @(vintf.monitor_cb);
            req.pready = `MVIF.pready;
            req.prdata = `MVIF.prdata;
            req.pslverr = `MVIF.pslverr;

            $display($time,"[mon] pselx = %h | penable = %h | pwrite = %h | paddr = %h | pwdata = %h | prdata = %h",req.pselx,req.penable,req.pwrite,req.paddr,req.pwdata,req.prdata);

            mon_ap.write(req);
        end
    endtask
endclass
