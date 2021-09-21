library vunit_lib;
context vunit_lib.vunit_context;
library ieee;
use ieee.std_logic_1164.all;

entity tb_matching_operators_le is
  generic ( runner_cfg : string );
end entity tb_matching_operators_le;

architecture tb of tb_matching_operators_le is
begin
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);

    while test_suite loop
      if run("Test matching less than or equal between same values") then
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
      end if;
    end loop;

    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
