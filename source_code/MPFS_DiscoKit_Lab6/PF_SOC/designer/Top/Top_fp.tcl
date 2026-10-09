new_project \
         -name {Top} \
         -location {C:\Daten\Praktikum_Entwicklung_resilenter_Elektroniksysteme\2026-04-17_TestExam_1\MPFS_DiscoKit_Lab6\PF_SOC\designer\Top\Top_fp} \
         -mode {chain} \
         -connect_programmers {FALSE}
add_actel_device \
         -device {MPFS095T} \
         -name {MPFS095T}
enable_device \
         -name {MPFS095T} \
         -enable {TRUE}
save_project
close_project
