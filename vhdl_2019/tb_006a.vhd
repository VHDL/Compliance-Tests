-- LCS-2016-006a: File IO/TextIO Updates
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_006a

use std.textio.all ;

entity e006a is
end entity ;

architecture arch of e006a is

    use std.textio.all ;

begin

    tb : process
        constant fname : string := "test006a.txt";
        variable status : file_open_status ;
        file f : text ;
    begin
        `if MODE="CHECK_STATUS" then
            -- Works in Riviera-PRO
            file_open(status, f, fname, READ_WRITE_MODE) ;
            if status /= OPEN_OK then
                report "Could not open " & fname ;
                wait ;
            end if ;
        `else
            -- Doesn't work in Riviera-PRO
            file_open(f, fname, READ_WRITE_MODE);
        `end
        report "  state     : " & to_string(file_state(f)) ;
        report "  mode      : " & to_string(file_mode(f)) ;
        report "  size      : " & to_string(file_size(f)) ;
        report "  canseek   : " & to_string(file_canseek(f)) ;
        report "  position  : " & to_string(file_position(f)) ;
        if file_canseek(f) = true then
            file_seek(f, file_size(f)) ;
            report "  position  : " & to_string(file_position(f)) ;
            file_rewind(f) ;
            report "  position  : " & to_string(file_position(f)) ;
        end if ;
        file_truncate(f, file_size(f)*2) ;
        report "  size      : " & to_string(file_size(f)) ;
        file_close(f) ;
        report "  state     : " & to_string(file_state(f)) ;
        wait ;
    end process ;

end architecture ;

--

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_fileio_textio_updates is
  generic ( runner_cfg : string );
end entity;

architecture tb of tb_fileio_textio_updates is
begin
  U_e006a : entity work.e006a ;
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    info("LCS-2016-006a: File IO/Text IO Updates");
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
