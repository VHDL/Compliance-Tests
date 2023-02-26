-- LCS-2016-011: Date/Time Functions
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_011

use std.env.all ;
use std.textio.all ;

entity e011 is
end entity ;

architecture arch of e011 is

    constant BUILD_REC : time_record := GMTIME ;

begin

    tb : process
        variable l : line ;
        variable start_time : real ;
        variable elapsed_time : real ;
    begin
        start_time := epoch ;
        write(l, "Local Time        : " & to_string(LOCALTIME)&LF) ;
        write(l, "Local Time+       : " & to_string(LOCALTIME,5)&LF) ;
        write(l, "Local Epoch Time  : " & to_string(LOCALTIME(start_time))&LF) ;
        write(l, "Local GM Time     : " & to_string(LOCALTIME(GMTIME))&LF) ;
        write(l, "GM Time           : " & to_string(GMTIME)&LF) ;
        write(l, "GM Epoch Time     : " & to_string(GMTIME(start_time))&LF) ;
        write(l, "GM Local TIme     : " & to_string(GMTIME(LOCALTIME))&LF) ;
        elapsed_time := epoch - start_time ;
        write(l, "Test duration     : " & to_string(elapsed_time) & " seconds") ;
        writeline(output, l) ;
        std.env.stop ;
    end process ;

end architecture ;

--

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_date_time_functions is
  generic ( runner_cfg : string );
end entity;

architecture tb of tb_date_time_functions is
begin
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    info("LCS-2016-011: Date/Time Functions");
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
