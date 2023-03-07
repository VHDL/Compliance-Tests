-- LCS-2016-023: Relax Library Requirement on Configurations
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_023
-- TODO

--

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_relax_library_requirement_on_configurations is
  generic ( runner_cfg : string );
end entity;

architecture tb of tb_relax_library_requirement_on_configurations is
begin
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    error("LCS-2016-023: Relax Library Requirement on Configurations");
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
