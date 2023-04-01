library vunit_lib;
context vunit_lib.vunit_context;
library ieee;
use ieee.std_logic_1164.all;

entity tb_aggregate is
  generic ( runner_cfg : string );
end entity tb_aggregate;

architecture tb of tb_aggregate is
  function aggregate(x : std_logic_vector) return std_logic is
    variable temp : std_logic_vector(1 downto 0);
    variable temp2 : std_logic;
  begin
    (temp, temp2) := x;
    return temp2;
  end function;
begin
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    check_equal( aggregate("110"), '0' ) ;
    check_equal( aggregate("001"), '1' ) ;
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;