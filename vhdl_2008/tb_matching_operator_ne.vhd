library vunit_lib;
context vunit_lib.vunit_context;
library ieee;
use ieee.std_logic_1164.all;

entity tb_matching_operators_ne is
  generic ( runner_cfg : string := runner_cfg_default);
end entity tb_matching_operators_ne;

architecture tb of tb_matching_operators_ne is
begin
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);

    while test_suite loop
      if run("Test matching inequality between same values") then
        check_equal('1' ?/= '1', '0');
      elsif run("Test matching inequality between different values") then
        check_equal('1' ?/= '0', '1');
      elsif run("Testing matching inequality between values with different drive strength") then
        check_equal('1' ?/= 'H', '0');
      elsif run("Testing matching inequality with -") then
        check_equal('1' ?/= '-', '0');
      elsif run("Testing matching inequality with X") then
        check_equal('1' ?/= 'X', 'X');
      elsif run("Testing matching inequality with W") then
        check_equal('1' ?/= 'W', 'X');
      elsif run("Testing matching inequality with Z") then
        check_equal('1' ?/= 'Z', 'X');
      elsif run("Testing matching inequality with U") then
        check_equal('1' ?/= 'U', 'U');
      end if;
    end loop;

    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
