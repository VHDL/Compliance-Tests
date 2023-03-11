-- LCS-2016-061: Conditional Compilation
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_061
use std.env.all ;
package pack061 is

    `if TOOL_TYPE = "SIMULATION" then
        constant simulator : string := TOOL_NAME ;
    `elsif TOOL_TYPE = "SYNTHESIS" then
        constant synthesizer : string := TOOL_NAME ;
    `end

end package ;

--

library vunit_lib;
context vunit_lib.vunit_context;

use work.pack061.all ;

entity tb_conditional_compilation is
  generic ( runner_cfg : string := runner_cfg_default);
end entity;

architecture tb of tb_conditional_compilation is
begin
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    info("LCS-2016-061: Conditional Compilation");
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
