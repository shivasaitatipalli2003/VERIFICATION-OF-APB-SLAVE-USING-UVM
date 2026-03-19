interface my_intf (input logic pclk,preset_n);

    logic pselx;
    logic penable;
    logic pwrite;
    logic [2:0] paddr;
    logic [7:0] pwdata;
    logic pready;
    logic pslverr;
    logic [7:0] prdata;

    clocking driver_cb @(posedge pclk);
        default input #1 output #3;
        output pselx;
        output penable;
        output pwrite;
        output paddr;
        output pwdata;
        input pready;
        input pslverr;
        input prdata;
    endclocking

    clocking monitor_cb @(posedge pclk);
        default input #1 output #1;
        input pselx;
        input penable;
        input pwrite;
        input paddr;
        input pwdata;
        input pready;
        input pslverr;
        input prdata;
        input preset_n;
    endclocking

    modport DRIVER (clocking driver_cb,input pclk,preset_n);
    modport MONITOR (clocking monitor_cb,input pclk,preset_n);

endinterface
