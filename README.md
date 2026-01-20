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
