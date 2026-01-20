module apb_slave (input pclk, pselx, preset_n, penable, pwrite,
                  input [2:0]paddr,
                  input [7:0]pwdata,
                  output reg pready, pslverr,
                  output reg [7:0] prdata);

reg [7:0] mem [7:0];

typedef enum bit [1:0] {IDLE,SETUP,ACCESS} state;
state current_state, next_state;

always @(posedge pclk or negedge preset_n) begin
  if(!preset_n) begin
    pready <= 1'b0;
    pslverr <= 1'b0;
    prdata <=0;
    current_state <= IDLE;
    next_state <= current_state;
    foreach (mem[i])
      mem[i] = 0;
  end
  else begin
    current_state <= next_state;
  end
end

always @(*) begin

  next_state = current_state;

  case(current_state)

    IDLE:begin
      pready = 0;
      if(pselx) begin
        next_state = SETUP;
      end
      else begin
        next_state = IDLE;
      end
    end

    SETUP:begin
      if(pselx) begin
        pready = 0;
        next_state = ACCESS;
      end
      else begin
        //next_state = IDLE;
      end
    end

    ACCESS:begin
      pready =1;
      if(pselx) begin
        if(penable) begin
          if(pwrite) begin
            mem[paddr] = pwdata;
            prdata = 0;
            //$display("DUT - write");
            //$display($time,mem);
          end
          else begin
            prdata = mem[paddr];
            //$display("DUT - read");
            //$display($time,mem);
          end
          next_state = SETUP;
        end
        else begin
          next_state = IDLE;
          pready = 0;
          prdata = 0;
        end
      end
      //pready =0;
    end

  endcase
end

endmodule

