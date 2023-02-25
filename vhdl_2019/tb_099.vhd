-- LCS-2016-099: Extended Ranges
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_099
-- TODO
entity e099 is
end entity ;

architecture arch of e099 is

    subtype natural_range_record is natural'range'record ;

    signal a : bit_vector(7 downto 0) ;

    constant r : natural_range_record := a'range'value ;

    signal x : bit_vector(r) ;

    constant r2 : natural_range_record := (
        direction => descending,
        left => 30,
        right => 0
    ) ;

    signal y : bit_vector(r2) ;

begin

    tb : process
    begin
        std.env.stop ;
    end process ;

end architecture ;
