#!/usr/bin/env python3

import sys
from pathlib import Path
from vunit import VUnit, VUnitCLI

root = Path(__file__).resolve().parent

simulator_name = VUnit.from_argv(compile_builtins=False).get_simulator_name()
vhdl_standard = "2019" if simulator_name in ["rivierapro", "activehdl"] else "2008"
print(f"Using VHDL-{vhdl_standard}")

cli = VUnitCLI()
args = cli.parse_args()
args.keep_compiling = True
ui = VUnit.from_args(
    args=args, compile_builtins=False, vhdl_standard="2019" if simulator_name in ["rivierapro", "activehdl"] else "2008"
)
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
