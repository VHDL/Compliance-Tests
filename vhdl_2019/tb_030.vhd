-- LCS-2016-030: Garbage Collection
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_030
-- REVIEW
entity e030 is
end entity ;

architecture arch of e030 is

    impure function bigstring return std.textio.line is
    begin
        return new string(1 to 1000000) ;
    end function ;

begin

    tb : process
        variable l : std.textio.line ;
    begin
        for i in 1 to 1000000 loop
            l := bigstring ;
        end loop ;
        std.env.stop ;
    end process ;

end architecture ;
