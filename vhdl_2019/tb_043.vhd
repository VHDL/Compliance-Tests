-- LCS-2016-043: Attributes for PSL
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_043
-- TODO

--

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_attributes_for_psl is
  generic ( runner_cfg : string );
end entity;

architecture tb of tb_attributes_for_psl is
begin
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    error("LCS-2016-043: Attributes for PSL");
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
