set_component PF_CCC_C1_PF_CCC_C1_0_PF_CCC
# Microchip Technology Inc.
# Date: 2026-Apr-09 14:52:20
#

# Base clock for PLL #0
create_clock -period 6.25 [ get_pins { pll_inst_0/REF_CLK_0 } ]
create_generated_clock -multiply_by 25 -divide_by 32 -source [ get_pins { pll_inst_0/REF_CLK_0 } ] -phase 0 [ get_pins { pll_inst_0/OUT0 } ]
create_generated_clock -divide_by 16 -source [ get_pins { pll_inst_0/REF_CLK_0 } ] -phase 0 [ get_pins { pll_inst_0/OUT1 } ]
