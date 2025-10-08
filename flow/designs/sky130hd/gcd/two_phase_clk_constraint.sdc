############### Preliminaries ###############

current_design gcd

set clk_period [expr 3 * 1.1]
set clk_io_pct 0.2
set duty_cycle 0.4

set clk_1_rise 0.0
set clk_1_fall [expr {$clk_period * $duty_cycle}]
set clk_2_rise [expr {$clk_period / 2}]
set clk_2_fall [expr ($clk_period / 2) + ($clk_period * $duty_cycle)]

set clk_1_waveform_list {}
lappend clk_1_waveform_list $clk_1_rise
lappend clk_1_waveform_list $clk_1_fall

set clk_2_waveform_list {}
lappend clk_2_waveform_list $clk_2_rise
lappend clk_2_waveform_list $clk_2_fall


############### Set up default clock ###############

set default_clk_name default_clk

create_clock -name $default_clk_name -period $clk_period


############### Set up clock 1 ###############

set clk_1_name clk_1
set clk_1_port_name clk_1

set clk_1_port [get_ports $clk_1_port_name]

create_clock -name $clk_1_name -period $clk_period $clk_1_port -waveform $clk_1_waveform_list


############### Set up clock 2 ###############

set clk_2_name clk_2
set clk_2_port_name clk_2

set clk_2_port [get_ports $clk_2_port_name]

create_clock -name $clk_2_name -period $clk_period $clk_2_port -waveform $clk_2_waveform_list


############### Create non-clock inputs ###############

set non_clock_inputs [all_inputs -no_clocks]


############### Set input and output delays ###############

set_input_delay [expr $clk_period * $clk_io_pct] -clock $default_clk_name $non_clock_inputs
set_output_delay [expr $clk_period * $clk_io_pct] -clock $default_clk_name [all_outputs]


############### Set up constraints for setup and hold checks ###############

set_multicycle_path 2 -setup -from [get_clocks $default_clk_name] -to [get_clocks $clk_1_name]
set_multicycle_path 2 -setup -from [get_clocks $clk_2_name] -to [get_clocks $default_clk_name]

set_multicycle_path 1 -hold -from [get_clocks $default_clk_name] -to [get_clocks $clk_1_name]
set_multicycle_path 1 -hold -from [get_clocks $clk_2_name] -to [get_clocks $default_clk_name]
