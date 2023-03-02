-- LCS-2016-006f: Expose standard conditional analysis identifiers
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_006f
use std.env.all ;

entity e006f is
end entity ;

architecture arch of e006f is

begin

    tb : process
    begin
        report VHDL_VERSION ;
        report TOOL_TYPE ;
        report TOOL_VENDOR ;
        report TOOL_NAME ;
        report TOOL_EDITION ;
        report TOOL_VERSION ;
        wait ;
    end process ;

end architecture ;

--

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_standard_conditional_analysis_identifiers is
  generic ( runner_cfg : string );
end entity;

architecture tb of tb_standard_conditional_analysis_identifiers is
begin
  U_e006f : entity work.e006f ;
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    info("LCS-2016-006f: Expose standard conditional analysis identifiers");
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
