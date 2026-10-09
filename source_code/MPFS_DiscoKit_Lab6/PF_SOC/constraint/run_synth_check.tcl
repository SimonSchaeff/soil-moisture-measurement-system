set_device -family {PolarFireSoC} -die {MPFS095T} -speed {-1}
set_editor_type {SYNTHESIS}
set_proj_path {C:\Users\M79113\Desktop\PolarFire_SoC\Discovery_kit\Libero\PF_SOC\PF_SOC.prjx}
read_verilog -mode system_verilog {C:\Users\M79113\Desktop\PolarFire_SoC\Discovery_kit\Libero\PF_SOC\component\work\CORERESET_PF_C0\CORERESET_PF_C0_0\core\corereset_pf.v}
read_verilog -mode system_verilog {C:\Users\M79113\Desktop\PolarFire_SoC\Discovery_kit\Libero\PF_SOC\component\work\CORERESET_PF_C0\CORERESET_PF_C0.v}
read_verilog -mode system_verilog -lib COREAPB3_LIB {C:\Users\M79113\Desktop\PolarFire_SoC\Discovery_kit\Libero\PF_SOC\component\Actel\DirectCore\CoreAPB3\4.2.100\rtl\vlog\core\coreapb3_muxptob3.v}
read_verilog -mode system_verilog -lib COREAPB3_LIB {C:\Users\M79113\Desktop\PolarFire_SoC\Discovery_kit\Libero\PF_SOC\component\Actel\DirectCore\CoreAPB3\4.2.100\rtl\vlog\core\coreapb3_iaddr_reg.v}
read_verilog -mode system_verilog -lib COREAPB3_LIB {C:\Users\M79113\Desktop\PolarFire_SoC\Discovery_kit\Libero\PF_SOC\component\Actel\DirectCore\CoreAPB3\4.2.100\rtl\vlog\core\coreapb3.v}
read_verilog -mode system_verilog {C:\Users\M79113\Desktop\PolarFire_SoC\Discovery_kit\Libero\PF_SOC\component\work\CoreAPB3_C0\CoreAPB3_C0.v}
read_verilog -mode system_verilog -lib CORETIMER_LIB {C:\Users\M79113\Desktop\PolarFire_SoC\Discovery_kit\Libero\PF_SOC\component\Actel\DirectCore\CoreTimer\2.0.103\rtl\vlog\core\coretimer.v}
read_verilog -mode system_verilog {C:\Users\M79113\Desktop\PolarFire_SoC\Discovery_kit\Libero\PF_SOC\component\work\CoreTimer_C0\CoreTimer_C0.v}
read_verilog -mode system_verilog {C:\Users\M79113\Desktop\PolarFire_SoC\Discovery_kit\Libero\PF_SOC\component\work\PFSOC_INIT_MONITOR_C0\PFSOC_INIT_MONITOR_C0_0\PFSOC_INIT_MONITOR_C0_PFSOC_INIT_MONITOR_C0_0_PFSOC_INIT_MONITOR.v}
read_verilog -mode system_verilog {C:\Users\M79113\Desktop\PolarFire_SoC\Discovery_kit\Libero\PF_SOC\component\work\PFSOC_INIT_MONITOR_C0\PFSOC_INIT_MONITOR_C0.v}
read_verilog -mode system_verilog {C:\Users\M79113\Desktop\PolarFire_SoC\Discovery_kit\Libero\PF_SOC\component\work\PFSOC_MSS_C0\PFSOC_MSS_C0.v}
read_verilog -mode system_verilog {C:\Users\M79113\Desktop\PolarFire_SoC\Discovery_kit\Libero\PF_SOC\component\work\PF_CCC_C0\PF_CCC_C0_0\PF_CCC_C0_PF_CCC_C0_0_PF_CCC.v}
read_verilog -mode system_verilog {C:\Users\M79113\Desktop\PolarFire_SoC\Discovery_kit\Libero\PF_SOC\component\work\PF_CCC_C0\PF_CCC_C0.v}
read_verilog -mode system_verilog {C:\Users\M79113\Desktop\PolarFire_SoC\Discovery_kit\Libero\PF_SOC\component\work\PF_OSC_C0\PF_OSC_C0_0\PF_OSC_C0_PF_OSC_C0_0_PF_OSC.v}
read_verilog -mode system_verilog {C:\Users\M79113\Desktop\PolarFire_SoC\Discovery_kit\Libero\PF_SOC\component\work\PF_OSC_C0\PF_OSC_C0.v}
read_verilog -mode system_verilog {C:\Users\M79113\Desktop\PolarFire_SoC\Discovery_kit\Libero\PF_SOC\component\work\Top\Top.v}
set_top_level {Top}
map_netlist
read_sdc {C:\Users\M79113\Desktop\PolarFire_SoC\Discovery_kit\Libero\PF_SOC\constraint\Top_derived_constraints.sdc}
set_output_sdc {C:\Users\M79113\Desktop\PolarFire_SoC\Discovery_kit\Libero\PF_SOC\constraint\user1.sdc}
