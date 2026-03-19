`include "apb_uvm_pkg.sv"
`include "uvm_macros.svh"
`include "apb_uvm_interface.sv"
`include "apb_slave.sv"

module tb_top;

    import uvm_pkg::*;
    import apb_pkg::*;

    bit pclk, preset_n;

    my_intf vintf(pclk,preset_n);

    apb_slave DUT (.pclk(vintf.pclk), .pselx(vintf.pselx), .preset_n(vintf.preset_n), .penable(vintf.penable), .pwrite(vintf.pwrite), .paddr(vintf.paddr), .pwdata(vintf.pwdata), .pready(vintf.pready), .pslverr(vintf.pslverr), .prdata(vintf.prdata));

    initial begin
        uvm_config_db #(virtual my_intf)::set(null, "uvm_test_top.env.agnt", "vintf", vintf);
    end

    always #5 pclk <= ~pclk;

    initial begin
        pclk <= 0;
        preset_n <= 0;
        #10 preset_n <= 1;
    end

    initial begin
        run_test("base_test");
    end

endmodule
