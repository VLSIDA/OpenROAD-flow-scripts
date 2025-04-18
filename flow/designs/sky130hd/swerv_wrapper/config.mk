export DESIGN_NAME = swerv_wrapper
export PLATFORM    = sky130hd

# RTL_MP Settings
export RTLMP_MAX_INST = 30000
export RTLMP_MIN_INST = 5000
export RTLMP_MAX_MACRO = 12
export RTLMP_MIN_MACRO = 4 
export SYNTH_POWER_DEFINE = USE_POWER_PINS
export VERILOG_FILES = $(DESIGN_HOME)/src/swerv/swerv_wrapper.sv2v.v \
                       $(DESIGN_HOME)/$(PLATFORM)/swerv/macros.v
export SDC_FILE      = $(DESIGN_HOME)/$(PLATFORM)/swerv_wrapper/constraint.sdc

export ADDITIONAL_LEFS = $(PLATFORM_DIR)/lef/fakeram130_2048x39.lef \
                         $(PLATFORM_DIR)/lef/fakeram130_256x34.lef \
                         $(PLATFORM_DIR)/lef/fakeram130_64x21.lef

export ADDITIONAL_LIBS = $(PLATFORM_DIR)/lib/fakeram130_2048x39.lib \
                         $(PLATFORM_DIR)/lib/fakeram130_256x34.lib \
                         $(PLATFORM_DIR)/lib/fakeram130_64x21.lib

# WORKING, but core/die area can be minimized
export DIE_AREA    = 0 0 4300 4000
export CORE_AREA   = 10.2 10.6 4100 3900 

export IO_CONSTRAINTS = $(DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NAME)/io.tcl
export MACRO_PLACE_HALO = 50 50
export PL_MACRO_CHANNEL = 10 10
export PLACE_DENSITY_LB_ADDON = 0.10
export TNS_END_PERCENT        = 100

export FASTROUTE_TCL = $(DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NAME)/fastroute.tcl

export GPL_KEEP_OVERFLOW = 0
