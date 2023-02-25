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
        file f : text ;
    begin
        file_open(f, fname, READ_WRITE_MODE) ;
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
        std.env.stop ;
    end process ;

end architecture ;
