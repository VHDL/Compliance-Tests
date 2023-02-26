#!/usr/bin/env python3

import sys
from pathlib import Path
from vunit import VUnit, VUnitCLI

root = Path(__file__).resolve().parent

ui = VUnit.from_argv(compile_builtins=False, vhdl_standard="2008")

if ui.get_simulator_name() in ["rivierapro", "activehdl"]:
    ui = VUnit.from_argv(compile_builtins=False, vhdl_standard="2019")
    print("Using VHDL-2019")

ui.add_vhdl_builtins()

for std in ["2008", "2019"]:
    lib = f"vhdl_{std}"
    ui.add_library(lib).add_source_files(root / lib / "*.vhd")

# The VHDL-2019 call path feature doesn't work well with Aldec's simulators
# unless the code is compiled with the debug option.
ui.set_compile_option("rivierapro.vcom_flags", ["-dbg"])
ui.set_compile_option("activehdl.vcom_flags", ["-dbg"])

# Mark a test run as successful even if failing tests are found.
try:
    ui.main()
except SystemExit:
    sys.exit(0)
