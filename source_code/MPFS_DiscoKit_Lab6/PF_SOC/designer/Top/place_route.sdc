# Microchip Technology Inc.
# Date: 2026-Jun-23 17:30:59
# This file was generated based on the following SDC source files:
#   C:/Daten/ERES-PROJECT/source_code/MPFS_DiscoKit_Lab6/PF_SOC/constraint/Top_derived_constraints.sdc
#   C:/Daten/ERES-PROJECT/source_code/MPFS_DiscoKit_Lab6/PF_SOC/constraint/user1.sdc
#

create_clock -name {osc_rc160mhz} -period 5.86854 [ get_pins { PF_OSC_C0_0/PF_OSC_C0_0/I_OSC_160/CLK } ]
create_clock -name {REFCLK} -period 8 -waveform {0 4 } [ get_ports { REFCLK } ]
create_generated_clock -name {PF_CCC_C0_0/PF_CCC_C1_0/pll_inst_0/OUT0} -multiply_by 25 -divide_by 32 -source [ get_pins { PF_CCC_C0_0/PF_CCC_C1_0/pll_inst_0/REF_CLK_0 } ] -phase 0 [ get_pins { PF_CCC_C0_0/PF_CCC_C1_0/pll_inst_0/OUT0 } ]
create_generated_clock -name {PF_CCC_C0_0/PF_CCC_C1_0/pll_inst_0/OUT1} -divide_by 16 -source [ get_pins { PF_CCC_C0_0/PF_CCC_C1_0/pll_inst_0/REF_CLK_0 } ] -phase 0 [ get_pins { PF_CCC_C0_0/PF_CCC_C1_0/pll_inst_0/OUT1 } ]
set_clock_uncertainty 0.135 [ get_clocks { PF_CCC_C0_0/PF_CCC_C1_0/pll_inst_0/OUT0 } ]
set_clock_uncertainty -hold 0 -rise_from [ get_clocks { PF_CCC_C0_0/PF_CCC_C1_0/pll_inst_0/OUT0 } ] -rise_to [ get_clocks { PF_CCC_C0_0/PF_CCC_C1_0/pll_inst_0/OUT0 } ]
set_clock_uncertainty -hold 0 -fall_from [ get_clocks { PF_CCC_C0_0/PF_CCC_C1_0/pll_inst_0/OUT0 } ] -fall_to [ get_clocks { PF_CCC_C0_0/PF_CCC_C1_0/pll_inst_0/OUT0 } ]
set_clock_uncertainty 2.34742 [ get_clocks { PF_CCC_C0_0/PF_CCC_C1_0/pll_inst_0/OUT1 } ]
set_clock_uncertainty -hold 0 -rise_from [ get_clocks { PF_CCC_C0_0/PF_CCC_C1_0/pll_inst_0/OUT1 } ] -rise_to [ get_clocks { PF_CCC_C0_0/PF_CCC_C1_0/pll_inst_0/OUT1 } ]
set_clock_uncertainty -hold 0 -fall_from [ get_clocks { PF_CCC_C0_0/PF_CCC_C1_0/pll_inst_0/OUT1 } ] -fall_to [ get_clocks { PF_CCC_C0_0/PF_CCC_C1_0/pll_inst_0/OUT1 } ]
set_clock_uncertainty 0.00374875 [ get_clocks { REFCLK } ]
set_clock_uncertainty -hold 0 -rise_from [ get_clocks { REFCLK } ] -rise_to [ get_clocks { REFCLK } ]
set_clock_uncertainty -hold 0 -fall_from [ get_clocks { REFCLK } ] -fall_to [ get_clocks { REFCLK } ]
set_clock_uncertainty 0.6 [ get_clocks { osc_rc160mhz } ]
set_clock_uncertainty -hold 0 -rise_from [ get_clocks { osc_rc160mhz } ] -rise_to [ get_clocks { osc_rc160mhz } ]
set_clock_uncertainty -hold 0 -fall_from [ get_clocks { osc_rc160mhz } ] -fall_to [ get_clocks { osc_rc160mhz } ]
