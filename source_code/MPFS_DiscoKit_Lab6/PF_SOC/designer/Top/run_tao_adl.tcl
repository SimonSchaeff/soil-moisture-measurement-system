set_device -family {PolarFireSoC} -die {MPFS095T} -speed {-1}
read_adl {C:\Daten\ERES-PROJECT\source_code\MPFS_DiscoKit_Lab6\PF_SOC\designer\Top\Top.adl}
read_afl {C:\Daten\ERES-PROJECT\source_code\MPFS_DiscoKit_Lab6\PF_SOC\designer\Top\Top.afl}
map_netlist
read_sdc {C:\Daten\ERES-PROJECT\source_code\MPFS_DiscoKit_Lab6\PF_SOC\constraint\Top_derived_constraints.sdc}
read_sdc {C:\Daten\ERES-PROJECT\source_code\MPFS_DiscoKit_Lab6\PF_SOC\constraint\user1.sdc}
check_constraints {C:\Daten\ERES-PROJECT\source_code\MPFS_DiscoKit_Lab6\PF_SOC\constraint\placer_sdc_errors.log}
estimate_jitter -report {C:\Daten\ERES-PROJECT\source_code\MPFS_DiscoKit_Lab6\PF_SOC\designer\Top\place_and_route_jitter_report.txt}
write_sdc -mode layout {C:\Daten\ERES-PROJECT\source_code\MPFS_DiscoKit_Lab6\PF_SOC\designer\Top\place_route.sdc}
