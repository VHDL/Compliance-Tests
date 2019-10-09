library vunit_lib;
context vunit_lib.vunit_context;

library ieee;
use ieee.std_logic_1164.all;

entity tb_psl is
  generic (
    runner_cfg : runner_cfg_t);
end entity tb_psl;

architecture tb of tb_psl is
  signal clk, req, grant : std_logic := '0';

  default clock is rising_edge(clk);
begin
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);

    wait until rising_edge(clk);
    req <= '1';
    wait until rising_edge(clk);
    req <= '0';
    wait until rising_edge(clk);

    test_runner_cleanup(runner);
    wait;
  end process test_runner;

  clk <= not clk after 5 ns;

  arbiter: process is
  begin
    wait until rising_edge(clk);
    grant <= req;
  end process arbiter;

  assert always (req -> next[1](grant));
  -- same as check_next(clk, check_enabled, req, grant);

end architecture tb;
