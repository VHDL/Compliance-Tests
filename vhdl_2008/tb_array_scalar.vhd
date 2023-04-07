library vunit_lib;
context vunit_lib.vunit_context;
library ieee;
use ieee.std_logic_1164.all;

entity tb_array_scalar is
  generic ( runner_cfg : string );
end entity tb_array_scalar;

architecture tb of tb_array_scalar is
  function mix_array_scalar(x : std_logic_vector; y : std_logic) return std_logic_vector is
  begin
    return (x xor y);
  end function;
  signal x : std_logic_vector(3 downto 0);
  signal y : std_logic;
  signal res : std_logic_vector(3 downto 0) := "0101";
begin
  test_runner: process is
  begin
    x <= "1010";
    y <= '1';
    test_runner_setup(runner, runner_cfg);
    check_equal( mix_array_scalar(x,y), res ) ;
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;