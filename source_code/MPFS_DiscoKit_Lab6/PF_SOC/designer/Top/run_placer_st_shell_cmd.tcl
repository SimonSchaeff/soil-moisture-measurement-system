read_sdc -scenario "place_and_route" -netlist "optimized" -pin_separator "/" -ignore_errors {C:/Daten/ERES-PROJECT/source_code/MPFS_DiscoKit_Lab6/PF_SOC/designer/Top/place_route.sdc}
set_options -tdpr_scenario "place_and_route" 
save
set_options -analysis_scenario "place_and_route"
report -type combinational_loops -format xml {C:\Daten\ERES-PROJECT\source_code\MPFS_DiscoKit_Lab6\PF_SOC\designer\Top\Top_layout_combinational_loops.xml}
report -type slack {C:\Daten\ERES-PROJECT\source_code\MPFS_DiscoKit_Lab6\PF_SOC\designer\Top\pinslacks.txt}
set coverage [report \
    -type     constraints_coverage \
    -format   xml \
    -slacks   no \
    {C:\Daten\ERES-PROJECT\source_code\MPFS_DiscoKit_Lab6\PF_SOC\designer\Top\Top_place_and_route_constraint_coverage.xml}]
set reportfile {C:\Daten\ERES-PROJECT\source_code\MPFS_DiscoKit_Lab6\PF_SOC\designer\Top\coverage_placeandroute}
set fp [open $reportfile w]
puts $fp $coverage
close $fp