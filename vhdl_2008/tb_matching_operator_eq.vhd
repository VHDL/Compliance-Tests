library vunit_lib;
context vunit_lib.vunit_context;
library ieee;
use ieee.std_logic_1164.all;

entity tb_matching_operators_eq is
  generic ( runner_cfg : runner_cfg_t );
end entity tb_matching_operators_eq;

architecture tb of tb_matching_operators_eq is
begin
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);

    while test_suite loop
      if run("Test matching equality between same values") then
        check_equal('1' ?= '1', '1');
      elsif run("Test matching equality between different values") then
        check_equal('1' ?= '0', '0');
      elsif run("Testing matching equality between values with different drive strength") then
        check_equal('1' ?= 'H', '1');
      elsif run("Testing matching equality with -") then
        check_equal('1' ?= '-', '1');
      elsif run("Testing matching equality with X") then
        check_equal('1' ?= 'X', 'X');
      elsif run("Testing matching equality with W") then
        check_equal('1' ?= 'W', 'X');
      elsif run("Testing matching equality with Z") then
        check_equal('1' ?= 'Z', 'X');
      elsif run("Testing matching equality with U") then
        check_equal('1' ?= 'U', 'U');
      end if;
    end loop;

    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
