-- LCS-2016-043: API and Attributes for PSL
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_043

library ieee;
use ieee.std_logic_1164.all;

entity e011 is
end entity ;

architecture arch of e011 is

  signal clk, req, grant : std_logic := '0';
  signal rst : std_logic := '1';

  default clock is rising_edge(clk);

begin

  clk <= not clk after 5 ns;

  reset : process is
  begin
    wait until rising_edge(clk);
    wait until rising_edge(clk);
    rst <= '0';
    wait;
  end process;

  stimuli : process is
  begin
    wait until rising_edge(clk) and rst = '0';
    req <= '1';
    wait until rising_edge(clk);
    req <= '0';
    wait until rising_edge(clk);
    wait;
  end process;

  arbiter: process is
  begin
    wait until rising_edge(clk);
    if (rst) then
      grant <= '0';
    else
      grant <= req;
    end if;
  end process arbiter;

  property req_grant_p is always (req -> next(not grant));
  sequence req_grant_s is {req; grant};

  assert_d : assert req_grant_p;
  cover_d : cover req_grant_s report "Covered";
  assume_d : assume req_grant_p;
  restrict_d : restrict {rst[*3]; not rst}[+];

end architecture arch;

--

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_api_and_attributes_for_psl is
  generic ( runner_cfg : string );
end entity;

architecture tb of tb_api_and_attributes_for_psl is
begin
  U_e011 : entity work.e011;
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    error("LCS-2016-043: API and Attributes for PSL");
    test_runner_cleanup(runner);
    wait;
  end process test_runner;

end architecture tb;
