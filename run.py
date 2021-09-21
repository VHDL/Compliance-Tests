#!/usr/bin/env python3

from vunit import VUnitCLI
from vunit.sim_if.factory import SIMULATOR_FACTORY

# To workaround while keep_going isn't supported
from pathlib import Path
from vunit import VUnit
from fnmatch import fnmatch
from functools import reduce
from vunit.test.report import TestReport, PASSED, FAILED
from vunit import ostools


ROOT = Path(__file__).resolve().parent


def vunit_from_args(args, vhdl_standard):
    ui = VUnit.from_args(args, vhdl_standard=vhdl_standard)
    for std in ["2008", "2019"]:
        lib = f"vhdl_{std}"
        ui.add_library(lib).add_source_files(ROOT / lib / "*.vhd")
    return ui


vhdl_standard = "2019" if SIMULATOR_FACTORY.select_simulator().name == "rivierapro" else "2008"
args = VUnitCLI().parse_args()
ui = vunit_from_args(args, vhdl_standard)

# Run all tests in isolation to handle failure to compile
args.minimal = True
original_test_patterns = args.test_patterns
test_report = TestReport()
n_tests = 0
total_start_time = ostools.get_time()
for tb in (
    ui.library("vhdl_2008").get_test_benches()
    + ui.library("vhdl_2019").get_test_benches()
):
    tests = tb.get_tests()
    for test_name in [test.name for test in tests] if tests else ["all"]:
        full_test_name = f"{tb.library.name!s}.{tb.name!s}.{test_name!s}"
        if not reduce(
            lambda found_match, pattern: found_match | fnmatch(full_test_name, pattern),
            original_test_patterns,
            False,
        ):
            continue

        test_start_time = ostools.get_time()
        n_tests += 1
        args.test_patterns = [full_test_name]

        ui = vunit_from_args(args, vhdl_standard)

        try:
            ui.main()
        except SystemExit as ex:
            test_report.add_result(
                full_test_name,
                PASSED if ex.code == 0 else FAILED,
                ostools.get_time() - test_start_time,
                None
            )

print("\nCompliance test completed:\n")
test_report.set_expected_num_tests(n_tests)
test_report.set_real_total_time(ostools.get_time() - total_start_time)
test_report.print_str()
