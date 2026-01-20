# VERIFICATION-OF-APB-SLAVE-USING-UVM
UVM-based verification of APB Slave using Synopsys VCS &amp; Verdi. Includes driver, monitor, scoreboard with TLM ports, constrained-random tests, functional coverage &amp; assertions. Validated protocol compliance, back-to-back transfers, idle handling; debugged response issues with reusable factory-configured testbench.

## Tools & Methodology
- **Language:** SystemVerilog  
- **Methodology:** Universal Verification Methodology (UVM)  
- **Simulator:** Synopsys VCS (SIMV)  
- **Debug:** Synopsys Verdi

## Design Description
The RTL (`apb_slave.sv`) implements a 3-state APB slave FSM:
- **IDLE → SETUP → ACCESS**
- Supports read/write to internal 8x8 memory  
- Generates `pready`, `prdata`, and handles protocol sequencing

## UVM Testbench Architecture

### Components
- **tb_driver:** Drives APB signals through clocking block  
- **tb_monitor:** Captures DUT activity via virtual interface  
- **tb_agent:** Connects driver, sequencer, monitor using TLM  
- **tb_scoreboard:**  
  - Predictor (`scb_predictor`) models expected memory behavior  
  - Comparator (`scb_comparator`) matches actual vs expected  
- **tb_sequence:** Generates constrained-random transactions  
- **base_test:** Builds environment and starts sequences

### Features
- Virtual interface based communication  
- TLM analysis ports & FIFOs  
- Factory-based component creation  
- Constrained random stimulus  
- Functional comparison using `do_compare`  
- Reusable UVM architecture

## Directory Structure
├── RTL/  
│   └── apb_slave.sv  
├── UVM TB/  
│   ├── apb_uvm_interface.sv  
│   ├── apb_uvm_driver.sv  
│   ├── apb_uvm_monitor.sv  
│   ├── apb_uvm_agent.sv  
│   ├── apb_uvm_prd.sv  
│   ├── apb_uvm_cmp.sv  
│   ├── apb_uvm_scoreboard.sv  
│   ├── apb_uvm_sequence.sv  
│   ├── apb_uvm_sequencer.sv  
│   ├── apb_uvm_base_test.sv  
│   ├── apb_uvm_pkg.sv  
│   └── apb_uvm_tb_top.sv  
└── TB/  
    └── apb_tb.sv (basic SV TB)

## Test Scenarios Verified
- Randomized write transactions  
- Randomized read transactions  
- Back-to-back transfers  
- Reset behavior  
- Memory data integrity  
- Protocol state transitions

## Results
- Scoreboard comparison between DUT and predictor  
- PASS/FAIL reporting in comparator  
- Clean simulation on VCS & Verdi  
- Protocol-compliant APB transactions

## Learning Outcomes
- UVM component synchronization via TLM  
- Virtual interface usage  
- Predictor–comparator modeling  
- Constrained random verification  
- APB protocol understanding

## Author
**Shivasai – VLSI Design Verification Engineer**

