#!/bin/bash


DUT=$1.sv
TB=tests/tb_$1.sv

if [ $1 = "bist" ]; then
    vcs -full64 -kdb -sverilog sram.sv multiplexer.sv controller.sv comparator.sv decoder.sv counter.sv $DUT $TB -lca -debug_access+all
else
    vcs -full64 -kdb -sverilog $DUT $TB -lca -debug_access+all
fi

./simv
