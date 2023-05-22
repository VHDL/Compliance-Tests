#!/usr/bin/env python3

from os import environ
from pathlib import Path
from vunit import VUnit


# CI utilities

isGHA: bool = "GITHUB_ACTIONS" in environ

def GHASummary(content: str):
    if not isGHA:
        print("· Printing GHA summary skipped")
        return
    with open(Path(environ["GITHUB_STEP_SUMMARY"]), "a") as wfptr:
        wfptr.write(content)

def post_func(results):
    report = results.get_report()
    GHASummary(f'''\
Output path: {report.output_path!s}
Failed tests:
''')
    for key, test in report.tests.items():
        if test.status == 'failed':
            GHASummary(f'- {key!s}\n')

# ---


root = Path(__file__).resolve().parent

# Hint:
#   VUnit supports adding custom CLI arguments.
#   See http://vunit.github.io/py/ui.html#adding-custom-command-line-arguments.

ui = VUnit.from_argv(vhdl_standard="2008")

if ui.get_simulator_name() in [
    "activehdl",
    "nvc",
    "rivierapro",
]:
    ui = VUnit.from_argv(vhdl_standard="2019")

print(f"Using VHDL-{ui.vhdl_standard}")

ui.add_vhdl_builtins()

for std in ["2008", "2019"]:
    lib = f"vhdl_{std}"
    ui.add_library(lib).add_source_files(root / lib / "*.vhd")

# The VHDL-2019 call path feature doesn't work well with Aldec's simulators
# unless the code is compiled with the debug option.
ui.set_compile_option("rivierapro.vcom_flags", ["-dbg"])
ui.set_compile_option("activehdl.vcom_flags", ["-dbg"])

# Prevent PSL errors from failing the simulation but allow the VHDL assertion verifying the
# PSL functionality to fail with severity failure
ui.library("vhdl_2019").test_bench("tb_api_and_attributes_for_psl").set_sim_option("vhdl_assert_stop_level", "failure")

# Mark a test run as successful even if failing tests are found.
try:
    ui.main(post_run=post_func)
except SystemExit:
    pass
