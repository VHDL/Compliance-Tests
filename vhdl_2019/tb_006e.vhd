-- LCS-2016-006e: Allow access to system environment variables (baseline)
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_006e
use std.env.all;
use std.textio.all;

entity e006e is
end entity ;

architecture arch of e006e is

    impure function GetConfig return boolean is
        file config : text;
        variable home, data : line;
        variable result : boolean;
    begin
        home := GETENV("HOME");
        assert home /= null report "No HOME environment variable";
        FILE_OPEN(config,
            home.all & DIR_SEPARATOR &
            ".config" & DIR_SEPARATOR &
            "myapp.txt",
            read_mode
        );
        READLINE(config, data);
        READ(data, result);
        FILE_CLOSE(config);
        return result;
    end function GetConfig;
begin

    tb : process
    begin
        report to_string(GetConfig) ;
        std.env.stop ;
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
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    info("LCS-2016-006e: Allow access to system environment variables (baseline)");
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
