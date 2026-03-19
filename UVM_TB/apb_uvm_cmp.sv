class scb_comparator extends uvm_component;

  `uvm_component_utils(scb_comparator)

  uvm_analysis_export#(my_trans) act_ap;
  uvm_analysis_export#(my_trans) exp_ap;
  uvm_tlm_analysis_fifo#(my_trans) act_fifo;
  uvm_tlm_analysis_fifo#(my_trans) exp_fifo;

  function new (string name = "scb_comparator", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    act_ap = new("act_ap", this);
    exp_ap = new("exp_ap", this);
    act_fifo = new("act_fifo", this);
    exp_fifo = new("exp_fifo", this);
  endfunction

  function void connect_phase (uvm_phase phase);
    super.connect_phase(phase);
    act_ap.connect(act_fifo.analysis_export);
    exp_ap.connect(exp_fifo.analysis_export);
  endfunction

  task run_phase (uvm_phase phase);
    my_trans exp_tr, act_tr;
    forever begin
      act_fifo.get(act_tr);
      `uvm_info("scb_comparator run task", "WAITING for actual output", UVM_DEBUG)
      
      exp_fifo.get(exp_tr);
      `uvm_info("scb_comparator run task", "WAITING for expected output", UVM_DEBUG)
      
      //`display("[act]d = %h q = %h qb = %h",act_tr.d,act_tr.q,act_tr.qb);
      //`display("[exp]d = %h q = %h qb = %h",exp_tr.d,exp_tr.q,exp_tr.qb);
      
      if(act_tr.compare(exp_tr)) begin
        `uvm_info("PASS", $sformatf("\nActual    = %s\nExpected  = %s\n", act_tr.convert2string(), exp_tr.convert2string()), UVM_LOW)
        PASS();
      end
      else begin
        `uvm_error("ERROR", $sformatf("\nActual    = %s\nExpected  = %s\n", act_tr.convert2string(), exp_tr.convert2string()))
        ERROR();
      end
    endtask
  end
  
  int VECT_CNT, PASS_CNT, ERROR_CNT;
  
  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    if(VECT_CNT && ERROR_CNT)
      `uvm_info(get_type_name(), $sformatf("\n\n\n***TEST FAILED*** %0d vectors ran, %0d vectors failed***\n\n\n", VECT_CNT, ERROR_CNT), UVM_LOW)
    else
      `uvm_info(get_type_name(), $sformatf("\n\n\n***TEST PASSED*** %0d vectors ran, %0d vectors passed***\n\n\n", VECT_CNT, PASS_CNT), UVM_LOW)
  endfunction
  
  function void PASS();
    VECT_CNT++;
    PASS_CNT++;
  endfunction
  
  function void ERROR();
    VECT_CNT++;
    ERROR_CNT++;
  endfunction

endclass
