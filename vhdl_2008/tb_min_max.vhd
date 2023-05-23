library vunit_lib;
context vunit_lib.vunit_context;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_min_max is
  generic ( runner_cfg : string );
end entity tb_min_max;

architecture tb of tb_min_max is
  function min_max(vec : unsigned(3 downto 0); check_max : boolean) return unsigned is
    variable res : unsigned(3 downto 0);
    variable ref_value : unsigned(3 downto 0) := "1100";
  begin
    if check_max = true then
        res := maximum(vec, ref_value);
    else
        res := minimum(vec, ref_value);
    end if;
    return res;
  end function;
begin
  test_runner: process is
    variable test_value : unsigned(3 downto 0) := "1111";
    variable ref_value : unsigned(3 downto 0) := "1100";
  begin
    test_runner_setup(runner, runner_cfg);
    check_equal( min_max(test_value,true), test_value ) ;
    check_equal( min_max(test_value,false), ref_value ) ;
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;