set design gcd
set base_dir "/OpenROAD-flow-scripts/flow"

read_lib $base_dir/platforms/sky130hd/lib/sky130_fd_sc_hd__tt_025C_1v80.lib


read_db $base_dir/results/sky130hd/$design/base/3_place.odb
#read_spef $base_dir/results/sky130hd/$design/base/6_final.spef
read_sdc $base_dir/results/sky130hd/$design/base/3_place.sdc
