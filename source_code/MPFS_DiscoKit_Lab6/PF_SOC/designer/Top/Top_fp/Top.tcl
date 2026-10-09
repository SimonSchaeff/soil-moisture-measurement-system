open_project -project {C:\Daten\ERES-PROJECT\source_code\MPFS_DiscoKit_Lab6\PF_SOC\designer\Top\Top_fp\Top.pro}
enable_device -name {MPFS095T} -enable 1
set_programming_file -name {MPFS095T} -file {C:\Daten\ERES-PROJECT\source_code\MPFS_DiscoKit_Lab6\PF_SOC\designer\Top\Top.ppd}
set_programming_action -action {PROGRAM} -name {MPFS095T} 
run_selected_actions
save_project
close_project
