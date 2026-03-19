`define DVIF vintf.DRIVER.driver_cb
class tb_driver extends uvm_driver#(my_trans);

    `uvm_component_utils(tb_driver)

    virtual my_intf vintf;

    function new (string name = "tb_driver", uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!uvm_config_db #(virtual my_intf)::get(this, "", vintf))
            `uvm_fatal(`"n\n\nDRIVER`",`"didnot get Interface\n\n`")
    endfunction

    task run_phase (uvm_phase phase);
        my_trans tr;
        forever begin
            seq_item_port.get_next_item(tr);
            @(vintf.driver_cb);
            `DVIF.pselx <= 0;
            `DVIF.penable <= 0;
            `DVIF.pwrite <= tr.pwrite;
            `DVIF.paddr <= tr.paddr;
            `DVIF.pwdata <= tr.pwdata;
            @(vintf.driver_cb);
            `DVIF.penable <= 1;
            @(vintf.driver_cb);
            `DVIF.penable <= 0;
            $display($time,`"DRV`",`"pselx = %h | penable = %h | pwrite = %h | paddr = %h | pwdata = %h \n`",vintf.pselx,vintf.penable,tr.pwrite,tr.paddr,tr.pwdata);
            seq_item_port.item_done();
        end
    endtask
endclass
