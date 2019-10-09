from os.path import join, dirname
from fnmatch import fnmatch
from functools import reduce
from vunit import VUnit, VUnitCLI
from vunit.simulator_factory import SIMULATOR_FACTORY
from vunit.test_report import TestReport, PASSED, FAILED
from vunit import ostools


def add_testbenches(ui):
    vhdl_2008 = ui.add_library("vhdl_2008")
    vhdl_2019 = ui.add_library("vhdl_2019")
    vhdl_2008.add_source_files(join(root, "vhdl_2008", "*.vhd"))
    vhdl_2019.add_source_files(join(root, "vhdl_2019", "*.vhd"))

    return vhdl_2008.get_test_benches() + vhdl_2019.get_test_benches()


def match(name, patterns):
    return reduce(
        lambda found_match, pattern: found_match | fnmatch(name, pattern),
        patterns,
        False,
    )


root = dirname(__file__)
vhdl_standard = (
    "2019" if SIMULATOR_FACTORY.select_simulator().name == "rivierapro" else "2008"
)

# Find all testbenches
cli = VUnitCLI()
args = cli.parse_args()
args.minimal = True
original_test_patterns = args.test_patterns
ui = VUnit.from_args(args)
testbenches = add_testbenches(ui)

# Run all tests in isolation to handle failure to compile
test_report = TestReport()
n_tests = 0
total_start_time = ostools.get_time()
for tb in testbenches:
    tests = tb.get_tests()
    if not tests:
        test_names = ["all"]
    else:
        test_names = [test.name for test in tests]

    for test_name in test_names:
        full_test_name = "%s.%s.%s" % (tb.library.name, tb.name, test_name)
        if not match(full_test_name, original_test_patterns):
            continue

        test_start_time = ostools.get_time()
        n_tests += 1
        args.test_patterns = [full_test_name]
        ui = VUnit.from_args(args, vhdl_standard=vhdl_standard)
        add_testbenches(ui)

        try:
            ui.main()
        except SystemExit as ex:
            tb_time = ostools.get_time() - test_start_time
            if ex.code == 0:
                test_report.add_result(full_test_name, PASSED, tb_time, None)
            else:
                test_report.add_result(full_test_name, FAILED, tb_time, None)

print("\nCompliance test completed:\n")
test_report.set_expected_num_tests(n_tests)
test_report.set_real_total_time(ostools.get_time() - total_start_time)
test_report.print_str()
