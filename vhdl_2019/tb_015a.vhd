-- LCS-2016-015a: Standard functions to report current file name
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_015a
entity e015a is
end entity ;

architecture arch of e015a is

    use std.env.all ;

begin

    tb : process
    begin
        assert FILE_NAME /= "" severity failure ;
        assert FILE_PATH /= "" severity failure ;
        assert FILE_LINE /= "" severity failure ;
        wait ;
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
  U_e015a : entity work.e015a ;
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    info("LCS-2016-015a: Standard functions to report current file name/line/path");
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
