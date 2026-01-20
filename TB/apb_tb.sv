module apb_tb;
  logic pclk, pselx, preset_n, penable, pwrite, paddr, pwdata, pready, pslverr, prdata;
  logic [7:0] paddr, pwdata;
  
  always #5 pclk = ~pclk;
  
  apb_slave TB (.pclk(pclk), .pselx(pselx), .preset_n(preset_n), .penable(penable), .pwrite(pwrite), .paddr(paddr), .pwdata(pwdata), .pready(pready), .pslverr(pslverr), .prdata(prdata));
  
  initial begin
    $monitor("time=%t pclk=%b pselx=%b preset_n=%b penable=%b pwrite=%b paddr=%h pwdata=%h pready=%b pslverr=%b prdata=%h", $time, pclk, pselx, preset_n, penable, pwrite, paddr, pwdata, pready, pslverr, prdata);
    
    //initializing
    pclk = 0;
    preset_n = 0;
    pselx = 0;
    penable = 0;
    
    //reset
    #10 preset_n = 1;
    
    //write
    @(posedge pclk);
    repeat(8) begin
      #10 pselx = 1; pwrite = 1; paddr = $urandom_range(0,7); pwdata = $random;
      #10 penable = 1;
      #10 penable = 0;
      
      pselx = 0;
      paddr = 0;
      pwdata = 0;
    end
    
    //read
    repeat(8) begin
      #10 pselx = 1; pwrite = 0; paddr = $urandom_range(0,7);
      #10 penable = 1;
      
      @(posedge pclk);
      @(posedge pclk);
      
      penable = 0;
      pselx = 0;
      pwdata = 0;
      paddr = 0;
    end
    
    #40;
    $finish;
  end
  
endmodule
