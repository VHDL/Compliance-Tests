-- LCS-2016-043: API and Attributes for PSL
-- https://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_043
-- 1076-2019 sections: 16.2.7 (PSL attributes) and 16.5.8 (PSL API)

library ieee;
use ieee.std_logic_1164.all;

use std.env.all;

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
    grant <= '1';
    wait until rising_edge(clk);
    req <= '1';
    grant <= '0';
    wait until rising_edge(clk);
    req <= '0';
    wait until rising_edge(clk);
    wait;
  end process;

  -- PSL definitions & directives
  property req_grant_prop is always (req -> next(grant));
  sequence req_grant_seq is {req; grant};
  req_grant_assert : assert req_grant_prop;
  req_grant_cover : cover req_grant_seq report "Covered";
  req_grant_assume : assume req_grant_prop;
  rst_restrict : restrict {rst[*3]; not rst}[+];

  -- PSL attributes tests (1076-2019 16.2.7)
  pslattributes : process is
  begin
    wait until rising_edge(clk) and rst = '0';
    wait until rising_edge(clk);
    assert not rst_restrict'signal severity failure;
    -- Occurance of req -> next grant
    wait until req_grant_prop'event;
    -- Test p'event atributes
    assert req_grant_seq'event severity failure;
    assert req_grant_assert'event severity failure;
    assert req_grant_cover'event severity failure;
    -- Test p'signal attributes
    assert req_grant_assert'signal severity failure;
    assert req_grant_cover'signal severity failure;
    assert req_grant_assume'signal severity failure;
    -- Occurance of req -> next not grant
    wait until rising_edge(clk) and req = '1';
    wait until rising_edge(clk);
    assert not req_grant_assert'signal severity failure;
    assert not req_grant_assume'signal severity failure;
    wait;
  end process;

  -- PSL API tests (1076-2019 16.5.8)
  pslapi : process is
  begin
    -- Test return values after elaboration
    assert not PslAssertFailed severity failure;
    assert not PslIsCovered severity failure;
    assert not PslIsAssertCovered severity failure;
    -- Enable coverage of asserts
    SetPslCoverAssert;
    assert GetPslCoverAssert severity failure;
    -- Occurance of req -> next grant
    wait until rising_edge(clk) and grant = '1';
    assert not PslAssertFailed severity failure;
    assert PslIsCovered severity failure;
    assert PslIsAssertCovered severity failure;
    -- Occurance of req -> next not grant
    wait until rising_edge(clk) and req = '1';
    wait until rising_edge(clk);
    assert PslAssertFailed severity failure;
    -- Clear internal PSL state information
    ClearPslState;
    assert not PslAssertFailed severity failure;
    assert not PslIsCovered severity failure;
    assert not PslIsAssertCovered severity failure;
    wait;
  end process;

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
    info("LCS-2016-043: API and Attributes for PSL");
    test_runner_cleanup(runner);
    wait;
  end process test_runner;

end architecture tb;
