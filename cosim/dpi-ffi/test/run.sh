#!/usr/bin/env sh

set -e

cd $(dirname "$0")

echo "> Analyze tb_VHDPI_Test.vhd"
ghdl -a --std=08 -O0 -g tb_VHDPI_Test.vhd

echo "> Build tb (with VHDPI_Test.c and headers)"
ghdl -e --std=08 -O0 -g -Wl,-I../ -Wl,VHDPI_Test.c -o tb_VHDPI_Test tb_VHDPI_Test

echo "> Execute tb"
./tb_VHDPI_Test
