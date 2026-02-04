TOP = stopwatch_top
RTL_DIR = ../rtl

VERILATOR_FLAGS = -Wall --cc --exe --build

SRC = \
	$(RTL_DIR)/stopwatch_top.v \
	$(RTL_DIR)/control_fsm.v \
	$(RTL_DIR)/seconds_counter.v \
	$(RTL_DIR)/minutes_counter.v \
	main.cpp

all:
	verilator $(VERILATOR_FLAGS) $(SRC) --top-module $(TOP)

run:
	./obj_dir/V$(TOP)

clean:
	rm -rf obj_dir *.log
