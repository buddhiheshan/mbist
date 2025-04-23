#!/bin/bash

DUT=$1.sv
TB=tests/tb_$1.sv

vcs -full64 -kdb -sverilog $DUT $TB -lca -debug_access+all
./simv
