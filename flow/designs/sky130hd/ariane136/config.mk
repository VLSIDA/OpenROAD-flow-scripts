export DESIGN_NAME = ariane
export DESIGN_NICKNAME = ariane136
export PLATFORM    = sky130hd

export SYNTH_HIERARCHICAL = 1

# RTL_MP Settings
export RTLMP_MAX_INST = 30000
export RTLMP_MIN_INST = 5000
export RTLMP_MAX_MACRO = 16
export RTLMP_MIN_MACRO = 4
export RTLMP_SIGNATURE_NET_THRESHOLD = 30

export VERILOG_FILES = $(DESIGN_HOME)/src/$(DESIGN_NICKNAME)/ariane.sv2v.v \
                       $(DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)/macros.v

export SDC_FILE      = $(DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)/constraint.sdc

export ADDITIONAL_LEFS = $(PLATFORM_DIR)/lef/fakeram130_256x16.lef

export ADDITIONAL_LIBS = $(PLATFORM_DIR)/lib/fakeram130_256x16.lib

export DIE_AREA    = 0 0 5000 5000
export CORE_AREA   = 10 10 4990 4990

export IO_CONSTRAINTS = $(DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)/io.tcl

export MACRO_PLACE_HALO = 10 10

export TNS_END_PERCENT = 100
export PLACE_DENSITY = 0.35
