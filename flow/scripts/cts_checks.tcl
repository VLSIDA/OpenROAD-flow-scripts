utl::set_metrics_stage "cts__checks"
source $::env(SCRIPTS_DIR)/load.tcl
erase_non_stage_variables cts
load_design 4_2_cts.odb 4_2_cts.sdc

# load appropiate designs for final checking
puts "=========================================================================="
puts "Running CTS checks and repair for two-phase clocking"
puts "--------------------------------------------------------------------------"

proc save_progress { stage } {
  puts "Run 'make gui_$stage.odb' to load progress snapshot"
  write_db $::env(RESULTS_DIR)/$stage.odb
  write_sdc -no_timestamp $::env(RESULTS_DIR)/$stage.sdc
}

# pre-repair
utl::push_metrics_stage "cts__{}__pre_repair_timing"
estimate_parasitics -placement
if { $::env(DETAILED_METRICS) } {
  report_metrics 4 "cts pre-repair-timing"
}
utl::pop_metrics_stage

# detailed placement variables
set_placement_padding -global \
  -left $::env(CELL_PAD_IN_SITES_DETAIL_PLACEMENT) \
  -right $::env(CELL_PAD_IN_SITES_DETAIL_PLACEMENT)
detailed_placement

estimate_parasitics -placement

if { [env_var_equals CTS_SNAPSHOTS 1] } {
  save_progress 4_pre_repair_hold_setup
}

# Repair timing
if { ![env_var_equals SKIP_CTS_REPAIR_TIMING 1] } {
  # equivalence check before repair
  if { $::env(EQUIVALENCE_CHECK) } {
    puts "\[INFO\] write_eqy_verilog 4_before_rsz.v"
    write_eqy_verilog 4_before_rsz.v
  }

  repair_timing_helper -setup -setup_margin 1 -hold -hold_margin 0.0 -max_repairs_per_pass 1

  # equivalence check after repair
  if { $::env(EQUIVALENCE_CHECK) } {
    puts "\[INFO\] run_equivalence_test"
    run_equivalence_test
  }

  set result [catch { detailed_placement } msg]
  if { $result != 0 } {
    save_progress 4_error
    puts "Detailed placement failed in CTS: $msg"
    exit $result
  }

  check_placement -verbose
}

report_metrics 4 "cts final"

source_env_var_if_exists POST_CTS_TCL

write_db $::env(RESULTS_DIR)/4_3_cts.odb
write_sdc -no_timestamp $::env(RESULTS_DIR)/4_cts.sdc
