class tb_sequence extends uvm_sequence#(my_trans);

    `uvm_object_utils(tb_sequence)

    function new (string name = "tb_sequence");
        super.new(name);
    endfunction

    task body();
        my_trans tr = my_trans::type_id::create("tr");
        repeat(32) begin
            start_item(tr);
            assert(tr.randomize);
            //`$display("[time = %0t]pwrite = %d | paddr = %h | pwdata = %h", $time,tr.pwrite,tr.paddr,tr.pwdata);
            finish_item(tr);
        end
    endtask

endclass
