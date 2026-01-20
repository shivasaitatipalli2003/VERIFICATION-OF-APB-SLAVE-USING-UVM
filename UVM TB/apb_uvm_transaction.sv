class my_trans extends uvm_sequence_item;

    `uvm_object_utils(my_trans)

    rand bit pselx;
    rand bit penable;
    rand bit pwrite;
    rand bit [2:0] paddr;
    randc bit [7:0] pwdata;
    bit pready;
    bit pslverr;
    bit [7:0] prdata;
    bit rst;

    static int count;
    constraint c_wr {
        if(count < 8)
            pwrite == 1;
        else if (count >= 8 && count < 16)
            pwrite == 0;
        else if (count >= 16 && count < 24)
            pwrite == 1;
        else if (count >= 24 && count < 32)
            pwrite == 0;
        else pwrite dist {1:= 50 , 0:= 50};
    }
    constraint c_addr {paddr == count % 8;}

    //constraint c2 {pwrite dist {1:=40,0:=60};}
    //constraint c1 {paddr inside {0,1,2,3,4,5,6,7};}
    constraint c3 {
        if (pwrite == 1) {
            pwdata inside {[1:99]};
        }else {
            pwdata == 8'h00;
        }
    }

    function void post_randomize();
        count++;
        //$display($time,"\n[post] wr = %h | addr = %h | data_in = %h | data_in = %h | count = %0d", wr,addr,data_in,data_out,count);
    endfunction

    function new (string name = "my_my_trans");
        super.new(name);
    endfunction

    function void do_copy(uvm_object rhs);
        my_trans tr;
        $cast(tr, rhs);
        super.do_copy(rhs);
        pselx = tr.pselx;
        penable = tr.penable;
        pwrite = tr.pwrite;
        paddr = tr.paddr;
        pwdata = tr.pwdata;
        pready = tr.pready;
        pslverr = tr.pslverr;
        prdata = tr.prdata;
        rst = tr.rst;
    endfunction

    function string convert2string();
        string s;
        s = $sformatf("[time = %0t] rst = %0d | pselx = %h | penable = %h | pwrite = %h | paddr = %h | pwdata = %h | prdata = %h", $time, rst,pselx,penable,pwrite,paddr,pwdata,prdata);
        return s;
    endfunction

    function bit do_compare(uvm_object rhs, uvm_comparer comparer);
        bit res;
        my_trans pkt;
        $cast(pkt,rhs);
        super.do_compare(pkt,comparer);
        res = super.do_compare(pkt,comparer) && (pkt.pselx == pselx) && (penable == pkt.penable) && (pwrite == pkt.pwrite) && (paddr == pkt.paddr) && (pwdata == pkt.pwdata) && (pready == pkt.pready) && (pslverr == pkt.pslverr) && (prdata == pkt.prdata) && (rst == pkt.rst);
        return res;
    endfunction

endclass
