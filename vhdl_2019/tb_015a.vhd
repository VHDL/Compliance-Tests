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
