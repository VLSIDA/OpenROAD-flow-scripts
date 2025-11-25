utl::set_metrics_stage "cts__clk_1"
source $::env(SCRIPTS_DIR)/load.tcl
erase_non_stage_variables cts
load_design 3_place.odb 3_place.sdc

puts "=========================================================================="
puts "Two phase mode: Building clock tree for clk_1"
puts "--------------------------------------------------------------------------"

repair_clock_inverters

set cts_args [list \
  -sink_clustering_enable \
  -repair_clock_nets \
  -balance_levels \
  -clk_nets clk_1
  ]

append_env_var cts_args CTS_BUF_DISTANCE -distance_between_buffers 1
append_env_var cts_args CTS_CLUSTER_SIZE -sink_clustering_size 1
append_env_var cts_args CTS_CLUSTER_DIAMETER -sink_clustering_max_diameter 1
append_env_var cts_args CTS_BUF_LIST -buf_list 1
append_env_var cts_args CTS_LIB_NAME -library 1

if { [env_var_exists_and_non_empty CTS_ARGS] } {
  set cts_args $::env(CTS_ARGS)
}

set_dont_use $::env(DONT_USE_CELLS)

log_cmd clock_tree_synthesis {*}$cts_args

detailed_placement

estimate_parasitics -placement

# report_two_phase_metrics 4 "cts clk_1 complete" "clk_1"

puts "report_clock_skew test"
puts "===================="
report_clock_skew

puts "\nreport_clock_skew -clock clk_1 test"
puts "===================="
report_clock_skew -clock clk_1

puts "\nreport_clock_skew -setup -clock clk_1 test"
puts "===================="
report_clock_skew -setup -clock clk_1

puts "\nreport_clock_skew -hold -clock clk_1"
puts "===================="
report_clock_skew -hold -clock clk_1

write_db $::env(RESULTS_DIR)/4_1_cts.odb
write_sdc -no_timestamp $::env(RESULTS_DIR)/4_1_cts.sdc
