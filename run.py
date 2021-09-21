#!/usr/bin/env python3

from os.path import join, dirname
from vunit import VUnit, VUnitCLI
from vunit.sim_if.factory import SIMULATOR_FACTORY
from run_support import run_with_compile_errors

root = dirname(__file__)

vhdl_standard = (
    "2019" if SIMULATOR_FACTORY.select_simulator().name == "rivierapro" else "2008"
)

args = VUnitCLI().parse_args()

# keep_going is a planned VUnit feature which adds support for dealing with testbenches
# that don't compile
if "keep_going" in args:
    args.keep_going = True

ui = VUnit.from_args(args, vhdl_standard=vhdl_standard)
vhdl_2008 = ui.add_library("vhdl_2008")
vhdl_2019 = ui.add_library("vhdl_2019")
vhdl_2008.add_source_files(join(root, "vhdl_2008", "*.vhd"))
vhdl_2019.add_source_files(join(root, "vhdl_2019", "*.vhd"))

if "keep_going" in args:
    ui.main()
else:
    # Workaround while keep_going isn't supported
    run_with_compile_errors(ui, args, vhdl_standard)
