#!/bin/bash

DUT=$1.sv
TB=tests/$1_tb.sv

vcs -full64 -kdb -sverilog $DUT $TB -lca -debug_access+all
./simv
