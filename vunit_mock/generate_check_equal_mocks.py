from pathlib import Path
from string import Template

api_template = """  procedure check_equal(
    constant got         : in $got_type;
    constant expected    : in $expected_type;
    constant msg         : in string := "");

"""

impl_template = """  procedure check_equal(
    constant got         : in $got_type;
    constant expected    : in $expected_type;
    constant msg         : in string := "") is
  begin
    assert got = expected report msg;
  end;

"""

combinations = [
    (
        "unsigned",
        "unsigned",
    ),
    (
        "unsigned",
        "natural",
    ),
    (
        "natural",
        "unsigned",
    ),
    (
        "std_logic_vector",
        "std_logic_vector",
    ),
    (
        "std_logic_vector",
        "natural",
    ),
    (
        "natural",
        "std_logic_vector",
    ),
    (
        "signed",
        "signed",
    ),
    (
        "signed",
        "integer",
    ),
    (
        "integer",
        "signed",
    ),
    (
        "integer",
        "integer",
    ),
    (
        "std_logic",
        "std_logic",
    ),
    (
        "boolean",
        "boolean",
    ),
    (
        "string",
        "string",
    ),
    (
        "character",
        "character",
    ),
    (
        "time",
        "time",
    ),
]


def generate_api():
    api = ""
    for c in combinations:
        t = Template(api_template)
        api += t.substitute(got_type=c[0], expected_type=c[1])
    return api


def generate_impl():
    impl = ""
    for c in combinations:
        t = Template(impl_template)
        impl += t.substitute(got_type=c[0], expected_type=c[1])
    return impl


def generate_package():
    package = """\
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.numeric_std_unsigned.all;

package check_equal_pkg is
"""
    package += generate_api()
    package += """\
end package;

package body check_equal_pkg is
"""
    package += generate_impl()
    package += """\
end package body;
"""
    return package


def main():
    check_equal_pkg = Path(__file__).parent / "check_equal_pkg.vhd"
    check_equal_pkg.write_text(generate_package())


if __name__ == "__main__":
    main()
