library vunit_lib;
context vunit_lib.vunit_context;

library ieee;
use ieee.std_logic_1164.all;
entity tb_matching_operators is
  generic (
    runner_cfg : runner_cfg_t);
end entity tb_matching_operators;

architecture tb of tb_matching_operators is
begin
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);

    while test_suite loop
      if run("Test matching equality between same values") then
        check_equal('1' ?= '1', '1');
      elsif run("Test matching equality between different values") then
        check_equal('1' ?= '1', '0');
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

      elsif run("Test matching inequality between same values") then
        check_equal('1' ?= '1', '0');
      elsif run("Test matching inequality between different values") then
        check_equal('1' ?= '1', '1');
      elsif run("Testing matching inequality between values with different drive strength") then
        check_equal('1' ?= 'H', '0');
      elsif run("Testing matching inequality with -") then
        check_equal('1' ?= '-', '1');
      elsif run("Testing matching inequality with X") then
        check_equal('1' ?= 'X', 'X');
      elsif run("Testing matching inequality with W") then
        check_equal('1' ?= 'W', 'X');
      elsif run("Testing matching inequality with Z") then
        check_equal('1' ?= 'Z', 'X');
      elsif run("Testing matching inequality with U") then
        check_equal('1' ?= 'U', 'U');

      elsif run("Test matching less than between same values") then
        check_equal('1' ?< '1', '0');
      elsif run("Test matching less than between a low and a high value") then
        check_equal('0' ?< '1', '1');
      elsif run("Test matching less than between a high and a low value") then
        check_equal('1' ?< '0', '0');
      elsif run("Testing matching less than between weak values") then
        check_equal('L' ?< 'H', '1');
      elsif run("Testing matching less than with X") then
        check_equal('1' ?< 'X', 'X');
      elsif run("Testing matching less than with W") then
        check_equal('1' ?< 'W', 'X');
      elsif run("Testing matching less than with Z") then
        check_equal('1' ?< 'Z', 'X');
      elsif run("Testing matching less than with U") then
        check_equal('1' ?< 'U', 'U');

      elsif run("Test matching less than or equal between same values") then
        check_equal('1' ?<= '1', '1');
      elsif run("Test matching less than or equal between a low and a high value") then
        check_equal('0' ?<= '1', '1');
      elsif run("Test matching less than or equal a between high and a low value") then
        check_equal('1' ?<= '0', '0');
      elsif run("Testing matching less than or equal between weak values") then
        check_equal('L' ?<= 'H', '1');
      elsif run("Testing matching less than or equal with X") then
        check_equal('1' ?<= 'X', 'X');
      elsif run("Testing matching less than or equal with W") then
        check_equal('1' ?<= 'W', 'X');
      elsif run("Testing matching less than or equal with Z") then
        check_equal('1' ?<= 'Z', 'X');
      elsif run("Testing matching less than or equal with U") then
        check_equal('1' ?<= 'U', 'U');

      elsif run("Test matching greater than between same values") then
        check_equal('1' ?> '1', '0');
      elsif run("Test matching greater than between a low and a high value") then
        check_equal('0' ?> '1', '0');
      elsif run("Test matching greater than between a high and a low value") then
        check_equal('1' ?> '0', '1');
      elsif run("Testing matching greater than between weak values") then
        check_equal('H' ?> 'L', '1');
      elsif run("Testing matching greater than with X") then
        check_equal('1' ?> 'X', 'X');
      elsif run("Testing matching greater than with W") then
        check_equal('1' ?> 'W', 'X');
      elsif run("Testing matching greater than with Z") then
        check_equal('1' ?> 'Z', 'X');
      elsif run("Testing matching greater than with U") then
        check_equal('1' ?> 'U', 'U');

      elsif run("Test matching greater than or equal between same values") then
        check_equal('1' ?>= '1', '1');
      elsif run("Test matching greater than or equal between a low and a high value") then
        check_equal('0' ?>= '1', '0');
      elsif run("Test matching greater than or equal a between high and a low value") then
        check_equal('1' ?>= '0', '1');
      elsif run("Testing matching greater than or equal between weak values") then
        check_equal('H' ?>= 'L', '1');
      elsif run("Testing matching greater than or equal with X") then
        check_equal('1' ?>= 'X', 'X');
      elsif run("Testing matching greater than or equal with W") then
        check_equal('1' ?>= 'W', 'X');
      elsif run("Testing matching greater than or equal with Z") then
        check_equal('1' ?>= 'Z', 'X');
      elsif run("Testing matching greater than or equal with U") then
        check_equal('1' ?>= 'U', 'U');
      end if;
    end loop;

    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
