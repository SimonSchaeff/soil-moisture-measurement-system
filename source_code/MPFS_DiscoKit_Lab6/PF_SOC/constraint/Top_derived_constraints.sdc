# Microchip Technology Inc.
# Date: 2026-Apr-09 14:58:06
# This file was generated based on the following SDC source files:
#   D:/DiscoKit/Libero/MPFS_DiscoKit_Lab1/PF_SOC/component/work/PF_CCC_C1/PF_CCC_C1_0/PF_CCC_C1_PF_CCC_C1_0_PF_CCC.sdc
#   D:/DiscoKit/Libero/MPFS_DiscoKit_Lab1/PF_SOC/component/work/PFSOC_MSS_C0/PFSOC_MSS_C0.sdc
#   C:/Microchip/Libero_SoC_2025.2/Libero_SoC/Designer/data/aPA5M/cores/constraints/EXT/osc_rc160mhz.sdc
# *** Any modifications to this file will be lost if derived constraints is re-run. ***
#

create_clock -name {osc_rc160mhz} -period 5.86854 [ get_pins { PF_OSC_C0_0/PF_OSC_C0_0/I_OSC_160/CLK } ]
create_generated_clock -name {PF_CCC_C0_0/PF_CCC_C1_0/pll_inst_0/OUT0} -multiply_by 25 -divide_by 32 -source [ get_pins { PF_CCC_C0_0/PF_CCC_C1_0/pll_inst_0/REF_CLK_0 } ] -phase 0 [ get_pins { PF_CCC_C0_0/PF_CCC_C1_0/pll_inst_0/OUT0 } ]
create_generated_clock -name {PF_CCC_C0_0/PF_CCC_C1_0/pll_inst_0/OUT1} -divide_by 16 -source [ get_pins { PF_CCC_C0_0/PF_CCC_C1_0/pll_inst_0/REF_CLK_0 } ] -phase 0 [ get_pins { PF_CCC_C0_0/PF_CCC_C1_0/pll_inst_0/OUT1 } ]
