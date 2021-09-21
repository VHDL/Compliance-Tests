#!/usr/bin/env python3

from pathlib import Path
from vunit import VUnit, VUnitCLI
from vunit.sim_if.factory import SIMULATOR_FACTORY
from run_support import vunit_from_args, run_with_compile_errors

ROOT = Path(__file__).resolve().parent

vhdl_standard = (
    "2019" if SIMULATOR_FACTORY.select_simulator().name == "rivierapro" else "2008"
)

args = VUnitCLI().parse_args()

# keep_going is a planned VUnit feature which adds support for dealing with testbenches
# that don't compile
if "keep_going" in args:
    args.keep_going = True

UI = vunit_from_args(args, vhdl_standard)

if "keep_going" in args:
    UI.main()
else:
    # Workaround while keep_going isn't supported
    run_with_compile_errors(UI, args, vhdl_standard)
