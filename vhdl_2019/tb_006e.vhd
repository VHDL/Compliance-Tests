-- LCS-2016-006e: Allow access to system environment variables (baseline)
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_006e
--
-- The following environment variables must be configured before running
-- the test:
--    VHDL_TEST => Set to the string "hello world".
--    TOOL_NAME => Set to some string other than the value of STD.ENV.TOOL_NAME.
--    NOT_HERE => Must not be set.
--
use std.env.all;
use std.textio.all;

entity e006e is
end entity ;

architecture arch of e006e is
begin

    tb : process
        variable value : line;
    begin
        assert getenv("VHDL_TEST") = "hello world";
        value := getenv("VHDL_TEST");
        assert value.all = "hello world";

        -- "If the specified variable name is not defined at all in this
        --  environment, the return value will be the empty string ("")
        --  or the access value null, respectively."
        value := getenv("NOT_HERE");
        assert value = null;
        assert getenv("NOT_HERE") = "";

        -- "Conditional analysis identifiers (24.2) are part of the
        --  queried environment and take precedence over possibly
        --  inherited environment variables of identical names."
        value := getenv("TOOL_NAME");
        assert value.all = TOOL_NAME;
        assert getenv("VHDL_VERSION") = VHDL_VERSION;

        wait ;
    end process ;

end architecture ;

--

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_access_system_environment_variables is
  generic ( runner_cfg : string );
end entity;

architecture tb of tb_access_system_environment_variables is
begin
  U_e006e : entity work.e006e ;
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    info("LCS-2016-006e: Allow access to system environment variables (baseline)");
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
