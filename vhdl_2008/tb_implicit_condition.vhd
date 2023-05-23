library vunit_lib;
context vunit_lib.vunit_context;
library ieee;
use ieee.std_logic_1164.all;

entity tb_implicit_condition is
  generic ( runner_cfg : string );
end entity tb_implicit_condition;

architecture tb of tb_implicit_condition is
  function check_case(x : std_logic) return boolean is
  begin
    if x then
        return true;
    else
        return false;
    end if;
  end function;
begin
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    check_equal( check_case('1'), true ) ;
    check_equal( check_case('0'), false) ;
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
