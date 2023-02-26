-- LCS-2016-015a: Standard functions to report current file name
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_015a
entity e015a is
end entity ;

architecture arch of e015a is

    use std.env.all ;

begin

    tb : process
    begin
        report "FILE_NAME: " & FILE_NAME ;
        report "FILE_PATH: " & FILE_PATH ;
        report "FILE_LINE: " & FILE_LINE ;
        stop ;
    end process ;

end architecture ;

--

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_report_current_file_name_line_path is
  generic ( runner_cfg : string );
end entity;

architecture tb of tb_report_current_file_name_line_path is
begin
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    info("LCS-2016-016a: Standard functions to report current file name/line/path");
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
