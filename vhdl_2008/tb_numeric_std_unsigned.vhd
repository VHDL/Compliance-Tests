library vunit_lib;
context vunit_lib.vunit_context;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.to_unsigned;
use ieee.numeric_std_unsigned.all;

entity tb_numeric_std_unsigned is
  generic (
    runner_cfg : runner_cfg_t);
end entity;

architecture tb of tb_numeric_std_unsigned is
begin
  test_runner: process is
    constant a          : integer := 2;
    constant b          : integer := 5;
    variable a_slv      : std_logic_vector(3 downto 0) := std_logic_vector(to_unsigned(a, 4));
    variable b_slv      : std_logic_vector(3 downto 0) := std_logic_vector(to_unsigned(b, 4));
    variable result_slv : std_logic_vector(3 downto 0) := "0000";
  begin
    test_runner_setup(runner, runner_cfg);

    while test_suite loop

      -- Note modulus to wrap around on boundaries - negative values not possible
      if run("Test increment std_logic_vector") then
        result_slv := a_slv + 1;
        check_equal(to_integer(result_slv), (a + 1) mod 16);
      elsif run("Test add std_logic_vector") then
        result_slv := a_slv + b_slv;
        check_equal(to_integer(result_slv), (a + b) mod 16);
      elsif run("Test subtract std_logic_vector") then
        result_slv := a_slv - b_slv;
        check_equal(to_integer(result_slv), (a - b) mod 16);
      end if;

    end loop;

    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
