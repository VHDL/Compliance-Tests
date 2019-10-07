from os.path import join, dirname
from vunit import VUnit, VUnitCLI
from vunit.simulator_factory import SIMULATOR_FACTORY
from vunit.test_report import TestReport, PASSED, FAILED

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

# Run all testbenches in isolation to handle failure to compile
test_report = TestReport()
test_report.set_expected_num_tests(len(lib.get_test_benches()))

for tb in lib.get_test_benches():
    args.test_patterns = ["*%s*" % tb.name]
    ui = VUnit.from_args(args, vhdl_standard=vhdl_standard)
    lib = ui.add_library("lib")
    lib.add_source_files(join(root, "*.vhd"))

    try:
        ui.main()
    except SystemExit as ex:
        if ex.code == 0:
            test_report.add_result(tb.name, PASSED, 0, None)
        else:
            test_report.add_result(tb.name, FAILED, 0, None)

print("\nCompliance test completed:\n")
test_report.print_str()
