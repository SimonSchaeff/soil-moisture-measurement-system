set_device -family {PolarFireSoC} -die {MPFS095T} -speed {-1} -range {EXT}
read_verilog -mode system_verilog {D:\DiscoKit\Libero\MPFS_DiscoKit_Lab1\PF_SOC\component\work\CORERESET_PF_C0\CORERESET_PF_C0_0\core\corereset_pf.v}
read_verilog -mode system_verilog {D:\DiscoKit\Libero\MPFS_DiscoKit_Lab1\PF_SOC\component\work\CORERESET_PF_C0\CORERESET_PF_C0.v}
read_vhdl -mode vhdl_2008 -lib COREAPB3_LIB {D:\DiscoKit\Libero\MPFS_DiscoKit_Lab1\PF_SOC\component\Actel\DirectCore\CoreAPB3\4.2.100\rtl\vhdl\core\coreapb3_muxptob3.vhd}
read_vhdl -mode vhdl_2008 -lib COREAPB3_LIB {D:\DiscoKit\Libero\MPFS_DiscoKit_Lab1\PF_SOC\component\Actel\DirectCore\CoreAPB3\4.2.100\rtl\vhdl\core\coreapb3_iaddr_reg.vhd}
read_vhdl -mode vhdl_2008 -lib COREAPB3_LIB {D:\DiscoKit\Libero\MPFS_DiscoKit_Lab1\PF_SOC\component\Actel\DirectCore\CoreAPB3\4.2.100\rtl\vhdl\core\coreapb3.vhd}
read_vhdl -mode vhdl_2008 -lib COREAPB3_LIB {D:\DiscoKit\Libero\MPFS_DiscoKit_Lab1\PF_SOC\component\Actel\DirectCore\CoreAPB3\4.2.100\rtl\vhdl\core\components.vhd}
read_vhdl -mode vhdl_2008 {D:\DiscoKit\Libero\MPFS_DiscoKit_Lab1\PF_SOC\component\work\CoreAPB3_C0\CoreAPB3_C0.vhd}
read_verilog -mode system_verilog -lib CORETIMER_LIB {D:\DiscoKit\Libero\MPFS_DiscoKit_Lab1\PF_SOC\component\Actel\DirectCore\CoreTimer\2.0.103\rtl\vlog\core\coretimer.v}
read_verilog -mode system_verilog {D:\DiscoKit\Libero\MPFS_DiscoKit_Lab1\PF_SOC\component\work\CoreTimer_C0\CoreTimer_C0.v}
read_verilog -mode system_verilog {D:\DiscoKit\Libero\MPFS_DiscoKit_Lab1\PF_SOC\component\work\PFSOC_INIT_MONITOR_C0\PFSOC_INIT_MONITOR_C0_0\PFSOC_INIT_MONITOR_C0_PFSOC_INIT_MONITOR_C0_0_PFSOC_INIT_MONITOR.v}
read_verilog -mode system_verilog {D:\DiscoKit\Libero\MPFS_DiscoKit_Lab1\PF_SOC\component\work\PFSOC_INIT_MONITOR_C0\PFSOC_INIT_MONITOR_C0.v}
read_verilog -mode system_verilog {D:\DiscoKit\Libero\MPFS_DiscoKit_Lab1\PF_SOC\component\work\PFSOC_MSS_C0\PFSOC_MSS_C0.v}
read_verilog -mode system_verilog {D:\DiscoKit\Libero\MPFS_DiscoKit_Lab1\PF_SOC\component\work\PF_CCC_C1\PF_CCC_C1_0\PF_CCC_C1_PF_CCC_C1_0_PF_CCC.v}
read_verilog -mode system_verilog {D:\DiscoKit\Libero\MPFS_DiscoKit_Lab1\PF_SOC\component\work\PF_CCC_C1\PF_CCC_C1.v}
read_verilog -mode system_verilog {D:\DiscoKit\Libero\MPFS_DiscoKit_Lab1\PF_SOC\component\work\PF_OSC_C0\PF_OSC_C0_0\PF_OSC_C0_PF_OSC_C0_0_PF_OSC.v}
read_verilog -mode system_verilog {D:\DiscoKit\Libero\MPFS_DiscoKit_Lab1\PF_SOC\component\work\PF_OSC_C0\PF_OSC_C0.v}
read_vhdl -mode vhdl_2008 -lib COREPWM_LIB {D:\DiscoKit\Libero\MPFS_DiscoKit_Lab1\PF_SOC\component\Actel\DirectCore\corepwm\4.5.100\rtl\vhdl\core\tach_if.vhd}
read_vhdl -mode vhdl_2008 -lib COREPWM_LIB {D:\DiscoKit\Libero\MPFS_DiscoKit_Lab1\PF_SOC\component\Actel\DirectCore\corepwm\4.5.100\rtl\vhdl\core\pwm_gen.vhd}
read_vhdl -mode vhdl_2008 -lib COREPWM_LIB {D:\DiscoKit\Libero\MPFS_DiscoKit_Lab1\PF_SOC\component\Actel\DirectCore\corepwm\4.5.100\rtl\vhdl\core\reg_if.vhd}
read_vhdl -mode vhdl_2008 -lib COREPWM_LIB {D:\DiscoKit\Libero\MPFS_DiscoKit_Lab1\PF_SOC\component\Actel\DirectCore\corepwm\4.5.100\rtl\vhdl\core\timebase.vhd}
read_vhdl -mode vhdl_2008 -lib COREPWM_LIB {D:\DiscoKit\Libero\MPFS_DiscoKit_Lab1\PF_SOC\component\Actel\DirectCore\corepwm\4.5.100\rtl\vhdl\core\t_corepwm_pkg.vhd}
read_vhdl -mode vhdl_2008 -lib COREPWM_LIB {D:\DiscoKit\Libero\MPFS_DiscoKit_Lab1\PF_SOC\component\Actel\DirectCore\corepwm\4.5.100\rtl\vhdl\core\corepwm.vhd}
read_vhdl -mode vhdl_2008 -lib COREPWM_LIB {D:\DiscoKit\Libero\MPFS_DiscoKit_Lab1\PF_SOC\component\Actel\DirectCore\corepwm\4.5.100\rtl\vhdl\core\components.vhd}
read_vhdl -mode vhdl_2008 {D:\DiscoKit\Libero\MPFS_DiscoKit_Lab1\PF_SOC\component\work\corepwm_C0\corepwm_C0.vhd}
read_vhdl -mode vhdl_2008 {D:\DiscoKit\Libero\MPFS_DiscoKit_Lab1\PF_SOC\component\work\Top\Top.vhd}
set_top_level {Top}
read_sdc -component {D:\DiscoKit\Libero\MPFS_DiscoKit_Lab1\PF_SOC\component\work\PFSOC_MSS_C0\PFSOC_MSS_C0.sdc}
read_sdc -component {D:\DiscoKit\Libero\MPFS_DiscoKit_Lab1\PF_SOC\component\work\PF_CCC_C1\PF_CCC_C1_0\PF_CCC_C1_PF_CCC_C1_0_PF_CCC.sdc}
derive_constraints
write_sdc {D:\DiscoKit\Libero\MPFS_DiscoKit_Lab1\PF_SOC\constraint\Top_derived_constraints.sdc}
write_ndc {D:\DiscoKit\Libero\MPFS_DiscoKit_Lab1\PF_SOC\constraint\Top_derived_constraints.ndc}
write_pdc {D:\DiscoKit\Libero\MPFS_DiscoKit_Lab1\PF_SOC\constraint\fp\Top_derived_constraints.pdc}
