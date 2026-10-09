# Written by Synplify Pro version map202503actsp1, Build 108R. Synopsys Run ID: sid1782226721 
# Top Level Design Parameters 

# Clocks 
create_clock -period 8.000 -waveform {0.000 4.000} -name {REFCLK} [get_ports {REFCLK}] 
create_clock -period 5.869 -waveform {0.000 2.934} -name {osc_rc160mhz} [get_pins {PF_OSC_C0_0/PF_OSC_C0_0/I_OSC_160/CLK}] 

# Virtual Clocks 

# Generated Clocks 
create_generated_clock -name {PF_CCC_C0_0/PF_CCC_C1_0/pll_inst_0/OUT0} -multiply_by {25} -divide_by {32} -source [get_pins {PF_CCC_C0_0/PF_CCC_C1_0/pll_inst_0/REF_CLK_0}]  [get_pins {PF_CCC_C0_0/PF_CCC_C1_0/pll_inst_0/OUT0}] 
create_generated_clock -name {PF_CCC_C0_0/PF_CCC_C1_0/pll_inst_0/OUT1} -divide_by {16} -source [get_pins {PF_CCC_C0_0/PF_CCC_C1_0/pll_inst_0/REF_CLK_0}]  [get_pins {PF_CCC_C0_0/PF_CCC_C1_0/pll_inst_0/OUT1}] 

# Paths Between Clocks 

# Multicycle Constraints 

# Point-to-point Delay Constraints 

# False Path Constraints 

# Output Load Constraints 

# Driving Cell Constraints 

# Input Delay Constraints 

# Output Delay Constraints 

# Wire Loads 

# Other Constraints 

# syn_hier Attributes 

# set_case Attributes 

# Clock Delay Constraints 

# syn_mode Attributes 

# Cells 

# Port DRC Rules 

# Input Transition Constraints 

# Unused constraints (intentionally commented out) 


# Non-forward-annotatable constraints (intentionally commented out) 

# Block Path constraints 

