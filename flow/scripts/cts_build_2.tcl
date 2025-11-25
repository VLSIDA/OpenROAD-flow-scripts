utl::set_metrics_stage "cts__clk_2"
source $::env(SCRIPTS_DIR)/load.tcl
erase_non_stage_variables cts
load_design 4_1_cts.odb 4_1_cts.sdc

puts "=========================================================================="
puts "Two phase mode: Building clock tree for clk_2"
puts "--------------------------------------------------------------------------"

set cts_clk_2_args [list \
  -sink_clustering_enable \
  -balance_levels \
  -repair_clock_nets \
  -clk_nets clk_2 \
  -dont_use_dummy_load
  ]

append_env_var cts_clk_2_args CTS_BUF_DISTANCE -distance_between_buffers 1
append_env_var cts_clk_2_args CTS_CLUSTER_SIZE -sink_clustering_size 1
append_env_var cts_clk_2_args CTS_CLUSTER_DIAMETER -sink_clustering_max_diameter 1
append_env_var cts_clk_2_args CTS_BUF_LIST -buf_list 1
append_env_var cts_clk_2_args CTS_LIB_NAME -library 1

if { [env_var_exists_and_non_empty CTS_ARGS] } {
  set cts_clk_2_args $::env(CTS_ARGS)
}

set_dont_use $::env(DONT_USE_CELLS)

log_cmd clock_tree_synthesis {*}$cts_clk_2_args

detailed_placement

estimate_parasitics -placement

# report_two_phase_metrics 4 "cts clk_2 complete" "clk_2"

puts "report_clock_skew test"
puts "===================="
report_clock_skew

puts "\nreport_clock_skew -clock clk_2 test"
puts "===================="
report_clock_skew -clock clk_2

puts "\nreport_clock_skew -setup -clock clk_2 test"
puts "===================="
report_clock_skew -setup -clock clk_2

puts "\nreport_clock_skew -hold -clock clk_2"
puts "===================="
report_clock_skew -hold -clock clk_2

write_db $::env(RESULTS_DIR)/4_2_cts.odb
write_sdc -no_timestamp $::env(RESULTS_DIR)/4_2_cts.sdc
