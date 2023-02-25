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
            report "call path   : " & to_string(path(idx)) ;
            report "  name      : " & path(idx).name.all ;
            report "  file_name : " & path(idx).file_name.all ;
            report "  file_path : " & path(idx).file_path.all ;
            report "  file_line : " & to_string(path(idx).file_line) ;
        end loop ;
        stop ;
    end process ;

end architecture ;
