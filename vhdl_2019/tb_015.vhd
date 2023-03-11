-- LCS-2016-015: Standard functions to report calling path
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_015
entity e015 is
end entity ;

architecture arch of e015 is

    use std.env.all ;

begin

    tb : process
        variable  path : call_path_vector_ptr ;
    begin
        path := get_call_path ;
        for idx in path'range loop
            -- NOTE: Riviera-PRO needs -dbg flag during vcom for this string to be populated correctly
            assert to_string(path(idx))             /= "" severity failure ;
            assert path(idx).name.all               /= "" severity failure ;
            assert path(idx).file_name.all          /= "" severity failure ;
            assert path(idx).file_path.all          /= "" severity failure ;
            assert to_string(path(idx).file_line)   /= "" severity failure ;
        end loop ;
        wait ;
    end process ;

end architecture ;

--

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_report_calling_path is
  generic ( runner_cfg : string := runner_cfg_default);
end entity;

architecture tb of tb_report_calling_path is
begin
  U_e015 : entity work.e015 ;
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    info("LCS-2016-015: Standard functions to report calling path");
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
