from os.path import join, dirname
from vunit import VUnit, VUnitCLI
from vunit.simulator_factory import SIMULATOR_FACTORY
from vunit.test_report import TestReport, PASSED, FAILED
from vunit import ostools

root = dirname(__file__)
vhdl_standard = (
    "2019" if SIMULATOR_FACTORY.select_simulator().name == "rivierapro" else "2008"
)

# Find all testbenches
cli = VUnitCLI()
args = cli.parse_args()
args.minimal = True
ui = VUnit.from_args(args)
lib = ui.add_library("lib")
lib.add_source_files(join(root, "*.vhd"))

# Run all tests in isolation to handle failure to compile
test_report = TestReport()

total_start_time = ostools.get_time()
n_tests = 0
for tb in lib.get_test_benches():
    tests = tb.get_tests()
    if not tests:
        test_names = ["all"]
    else:
        test_names = [test.name for test in tests]

    for test_name in test_names:
        test_start_time = ostools.get_time()
        n_tests += 1
        full_test_name = "%s.%s.%s" % (tb.library.name, tb.name, test_name)
        args.test_patterns = [full_test_name]
        ui = VUnit.from_args(args, vhdl_standard=vhdl_standard)
        lib = ui.add_library("lib")
        lib.add_source_files(join(root, "*.vhd"))

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
